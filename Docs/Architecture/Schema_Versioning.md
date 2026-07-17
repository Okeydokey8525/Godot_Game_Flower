# Plant Tales — Content Schema Versioning & Backwards Compatibility (`ADR-007`)

**Status:** Accepted (Sprint M4.1A — Content Authoring Pipeline)  
**Last Modified:** 2026-07-17  
**Scope:** All JSON definition files under `Source/Content/` (`Flowers`, `NPCs`, `Dialogues`, `Quests`, `Items`, `Weather`, `Seasons`).

---

## 1. Context & Rationale

As **Plant Tales** scales from a Vertical Slice (`1 flower, 1 NPC, 1 quest`) to a rich content ecosystem (`12 flowers, 4 NPCs, 15 quests, 4 seasons`), the structure (`schema`) of content definitions will naturally evolve. Over time, new gameplay systems may require extra data fields (`e.g., hybrid_rules`, `favorite_season`, `festival_bonus`, `rain_growth_multiplier`).

If content schemas are not versioned, adding a new field in M5 would force engineers or designers to manually open and edit dozens or hundreds of old JSON files to prevent runtime crashes or `undefined` variable errors.

To guarantee zero maintenance churn and 100% backwards compatibility, every content JSON file MUST declare a explicit `"schema_version"` integer.

---

## 2. Versioning Specification (`v1 -> v2`)

Every content definition JSON file MUST include `"schema_version": 1` at the root level:

```json
{
  "schema_version": 1,
  "id": "flower_rose",
  "display_name": "Crimson Rose",
  "growth_time_minutes": 1440,
  "base_sell_gold": 80,
  "yield_count": 1,
  "sprite_resource": "rose_bloom_sprite.png",
  "sprout_sprite_resource": "sprout_generic_sprite.png"
}
```

### Rule 1: Additive Evolution Only (`Never Delete or Rename v1 Fields`)
When introducing Version 2 (`v2`), existing `v1` required fields (`e.g., base_sell_gold`) MUST NOT be deleted or renamed without a formal deprecation period. All new fields added in `v2` MUST be optional or have safe fallback defaults when read by `ContentManagerSystem`.

### Rule 2: Graceful Upgrading in ContentManager (`Registry Migration`)
When `ContentManagerSystem` loads a definition from `content_manifest.json`, it checks the `"schema_version"` key:
- **If `schema_version == 1`:** The loader injects default fallback values for any `v2+` fields (`e.g., sets default "favorite_season": "All"`, `"hybrid_rules": []`).
- **If `schema_version == 2`:** The loader reads the explicit `v2` fields directly.
- **If `schema_version > CURRENT_SUPPORTED_VERSION`:** The loader logs a non-blocking warning (`WARN: flower_rose.json uses newer version than engine supports`) and loads known baseline fields.

---

## 3. Schema Upgrade Examples

### Baseline v1 Schema (`Flower Definition v1`)
```json
{
  "schema_version": 1,
  "id": "flower_white_lily",
  "display_name": "White Lily",
  "growth_time_minutes": 1080,
  "base_sell_gold": 50,
  "yield_count": 1,
  "sprite_resource": "white_lily_bloom.png"
}
```

### Upgraded v2 Schema (`Flower Definition v2 with Hybrid & Season Rules`)
```json
{
  "schema_version": 2,
  "id": "flower_pink_rose_hybrid",
  "display_name": "Pink Hybrid Rose",
  "growth_time_minutes": 1800,
  "base_sell_gold": 240,
  "yield_count": 2,
  "sprite_resource": "pink_rose_bloom.png",
  "favorite_season": "Spring",
  "hybrid_rules": [
    { "parent_a": "flower_rose", "parent_b": "flower_white_lily", "chance": 0.20 }
  ],
  "festival_bonus_gold": 50
}
```

---

## 4. Validation Rules (`Graceful Error Logging`)
During boot-up validation (`ContentManagerSystem::ValidateDefinitions`), the loader checks:
1. Is `"schema_version"` present and `>= 1`?
2. Are all mandatory `v1` fields (`id`, `display_name`, `sprite_resource`) present and non-empty?
3. If validation fails for a specific JSON entry, `ContentManagerSystem` logs an explicit validation error (`ERROR: flower_broken.json missing required field 'growth_time_minutes' — Skipped from Registry`) but **DOES NOT CRASH** the simulation or interrupt the loading of valid definitions.
