# Plant Tales — Naming Conventions & Identifiers

**Status:** Accepted (Sprint M4.0 — Architecture Freeze)  
**Last Modified:** 2026-07-17  

---

## 1. Event Bus Namespacing (`Signal Prefixes`)

All signals dispatched across `g_EventBusQueue` MUST use UPPERCASE category prefixes separated by an underscore (`_`) followed by PascalCase action descriptors:

| Prefix | Domain / Layer | Example Event Signal |
| :--- | :--- | :--- |
| **`GAME_`** | Core Gameplay Actions (`Movement, Gardening, Interaction`) | `GAME_FlowerHarvested`, `GAME_InteractSoil`, `GAME_SeedPlanted`, `GAME_DayAdvanced` |
| **`ECON_`** | Economy & Transaction Events (`Shipping, Gold, Purchasing`) | `ECON_AddGoldRequest`, `ECON_ItemShipped`, `ECON_SeedPurchased` |
| **`UI_`** | User Interface State Transitions (`Dialogue, Summary, HUD`) | `UI_SummaryBoxOpened`, `UI_SummaryBoxClosed`, `UI_DialogueAdvanced` |
| **`STAT_`** | Statistics & Telemetry Triggers (`Milestones, FTUE, Usage`) | `STAT_FTUECompleted`, `STAT_ToolUsed`, `STAT_DailySummaryRecorded` |
| **`DEBUG_`** | QA, Validation & Overlays (`Playtest, Stress Test, Cheats`) | `DEBUG_FPSDropped`, `DEBUG_MemoryWarning`, `DEBUG_FastForwardToggled` |

---

## 2. Object & Prefab Naming (`Scene Objects`)

All scene entities (`Source/Objects/*.json`) MUST use clear PascalCase names with descriptive type suffixes:

| Object Type | Naming Rule | Valid Examples | Invalid / Prohibited Examples |
| :--- | :--- | :--- | :--- |
| **Core Characters** | `[Name]Object` or `NPC[Name]Object` | `PlayerObject`, `NPCThomasObject` | `player`, `Character1`, `npc` |
| **Interactive Entities** | `[EntityName]Object` | `BedObject`, `ShippingBinObject`, `FlowerInstanceObject` | `bed_sprite`, `bin`, `flower1` |
| **UI & HUD Elements** | `[Function]UIObject` or `[Function]BoxObject` | `HUDBarObject`, `DialogueBoxObject`, `SatchelSlotObject` | `ui_bar`, `dialog`, `slot` |
| **VFX & Particles** | `[Effect]ParticleObject` | `DustParticleObject`, `WaterSplashParticleObject`, `BloomSparkleParticleObject` | `dust`, `splash1`, `fx_sparkle` |

---

## 3. File & System Naming (`Directory Rules`)

### System Files (`Source/Systems/*.json`)
- Use lowercase `snake_case_system.json`.
- Inside `game.json`, register the friendly PascalCase name ending with `System` (`e.g., "name": "AudioAndSoundFeelSystem", "file": "Systems/Presentation/audio_sound_feel_system.json"`).

### Content Files (`Source/Content/**/*.json`)
- Use lowercase `snake_case.json` (`e.g., white_lily.json`, `thomas_intro.json`, `quest_001.json`).
- ID keys inside the JSON MUST exactly match the file basename (`e.g., "id": "flower_white_lily"`).
