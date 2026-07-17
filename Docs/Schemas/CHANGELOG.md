# Plant Tales — Content Schemas CHANGELOG

All notable changes, field additions, and deprecations across our Data-Driven Content Schemas (`Flower, NPC, Dialogue, Quest`) are documented in this changelog. Designers, engineers, and AI assistants MUST check this log when writing or validating content files.

---

## [v1.0.0-STABLE] — 2026-07-17 (`FROZEN STABLE CONTRACT — Sprint M4.1C0 Pipeline Proof`)

### Frozen & Audited
- **Schema v1.0 Stable Contract Frozen:** After successful real-world authoring verification in Sprint M4.1C0 (`3 Flowers, 2 NPCs, 2 Dialogues, 3 Quests, 4 Items`), `flower_schema v1.0`, `npc_schema v1.0`, `dialogue_schema v1.0`, and `quest_schema v1.0` are officially declared **STABLE**.
- **Refined Optional Authoring Fields (`Proof Audit`):**
  - **Flower Schema:** Added optional fields `preferred_weather` and `pollination_group` (`verified during sunflower and rose authoring`).
  - **NPC Schema:** Added optional fields `birthday` and `relationship_events` (`verified during Anna authoring`).
  - **Dialogue Schema:** Added optional fields `emotion` and `next_state` (`verified during Anna shop dialogue authoring`).
  - **Quest Schema:** Added optional fields `repeatable` and `unlock_after` (`verified during sunflower harvest and rose delivery authoring`).
- **Zero Code Modification Guarantee:** All `v1.0.0` content definitions are guaranteed to load via `ContentManagerSystem` and index cleanly in `content_manifest.json` with **0 lines of gameplay code modified**. Future additions must use `v1.1` (`backwards compatible`) or `v2.0` (`breaking`).

---

## [v1.0.0-INITIAL] — 2026-07-17 (`Sprint M4.1B — Data Language Standardization`)

### Added
- **Common Metadata Header across all schemas:** Mandated `#schema_version`, `id`, `display_name`, `author`, `last_modified`, and `tags` as root-level properties on every content definition.
- **Flower Schema (`v1`):** Defined required (`id, display_name, growth_time, seed_item, yield_item, sprite`) and optional (`description, rarity, sell_price, festival_bonus, favorite_season, tags`) fields alongside `flower_validation.md`.
- **NPC Schema (`v1`):** Defined required (`id, display_name, portrait, default_schedule, dialogue_root`) and optional (`likes, dislikes, birthday, relationship_events`) fields alongside `npc_validation.md`.
- **Dialogue Schema (`v1`):** Defined required (`id, speaker, lines`) and optional (`conditions, next, rewards, flags`) fields alongside `dialogue_validation.md`.
- **Quest Schema (`v1`):** Defined required (`id, title, steps, completion`) and optional (`rewards, repeatable, season, dependencies`) fields alongside `quest_validation.md`.
- **Schema Examples Suite:** Created `minimal.json` and `full.json` (`and rare.json for flowers`) under `Docs/Schemas/Examples/` so designers can instantly copy-paste exact working templates.
