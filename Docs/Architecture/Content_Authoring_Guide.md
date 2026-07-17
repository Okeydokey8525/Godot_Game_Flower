# Plant Tales — Content Authoring Guide & JSON Schemas

**Status:** Accepted (Sprint M4.0 — Architecture Freeze)  
**Last Modified:** 2026-07-17  
**Bridge to M4.1:** This document defines the mandatory JSON schema structure for creating new Flowers, NPCs, Quests, and Dialogues. Designers and AI assistants can create new game content simply by adding JSON files matching these schemas without writing or modifying a single line of GDevelop code!

---

## 1. Flower Authoring Schema (`Source/Content/Flowers/*.json`)

To add a new flower (`e.g., rose.json`, `tulip.json`), create a JSON file with the following fields:

```json
{
  "$schema": "../../Docs/Schemas/flower_schema.json",
  "id": "flower_rose",
  "display_name": "Crimson Rose",
  "growth_time": 1440,
  "base_sell_gold": 80,
  "yield_count": 1,
  "sprite_resource": "rose_bloom_sprite.png",
  "sprout_sprite_resource": "sprout_generic_sprite.png",
  "rarity": "Uncommon",
  "description": "A fragrant red rose. Requires 24 hours of care.",
  "hybrid_rules": [
    { "partner_flower_id": "flower_white_lily", "result_flower_id": "flower_pink_hybrid", "chance": 0.25 }
  ]
}
```

### Required Fields:
- **`id`** (`string`): Unique lowercase identifier starting with `flower_`. MUST match filename prefix (`flower_rose.json`).
- **`display_name`** (`string`): Friendly UI tooltip string.
- **`growth_time`** (`int`): Total gameplay minutes required to bloom (`e.g., 1080 for 18h, 1440 for 24h`). See the canonical [Time Convention](Time_Convention.md). The legacy `growth_time_minutes` alias is read-compatible only and must not be used in new content.
- **`base_sell_gold`** (`int`): Unit price credited when shipped via `ShippingBinObject`.
- **`yield_count`** (`int`): Number of flowers yielded per harvest (`default: 1`).
- **`sprite_resource`** (`string`): Exact filename in project resource library.

### Optional Fields:
- **`rarity`** (`string`): `"Common"`, `"Uncommon"`, `"Rare"`, or `"Legendary"`.
- **`description`** (`string`): Lore / satchel description.
- **`hybrid_rules`** (`array`): Rules for cross-breeding when planted adjacent to partner flowers.

---

## 2. NPC & Dialogue Authoring Schema (`Source/Content/NPCs/*.json`)

To add a new NPC or update dialogue trees (`e.g., anna.json`), create a JSON file:

```json
{
  "id": "npc_anna",
  "display_name": "Anna the Botanist",
  "default_x": 480,
  "default_y": 320,
  "sprite_idle": "npc_anna_idle.png",
  "dialogues": {
    "greeting_first_time": {
      "text": "Hello there! I heard a new gardener took over the old greenhouse.",
      "portrait": "portrait_anna_smile.png",
      "next_state": "greeting_regular"
    },
    "greeting_regular": {
      "text": "The soil here looks rich! Do you have any White Lilies to show me?",
      "portrait": "portrait_anna_normal.png",
      "next_state": "shop_menu"
    }
  }
}
```

---

## 3. Quest Authoring Schema (`Source/Content/Quests/*.json`)

To add a new request/quest (`e.g., quest_001.json`), create a JSON file:

```json
{
  "id": "quest_001_lily_request",
  "title": "Thomas's First Order",
  "giver_npc_id": "npc_thomas",
  "description": "Deliver 4 White Lilies to the Shipping Bin before sundown.",
  "required_item_id": "flower_white_lily",
  "required_count": 4,
  "reward_gold": 150,
  "reward_item_id": "seed_rose",
  "reward_item_count": 2
}
```

---

## 4. Content Loading Workflow in M4.1+
When `GreenhouseScene` boots up, `ContentManagerSystem` (introduced in M4.1) will iterate through all JSON files inside `Source/Content/` and dynamically populate the simulation runtime tables. No system refactoring is needed when new content JSON files are dropped into these folders!
