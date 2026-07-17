# Plant Tales — Authoritative Event Catalog (`g_EventBusQueue`)

**Status:** Accepted (Sprint M4.0 — Architecture Freeze)  
**Last Modified:** 2026-07-17  
**Purpose:** Searchable reference catalog for all event bus signals across the game. AI assistants and engineers MUST consult this catalog before subscribing to or emitting any signal.

---

## GAME_FlowerHarvested
**Owner:** FlowerSystem (`Gameplay`)  
**Version:** v1  
**Description:** Emitted when the player interacts with a fully grown (`Bloom`) flower instance and successfully harvests it into inventory/satchel.  
**Payload:**
- `flower_id` (`string`): ID of the harvested flower (`e.g., "flower_white_lily"`).
- `quality` (`string`): Quality tier (`e.g., "Standard"`).
- `yield_count` (`int`): Number of flower items harvested (`e.g., 1`).
**Listeners:**
- `InventorySystem` (`Gameplay`): Adds harvested item to active slot.
- `AudioAndSoundFeelSystem` (`Presentation`): Plays harvest chime SFX (`sfx_harvest_chime.wav`).
- `VFXAndJuiceSystem` (`Presentation`): Spawns `BloomSparkleParticleObject` and initiates camera shake.
- `StatisticsSystem / TelemetryRecorder` (`Debug/Stats`): Increments daily harvest counter.

---

## GAME_InteractSoil
**Owner:** InteractionSystem (`Gameplay`)  
**Version:** v1  
**Description:** Emitted when the player interacts with a soil tile using either a seed bag (`Slot 0`) or watering can (`Slot 1`).  
**Payload:**
- `tile_x` (`int`): Grid X coordinate of soil.
- `tile_y` (`int`): Grid Y coordinate of soil.
- `action_type` (`string`): Type of action performed (`"PlantSeed"` or `"WaterSoil"`).
- `item_id` (`string`): ID of tool/seed used (`e.g., "seed_white_lily"` or `"tool_watering_can"`).
**Listeners:**
- `FlowerSystem` (`Gameplay`): Spawns `FlowerInstanceObject` sprout or updates `is_watered = true`.
- `AudioAndSoundFeelSystem` (`Presentation`): Plays `sfx_plant_seed.wav` or `sfx_water_splash.wav`.
- `VFXAndJuiceSystem` (`Presentation`): Spawns `WaterSplashParticleObject` if `action_type == "WaterSoil"`.

---

## GAME_DayAdvanced
**Owner:** DailyLoopSystem (`Gameplay`)  
**Version:** v1  
**Description:** Emitted when the player sleeps in bed (`BedObject`) and the simulation advances from night to morning (`06:00`).  
**Payload:**
- `previous_day` (`int`): Day number just completed.
- `new_day` (`int`): Day number just started.
- `total_gold` (`int`): Player gold balance at dawn.
**Listeners:**
- `FlowerSystem` (`Gameplay`): Advances growth timer for all watered flower instances.
- `SaveManagerSystem` (`Core`): Flags disk state dirty (`is_dirty = true`) and executes atomic write to `save_slot_01.json`.
- `AudioAndSoundFeelSystem` (`Presentation`): Plays rooster crow SFX (`sfx_day_start_rooster.wav`) and loops morning BGM.

---

## ECON_AddGoldRequest
**Owner:** ShippingBinSystem (`Economy`)  
**Version:** v1  
**Description:** Emitted when items placed inside the shipping bin (`ShippingBinObject`) are sold during the daily summary or direct settlement.  
**Payload:**
- `amount` (`int`): Gold added (`e.g., 200`).
- `source_item_id` (`string`): ID of shipped item (`e.g., "flower_white_lily"`).
**Listeners:**
- `ShippingBinSystem / EconomySystem` (`Economy`): Modifies `g_WorldState.player_gold += amount`.
- `AudioAndSoundFeelSystem` (`Presentation`): Plays coin clink SFX (`sfx_coin_clink.wav`).
- `VFXAndJuiceSystem` (`Presentation`): Spawns `GoldCoinPopObject` floating text `"+Gold"`.

---

## UI_SummaryBoxOpened
**Owner:** DailyLoopSystem (`Gameplay`)  
**Version:** v1  
**Description:** Emitted when the morning summary dialog box (`DailySummaryBoxObject`) opens on screen.  
**Payload:**
- `gold_earned_today` (`int`): Total earnings to display.
- `items_shipped_today` (`int`): Total count of shipped items.
**Listeners:**
- `UIAndUXPolishSystem` (`Presentation`): Formats summary text and displays continue prompt arrow.
- `TimeControllerSystem` (`Core`): Pauses simulation ticker (`g_TimeTicker.is_paused = true`).

---

## STAT_FTUECompleted
**Owner:** FTUETutorialSystem (`Gameplay`)  
**Version:** v1  
**Description:** Emitted when Thomas completes `STATE_4_COMPLETED` of the tutorial state machine.  
**Payload:**
- `elapsed_seconds` (`number`): Total seconds taken to complete tutorial.
**Listeners:**
- `PlaytestAndValidationSystem` (`Debug`): Logs verified FTUE duration and sets `ftue_verified = true`.
- `SaveManagerSystem` (`Core`): Records `tutorial_finished = true` into save profile.
