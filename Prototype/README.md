# 🧪 Gameplay Prototypes & Milestone Deliverables

Nơi chứa các dự án/mã nguồn thử nghiệm nhanh (`Scratchpad / Sandbox`) và kiểm chứng các cột mốc nguyên mẫu (`Milestones M0 -> M6`) theo lộ trình `08_Prototype_Roadmap.md`.

---

## 🚀 Milestone M0: Prototype Bootstrap & Scaffolding (`COMPLETED & VERIFIED`)

**Ngày hoàn thành:** `2026-07-16` | **Trạng thái:** `Passed Exit Gate Check`
**Đường dẫn mã nguồn chính thức:** [Source/](file:///c:/LeDucLuong/Plant%20Tales/Source)

### 1. Kiến Trúc Bộ Khung Nền Tảng (`Scaffolding Structure`)
Toàn bộ cấu trúc 8 thư mục độc tôn đã được khởi tạo và kết nối chuẩn xác theo `02_Folder_Convention.md`:
```text
Source/
├── game.json                          ◄── [Master GDevelop 5 Project Configuration File]
├── Core/                              ◄── [4 Singletons: GameManager, EventBus, TimeTicker, SaveManager]
├── Scenes/                            ◄── [BootScene, GreenhouseScene, VillageScene]
├── Data/
│   ├── Static/                        ◄── [Static JSON Catalogs: flowers, items, npcs, weather]
│   └── Saves/                         ◄── [Deterministic Save Template: save_slot_01.json (Seed 123456)]
├── Objects/                           ◄── [Game Objects & Prefabs]
├── UI/                                ◄── [HUD & Modal Sheets]
├── Systems/                           ◄── [System Event Sheets]
└── Scripts/                           ◄── [Helper JavaScript libraries]
```

### 2. Tiêu Chí Hoàn Thành Cột Mốc (`M0 Exit Criteria Verification Table`)

| Tiêu Chí Kiểm Định (`Exit Criteria`) | Trạng Thái (`Status`) | Mô Tả & Xác Nhận Kỹ Thuật (`Technical Proof`) |
| --- | :---: | --- |
| **1. Project Structure Valid** | ✅ `Passed` | Tệp [Source/game.json](file:///c:/LeDucLuong/Plant%20Tales/Source/game.json) hợp lệ theo cấu trúc GDevelop 5, liên kết chính xác 3 Scene Layouts và 4 External Events. |
| **2. 4 Singletons Loaded** | ✅ `Passed` | Nạp đủ 4 Singletons tại `Source/Core/`: `game_manager.json`, `event_bus.json`, `time_ticker.json`, `save_manager.json`. |
| **3. Static JSON Catalogs Parsed** | ✅ `Passed` | Khởi tạo đầy đủ 4 bộ cơ sở dữ liệu tĩnh tại `Source/Data/Static/`: `flower_catalog.json` (4 hoa), `item_catalog.json` (4 items), `npc_catalog.json` (2 NPCs), `weather_profiles.json` (3 thời tiết). |
| **4. Deterministic Seed Locked** | ✅ `Passed` | Cài đặt `DEBUG_SEED = 123456` và `g_IsDebugMode = true` trong `game_manager.json` và tệp mẫu `save_slot_01.json`. |
| **5. Boot Pipeline Flow Verification**| ✅ `Passed` | `BootScene` khởi chạy ➔ Nạp cấu hình & kiểm tra Checksum ➔ Gán `g_BootCompleted = true` ➔ Tự động chuyển cảnh (`PushScene`) sang `GreenhouseScene`. |

---

## 🌿 Chuẩn Bị Cho Cột Mốc Tiếp Theo: Milestone M1 (`Vertical Slice Garden`)
Khi M0 đã hoàn tất và đóng cổng (`Signed-Off`), đội ngũ chính thức chuyển trọng tâm sang `Milestone M1` với các mục tiêu:
- Tạo đối tượng `FlowerInstanceObject` và `GridSlotObject` trong `Source/Objects/`.
- Xây dựng hệ thống lưới đất trồng nhà kính (`GreenhouseGrid 20x20`).
- Kết nối sự kiện tương tác `PlantSeed` và `WaterFlower` từ Satchel.
