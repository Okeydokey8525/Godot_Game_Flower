# Plant Tales — Coding Standards & Implementation Practices

**Status:** Accepted (Sprint M4.0 — Architecture Freeze)  
**Last Modified:** 2026-07-17  
**Scope:** GDevelop 5 Event Sheets, JSON Schemas, and External Systems  

---

## 1. Core Principles

1. **Explicit Over Implicit:** Every event block MUST begin with a descriptive `BuiltinCommonInstructions::Comment` explaining the business logic, authoring sprint, and exact purpose.
2. **Zero Hardcoded Magic Numbers:** All gameplay timers, distances, and thresholds MUST be retrieved from structured configuration structures (`e.g., g_WorldState`, `FlowerInstanceObject` variables, or JSON schemas) or explicitly documented inside the event block.
3. **Data-Driven Priority:** When introducing new items, flowers, dialogues, or quests, NO C++ or JavaScript extensions should be created. All content is defined purely inside structured JSON schemas under `Source/Content/`.

---

## 2. GDevelop Event Sheet Organization

Every external system JSON (`Source/Systems/**/*.json`) MUST follow a standardized block arrangement:
- **Header Comment Block:** Contains System Name, Associated Layout, Author, Last Modified Date, and Purpose.
- **Block 0: Initialization / Setup (If needed):** Runs on scene start or on variable initialization triggers.
- **Block 1..N: Core Event Processing:** Grouped logically by condition hierarchy (`e.g., Signal Processing -> State Transition -> Visual Update`).
- **Footer Comment Block (Optional):** Debug hooks or telemetry emissions.

---

## 3. Variable Scope & Usage Rules

### Global Variables (`VarGlobal`)
- **Prefix:** Always prefixed with `g_` (`e.g., g_WorldState`, `g_SaveManager`, `g_EventBusQueue`, `g_TimeTicker`).
- **Usage:** Strictly reserved for persistent simulation-wide state (`Time, Weather, Gold, Active Satchel Slot, Save status`). Never use global variables for transient visual effects or local object timers.

### Scene Variables (`VarScene`)
- **Prefix:** Always prefixed with `s_` (`e.g., s_CameraTargetX`, `s_GreenhouseLoaded`).
- **Usage:** Reserved for layout-specific runtime flags that do not persist across save/load cycles.

### Instance Variables (`VarInstance`)
- **Prefix:** Lowercase snake_case without prefix (`e.g., flower_id`, `growth_timer`, `is_watered`, `blink_timer`).
- **Usage:** Attached directly to scene objects (`FlowerInstanceObject`, `PlayerObject`, `DialogueBoxObject`). Defines individual entity attributes.

---

## 4. Performance & Memory Guidelines

1. **Object Count Target:** Total objects per scene (`CountOfObjects("All")`) MUST stay below **1,000 instances** at all times to guarantee 60 FPS top-down performance.
2. **Transient Cleanup Check:** All temporary visual entities (`DustParticleObject`, `WaterSplashParticleObject`, `BloomSparkleParticleObject`, `GoldCoinPopObject`) MUST implement a strict `life_timer` or opacity check deleting the object (`DeleteObject`) when expired. Zero orphaned sprites allowed.
3. **Event Bus Queue Pruning:** After `EventBusSystem` processes or routes signals in `g_EventBusQueue`, processed signals MUST be cleaned or shifted out to prevent unbounded array memory growth.
