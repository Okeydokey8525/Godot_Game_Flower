#!/usr/bin/env python3
"""Shared deterministic economy model for Plant Tales M4.2B.

This module is analysis-only.  It reads content JSON and models wallet cash flow;
it neither changes GDevelop events nor writes gameplay state.
"""

from __future__ import annotations

import json
import random
from collections import defaultdict
from pathlib import Path
from statistics import mean, median

PROJECT_ROOT = Path(__file__).resolve().parents[1]
CONTENT_DIR = PROJECT_ROOT / "Source" / "Content"
REPORT_DIR = PROJECT_ROOT / "Source" / "Data" / "Reports"
MANIFEST_PATH = CONTENT_DIR / "content_manifest.json"

GAME_MINUTES_PER_DAY = 1_440
DAY_START_HOUR = 6
MORNING_ACTION_MINUTE = 120  # 08:00, relative to the 06:00 day boundary
SLEEP_MINUTE = 960  # 22:00, relative to the 06:00 day boundary
RUN_COUNT = 50
BASE_SEED = 500_000

# M4.2B balance anchors, version 1.  These are authored policy constants, not
# observations derived from the flower dataset.  See Docs/BalanceRules/economy_balance.md.
NORMALIZED_ROI_LOWER_ANCHOR = 10.0
NORMALIZED_ROI_UPPER_ANCHOR = 95.0

SEASONS = ("Spring", "Summer", "Autumn", "Winter")
SEASON_TARGETS = {
    "Spring": (1_500, 3_500),
    "Summer": (4_000, 8_000),
    "Autumn": (9_000, 16_000),
    "Winter": (15_000, 25_000),
}
SPENDING_CATEGORIES = ("seeds", "tools", "shop", "festival", "upgrades", "other")
FOLDER_MAPPING = {
    "flowers": "Flowers", "npcs": "NPCs", "dialogues": "Dialogues",
    "quests": "Quests", "items": "Items", "weather": "Weather", "seasons": "Seasons",
}


def load_json(path: Path):
    with path.open(encoding="utf-8") as source:
        return json.load(source)


def load_content():
    """Load live manifest content, accepting the documented legacy time alias."""
    manifest = load_json(MANIFEST_PATH)
    flowers, seeds, quests = {}, {}, {}
    for category, filenames in manifest["content_groups"].items():
        folder = CONTENT_DIR / FOLDER_MAPPING[category]
        for filename in filenames:
            path = folder / filename
            if not path.exists():
                continue
            entry = load_json(path)
            if category == "flowers":
                flowers[entry["id"]] = entry
            elif category == "items" and entry.get("item_type") == "Seed":
                seeds[entry["id"]] = entry
            elif category == "quests":
                quests[entry["id"]] = entry
    return flowers, seeds, quests


def growth_minutes(flower):
    """Canonical field first; legacy alias remains read-compatible during migration."""
    return flower.get("growth_time", flower.get("growth_time_minutes"))


def sell_price(flower):
    return flower.get("sell_price", flower.get("base_sell_gold", 0))


def seed_lookup(seeds):
    return {seed["target_flower_id"]: seed for seed in seeds.values() if seed.get("target_flower_id")}


def normalized_roi_score(roi_per_day):
    raw = 100 * (roi_per_day - NORMALIZED_ROI_LOWER_ANCHOR) / (
        NORMALIZED_ROI_UPPER_ANCHOR - NORMALIZED_ROI_LOWER_ANCHOR
    )
    return round(max(0.0, min(100.0, raw)), 1)


