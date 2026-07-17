# Plant Tales — System Public API Reference

**Status:** Accepted (Sprint M4.0 — Architecture Freeze)  
**Last Modified:** 2026-07-17  
**Purpose:** Defines what each system exposes publicly (`Events`, `Owned Data`, `Dependencies`). AI assistants and developers MUST read this reference when integrating across module boundaries.

---

## InventorySystem
**Layer:** `Gameplay`  
**Public Events Emitted:**
- `GAME_SatchelSlotChanged` (`payload: { active_slot: int, item_id: string }`)
- `GAME_InventoryItemUpdated` (`payload: { item_id: string, new_count: int }`)
**Public Events Consumed:**
- `GAME_FlowerHarvested` -> Increments harvested flower quantity.
- `GAME_InteractSoil` -> Decrements seed quantity if `action_type == "PlantSeed"`.
**Owned Authoritative Data:**
- `g_SatchelActiveSlot` (`number`: `0` for Slot 0 Seeds, `1` for Slot 1 Watering Can)
- `g_InventorySlots` (`array`: list of item IDs and quantities)
**Dependencies:** `Core` (`EventBusSystem`)

---

## FlowerSystem
**Layer:** `Gameplay`  
**Public Events Emitted:**
- `GAME_FlowerHarvested` (`payload: { flower_id: string, quality: string, yield_count: int }`)
- `GAME_SeedPlanted` (`payload: { tile_x: int, tile_y: int, flower_id: string }`)
**Public Events Consumed:**
- `GAME_InteractSoil` -> Checks if tile has soil, plants seed or sets `is_watered = true`.
- `GAME_DayAdvanced` -> Advances `growth_timer` for watered flowers and resets `is_watered = false`.
**Owned Authoritative Data:**
- `FlowerInstanceObject` (`instances`: `flower_id`, `growth_stage`, `growth_timer`, `growth_target_minutes`, `is_watered`)
**Dependencies:** `Core` (`EventBusSystem`, `TimeControllerSystem`), `InteractionSystem`

---

## ShippingBinSystem
**Layer:** `Economy`  
**Public Events Emitted:**
- `ECON_AddGoldRequest` (`payload: { amount: int, source_item_id: string }`)
- `ECON_ItemShipped` (`payload: { item_id: string, count: int, unit_price: int }`)
**Public Events Consumed:**
- `GAME_InteractSoil` / Direct shipping interaction -> Accepts items from active satchel slot.
- `UI_SummaryBoxOpened` -> Settles total daily shipped value.
**Owned Authoritative Data:**
- `ShippingBinObject` (`instances`: `pending_item_id`, `pending_item_count`, `pending_unit_price`)
- `g_WorldState.player_gold` (`number`: authoritative player balance)
**Dependencies:** `Core` (`EventBusSystem`), `Gameplay` (`InventorySystem`)

---

## DailyLoopSystem
**Layer:** `Gameplay`  
**Public Events Emitted:**
- `GAME_DayAdvanced` (`payload: { previous_day: int, new_day: int, total_gold: int }`)
- `UI_SummaryBoxOpened` (`payload: { gold_earned_today: int, items_shipped_today: int }`)
**Public Events Consumed:**
- Bed Interaction (`InteractBed`) -> Initiates black fade transition (`FadeOut -> SleepResting -> FadeIn`).
**Owned Authoritative Data:**
- `g_WorldState.current_day` (`number`)
- `g_WorldState.current_hour` (`number`)
- `g_WorldState.current_minute` (`number`)
**Dependencies:** `Core` (`EventBusSystem`, `SaveManagerSystem`, `TimeControllerSystem`)

---

## SaveManagerSystem
**Layer:** `Core`  
**Public Events Emitted:**
- `STAT_SaveCompleted` (`payload: { save_slot: string, status: string }`)
**Public Events Consumed:**
- `GAME_DayAdvanced` -> Triggers `SaveToJSON("save_slot_01.json")` when `is_dirty == true`.
- `STAT_FTUECompleted` -> Sets `tutorial_finished = true`.
**Owned Authoritative Data:**
- `g_SaveManager.is_dirty` (`boolean`)
- `g_SaveManager.last_save_status` (`string`: `"SUCCESS_ATOMIC"`)
**Dependencies:** None (`Base Core Infrastructure`)
