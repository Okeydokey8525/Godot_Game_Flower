# Standard GDevelop Event Block Template (`GDevelop Event Sheet Convention`)

**Template Name:** `Standard Event Group & Block Convention`
**Related Standard:** [04_Coding_Convention.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/04_Coding_Convention.md) & [05_Event_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/05_Event_Architecture.md)

---

## 1. Group Banner & Comment Box Convention
Mọi nhóm sự kiện (`Event Group`) phải có Comment Box trên cùng:
```text
// =============================================================================
// GROUP: [GROUP NAME — e.g. FLOWER HARVEST ROUTINE]
// DESCRIPTION: [2 lines explaining what this block group does and why]
// AUTHOR: [Name / AI Agent]
// =============================================================================
```

---

## 2. Standard Signal Emission Block (`Publish Event`)
Khi phát ra sự kiện toàn cục:
```text
[CONDITION]
  - Trigger once while true
  - Player interacts with FlowerObject AND FlowerObject.stage == 3
[ACTION]
  - EventBus.Emit("FlowerHarvested", "{ \"flower_id\": \"" + FlowerObject.flower_ref_id + "\", \"qty\": 1 }")
  - FlowerObject.ChangeAnimation("Harvested_Empty")
```

---

## 3. Standard Signal Consumption Block (`Listen Event`)
Khi lắng nghe sự kiện từ module khác:
```text
[CONDITION]
  - EventBus.HasSignal("FlowerHarvested") == true
[ACTION]
  - Set local string _payload = EventBus.GetPayload("FlowerHarvested")
  - InventorySlot.Add(JSON_Get(_payload, "flower_id"), JSON_Get(_payload, "qty"))
  - EventBus.ConsumeSignal("FlowerHarvested")
```

---

## 4. Time-Sliced Optimization Block (`Zero-Polling Check`)
Để tuân thủ `Performance Contract` (tránh kiểm tra nặng mỗi frame):
```text
[CONDITION]
  - SceneTimer("AI_Pathfinding_Tick") >= 0.15 seconds
  - TimeTicker.is_paused == false
[ACTION]
  - Reset SceneTimer("AI_Pathfinding_Tick")
  - Execute External Event "NPC_Pathfinding_Update"
```