def compute_roi_rows(flowers, seeds):
    """Analytical crop metrics only; never use these values as wallet income."""
    linked_seeds = seed_lookup(seeds)
    rows = []
    for flower_id, flower in flowers.items():
        minutes = growth_minutes(flower)
        seed = linked_seeds[flower_id]
        seed_cost = seed["buy_price"]
        price = sell_price(flower)
        growth_days = minutes / GAME_MINUTES_PER_DAY
        profit = price - seed_cost
        stamina = 5 + 3 * growth_days
        roi_per_day = profit / growth_days
        rows.append({
            "id": flower_id,
            "name": flower.get("display_name", flower_id),
            "rarity": flower.get("rarity", "Common"),
            "season": flower.get("favorite_season", "All"),
            "seed_cost": seed_cost,
            "sell_price": price,
            "growth_minutes": minutes,
            "growth_days": round(growth_days, 3),
            "profit": profit,
            "stamina_cost": round(stamina, 2),
            "roi": round(profit / seed_cost, 3),
            "roi_day": round(roi_per_day, 3),
            "roi_stamina": round(profit / stamina, 3),
            "roi_tile": round(roi_per_day, 3),
            "normalized_roi_score": normalized_roi_score(roi_per_day),
        })
    return sorted(rows, key=lambda row: row["normalized_roi_score"], reverse=True)


def available_flowers(flowers, season):
    # Retains the existing simulation's documented availability policy: Common
    # flowers are all-season fallbacks; specialised flowers are seasonal.
    return [
        flower for flower in flowers.values()
        if flower.get("rarity") == "Common"
        or flower.get("favorite_season", "").casefold() == season.casefold()
        or season.casefold() in {tag.casefold() for tag in flower.get("tags", [])}
    ]


def target_plant_count(season_index, rng):
    ranges = ((1, 3), (3, 5), (5, 8), (8, 12))
    low, high = ranges[season_index]
    return rng.randint(low, high)


def choose_flower(candidates, linked_seeds, gold, rng):
    affordable = [flower for flower in candidates if gold >= linked_seeds[flower["id"]]["buy_price"]]
    if not affordable:
        return None
    # Choice is ROI-weighted for the established automated-player assumption.
    weights = []
    for flower in affordable:
        minutes = growth_minutes(flower)
        profit = sell_price(flower) - linked_seeds[flower["id"]]["buy_price"]
        weights.append(max(0.1, profit / (minutes / GAME_MINUTES_PER_DAY)))
    return rng.choices(affordable, weights=weights, k=1)[0]


def simulate_run(run_id, flowers, seeds):
    """Model crop maturity and harvest cash flow for one deterministic player."""
    rng = random.Random(BASE_SEED + run_id * 1337)
    linked_seeds = seed_lookup(seeds)
    gold = 200
    pending_crops = []
    events = [{"event": "SESSION_START", "run_id": run_id, "seed": BASE_SEED + run_id * 1337,
               "gold_balance": gold}]
    seasonal_net = {}
    spending = defaultdict(int)
    money_earned = 0
    harvest_ages = []
    ready_waits = []

    def harvest_due(at_minute, global_day, season):
        nonlocal gold, money_earned, pending_crops
        due = [crop for crop in pending_crops if crop["ready_at"] <= at_minute]
        pending_crops = [crop for crop in pending_crops if crop["ready_at"] > at_minute]
        for crop in due:
            price = sell_price(crop["flower"])
            age = at_minute - crop["planted_at"]
            wait = at_minute - crop["ready_at"]
            gold += price
            money_earned += price
            harvest_ages.append(age)
            ready_waits.append(wait)
            events.append({
                "event": "CROP_HARVESTED", "run_id": run_id, "day": global_day, "season": season,
                "flower_id": crop["flower"]["id"], "gold_earned": price,
                "total_crop_age_minutes": age, "harvest_ready_wait_minutes": wait,
                "gold_balance": gold,
            })

    for season_index, season in enumerate(SEASONS):
        season_start_gold = gold
        candidates = available_flowers(flowers, season)
        for day_in_season in range(1, 29):
            global_day = season_index * 28 + day_in_season
            day_start = (global_day - 1) * GAME_MINUTES_PER_DAY
            morning = day_start + MORNING_ACTION_MINUTE
            sleep = day_start + SLEEP_MINUTE

            harvest_due(morning, global_day, season)
            for _ in range(target_plant_count(season_index, rng)):
                flower = choose_flower(candidates, linked_seeds, gold, rng)
                if flower is None:
                    break
                seed = linked_seeds[flower["id"]]
                gold -= seed["buy_price"]
                spending["seeds"] += seed["buy_price"]
                pending_crops.append({
                    "flower": flower, "planted_at": morning,
                    "ready_at": morning + growth_minutes(flower),
                })
                events.append({
                    "event": "GOLD_SPENT", "run_id": run_id, "day": global_day, "season": season,
                    "category": "seeds", "amount": seed["buy_price"], "flower_id": flower["id"],
                    "gold_balance": gold,
                })

            harvest_due(sleep, global_day, season)
            events.append({
                "event": "SLEEP_STARTED", "run_id": run_id, "day": global_day, "season": season,
                "gold_held": gold,
            })
            events.append({
                "event": "DAILY_SUMMARY", "run_id": run_id, "day": global_day, "season": season,
                "gold_balance": gold,
            })
        seasonal_net[season] = gold - season_start_gold

    spent = sum(spending.values())
    return {
        "events": events,
        "seasonal_net": seasonal_net,
        "money_earned": money_earned,
        "money_spent": spent,
        "spending": {category: spending[category] for category in SPENDING_CATEGORIES},
        "harvest_ages": harvest_ages,
        "ready_waits": ready_waits,
    }


