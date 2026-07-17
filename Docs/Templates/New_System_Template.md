# System Event Sheet Specification: `Source/Systems/[system_name].json`

**System Name:** `[system_name_in_snake_case]`
**Owner Module:** `Core Module XX — [Module Name]`
**Related Schema:** `[SchemaDefinition]`

---

## 1. System Structure & Header Hook
```text
================================================================================
  SYSTEM: [SYSTEM NAME IN UPPERCASE]
  AUTHOR: [AI AGENT / DEVELOPER] | LAST MODIFIED: YYYY-MM-DD
  PURPOSE: [1-line summary of system's single responsibility]
================================================================================
```

---

## 2. Event Blocks Breakdown
- **Block 1: Initialization / Boot Hook**
  - Listen: `BootSceneLoaded` or `SceneInit`
  - Action: Nạp JSON Data DTO tĩnh và phân bổ pool.
- **Block 2: Signal Listeners (`Consumers`)**
  - Listen: `[ExternalSignalBusEvent]`
  - Action: Thực thi logic nội bộ chuẩn xác.
- **Block 3: Time-Sliced Runtime (`If needed`)**
  - Condition: `TimeTicker.is_paused == false` AND `Timer("SystemTick") >= 0.1s`
  - Action: Thực thi vòng lặp chia tải (`No Every-Frame polling!`).
- **Block 4: Cleanup & Save Hook**
  - Listen: `OnBeforeSaveTriggered`
  - Action: Cung cấp DTO cho `SaveManager`.

---

## 3. Performance Budget Check
- **Max Execution Time:** `< X.X ms` per frame.
- **Object Pool Required:** `YES / NO`
