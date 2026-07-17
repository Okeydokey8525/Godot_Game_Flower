#!/usr/bin/env python3
"""M4.2B telemetry producer.  Uses the shared authoritative simulation core."""

import json

from simulation_core import REPORT_DIR, load_content, simulate_economy


def main():
    flowers, seeds, _quests = load_content()
    simulation = simulate_economy(flowers, seeds)
    log_path = REPORT_DIR / "session_telemetry.jsonl"
    log_path.parent.mkdir(parents=True, exist_ok=True)
    with log_path.open("w", encoding="utf-8") as destination:
        for event in simulation["events"]:
            event.update({"build": "0.4.2", "schema": "1.0.0-STABLE", "simulation_authority": "simulation_core.py"})
            destination.write(json.dumps(event, ensure_ascii=False) + "\n")
    print(f"Wrote {len(simulation['events'])} authoritative telemetry records to {log_path}")
    print(f"Gold held before sleep checkpoints: {simulation['gold_held_before_sleep']['checkpoints']}")
    print(f"Inventory full frequency: {simulation['inventory_full_frequency']}")


if __name__ == "__main__":
    main()
