# Plant Tales — Authoritative Studio QA & Regression Checklist (`Priority Tiered: P0 / P1 / P2`)

**Status:** Accepted (Sprint M4.0 -> M4.2A.0 Measurement Freeze)  
**Last Modified:** 2026-07-17  
**Enforcement:** This regression suite MUST pass 100% on **P0** before any pull request, playtest, or milestone sign-off. Engineers and QA testers MUST execute these test cases against `ReferenceSaves` (`TestFixtures`) or live builds based on their priority hierarchy.

---

## 🛑 Phân Cấp Ưu Tiên Kiểm Thử (`Priority Hierarchy Definition`)

- **`P0 (Critical / Blocker — Game Cannot Ship)`:** Các lỗi phá vỡ vòng lặp cốt lõi (`Core Loop Breakdown`), crash game, mất dữ liệu save, hoặc soft-lock cản trở người chơi tiếp tục chơi. **Bắt buộc 100% PASS.**
- **`P1 (Major — Gameplay Defect)`:** Các lỗi chức năng lớn (`Major Functional Defect`) như sai nhánh thoại, lệch animation tốc độ, hiển thị sai thông tin trên Satchel HUD, hoặc camera giật cục nhưng không gây crash game.
- **`P2 (Minor — Polish / Cosmetic / Audio feel)`:** Các lỗi thẩm mỹ nhỏ (`Cosmetic/Audio Defect`) như lỗi chính tả (`Typo`), hạt bụi VFX không bung đúng nhịp, hoặc âm lượng SFX hơi lệch pha.

---

## 1. Core Simulation Test Cases (`Regression Suite by Priority`)

| Test Case ID | Priority | Feature Area | Action / Trigger | Expected Outcome (`Pass Criteria`) | Reference Save Fixture | Status |
| :---: | :---: | :--- | :--- | :--- | :--- | :---: |
| **TC_SAV_01** | **`P0`** | Saving | Sleep in bed (`is_dirty == true`). | Atomic disk write updates `save_slot_01.json` with current day, hour, gold, and flower instances (`SUCCESS_ATOMIC`). Zero crash / zero corruption. | `Day5.json` | ✅ `PASSED (100%)` |
| **TC_LOD_01** | **`P0`** | Loading | Restart app and select Load from title menu. | Simulation restores exact player coordinates, gold balance (`350 Gold`), day/hour (`Day 5, 14:00`), and all 3 flower stages without data loss or default reset. | `Day5.json` | ✅ `PASSED (100%)` |
| **TC_PLT_01** | **`P0`** | Plant | Select Seed Bag (`Slot 0`), face soil tile, press `Space`. | Seed quantity decreases `-1`. Sprout sprite spawns at soil coordinates. `GAME_InteractSoil` signal emitted. Zero softlock. | `PostTutorial.json` | ✅ `PASSED (100%)` |
| **TC_WAT_01** | **`P0`** | Water | Select Watering Can (`Slot 1`), face soil/sprout, press `Space`. | Water splash VFX spawns (`WaterSplashParticleObject`). Flower tile flags `is_watered = true`. | `PostTutorial.json` | ✅ `PASSED (100%)` |
| **TC_HRV_01** | **`P0`** | Harvest | Face fully grown (`Bloom`) flower tile and press `Space`. | Flower tile resets/disappears. `GAME_FlowerHarvested` emitted. Harvest chime rings (`volume 100`). Sparkle VFX and camera shake (`0.15s`) trigger. Item added to satchel. | `Day5.json` | ✅ `PASSED (100%)` |
| **TC_SHP_01** | **`P0`** | Shipping | Face Shipping Bin (`ShippingBinObject`), press `Space` with flower active. | Item added to pending shipping table (`pending_unit_price = 50 Gold`). Economy income correctly queued. | `Day5.json` | ✅ `PASSED (100%)` |
| **TC_SLP_01** | **`P0`** | Sleep | Face Bed (`BedObject`), press `Space` to sleep. | Screen fades to black (`FadeOut -> SleepResting 0.5s pause`). Simulation day increments `+1`. `DailySummaryBoxObject` displays exact earnings. | `Day5.json` | ✅ `PASSED (100%)` |
| **TC_MOV_01** | **`P1`** | Movement | Press WASD / arrow keys in `GreenhouseScene`. | Player moves smoothly (`SpeedScale 1.0`), faces 4 directions without sprite flickering, and camera clamps exactly within map edges (`zero black borders`). | `FreshGame.json` | ✅ `PASSED` |
| **TC_INT_01** | **`P1`** | Interaction | Face NPC Thomas (`16px distance`) and press `Space`. | Dialogue box opens instantly with padding `16px`, typewriter effect, and blinking continue arrow `▼ [Space]`. Correct dialogue branch executed. | `FreshGame.json` | ✅ `PASSED` |
| **TC_INV_01** | **`P1`** | Inventory | Toggle between `Slot 0` and `Slot 1` using numerical keys/scroll. | Golden highlight outline (`SatchelHighlightOutlineObject`) shifts smoothly (`X-4, Y-4`). Tooltip displays exact item description (`Active: White Lily Seeds [Plantable]`). | `PostTutorial.json` | ✅ `PASSED` |
| **TC_VFX_01** | **`P2`** | VFX / Polish | Walk across grass and check dust puffs / footstep sound hooks. | `DustParticleObject` spawns synchronously with footstep cadence timer (`footstep_timer <= 0`). Audio ducking subtle and natural. | `FreshGame.json` | ✅ `PASSED` |

---

## 2. Definition of Done (`DoD — 6 Mandatory Criteria`)

For Sprint M4.0 & M4.2A (`and every future sprint`), all 6 criteria MUST be verified:

| # | DoD Criterion | Verification Method | M4.2A.0 Verification Status |
| :---: | :--- | :--- | :---: |
| **1** | `ADR-005, Coding Standard, Naming Convention completed.` | Verified presence and structure inside `Docs/Architecture/`. | ✅ **`COMPLETED`** |
| **2** | `Event Catalog and Module Map finalized.` | Consulted `Event_Catalog.md` and `Module_Map.md` diagrams. | ✅ **`COMPLETED`** |
| **3** | `Systems organized into Core / Gameplay / Economy / Presentation / Debug.` | Verified clean subdirectories in `Source/Systems/` and updated `game.json`. | ✅ **`COMPLETED`** |
| **4** | `ReferenceSaves (TestFixtures) operational and loadable.` | Verified `FreshGame`, `PostTutorial`, `Day5`, `LateGame`, `StressTest` under `Source/Data/ReferenceSaves/`. | ✅ **`COMPLETED`** |
| **5** | `Regression Checklist executed with 100% pass rate on P0 Blockers.` | Verified all 7 **P0** core test cases passing without regression. | ✅ **`COMPLETED`** |
| **6** | `Zero new gameplay features added or save/content format mutations.` | Audited commit/sprint scope confirming 100% pure architecture/measurement freeze. | ✅ **`COMPLETED`** |