def simulate_economy(flowers, seeds, run_count=RUN_COUNT):
    runs = [simulate_run(run_id, flowers, seeds) for run_id in range(1, run_count + 1)]
    seasonal = {
        season: round(mean(run["seasonal_net"][season] for run in runs), 2)
        for season in SEASONS
    }
    all_events = [event for run in runs for event in run["events"]]
    money_earned = sum(run["money_earned"] for run in runs)
    money_spent = sum(run["money_spent"] for run in runs)
    all_ages = [value for run in runs for value in run["harvest_ages"]]
    all_waits = [value for run in runs for value in run["ready_waits"]]
    checkpoints = {}
    for day in (1, 5, 10):
        values = [event["gold_held"] for event in all_events if event["event"] == "SLEEP_STARTED" and event["day"] == day]
        checkpoints[str(day)] = {"average": round(mean(values), 2), "median": round(median(values), 2)}
    spend_by_category = {
        category: sum(run["spending"][category] for run in runs) for category in SPENDING_CATEGORIES
    }
    return {
        "run_count": run_count,
        "events": all_events,
        "seasonal_net_gold": seasonal,
        "money_earned": money_earned,
        "money_spent": money_spent,
        "money_sink_ratio": round(money_spent / money_earned, 4) if money_earned else None,
        "spending_by_category": spend_by_category,
        "gold_held_before_sleep": {"checkpoints": checkpoints, "daily_event": "SLEEP_STARTED"},
        "crop_age_at_harvest": {
            "average_minutes": round(mean(all_ages), 2) if all_ages else None,
            "median_minutes": round(median(all_ages), 2) if all_ages else None,
        },
        "harvest_ready_wait_time": {
            "average_minutes": round(mean(all_waits), 2) if all_waits else None,
            "median_minutes": round(median(all_waits), 2) if all_waits else None,
        },
        "inventory_full_frequency": {
            "value": None,
            "status": "not_observable",
            "reason": "No authoritative stack-capacity or InventoryFull event exists.",
        },
    }


def validate_content(flowers, seeds):
    """M4.2B regression checks relevant to changed economy data only."""
    linked_seeds = seed_lookup(seeds)
    errors, warnings = [], []
    for flower_id, flower in flowers.items():
        minutes = growth_minutes(flower)
        if not isinstance(minutes, int) or minutes <= 0:
            errors.append(f"{flower_id}: growth_time must be a positive integer")
        if flower_id not in linked_seeds:
            errors.append(f"{flower_id}: missing seed mapping")
            continue
        margin = sell_price(flower) / linked_seeds[flower_id]["buy_price"]
        if not 2.5 <= margin <= 4.0:
            warnings.append(f"{flower_id}: seed-to-sell margin {margin:.2f} outside 2.5..4.0")
    return {"status": "PASS" if not errors else "FAIL", "errors": errors, "warnings": warnings}


def write_json(path: Path, payload):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as destination:
        json.dump(payload, destination, indent=2, ensure_ascii=False)

