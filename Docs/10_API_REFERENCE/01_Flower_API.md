# FlowerModule API Reference (`Core Module 01 Spec v1.0`)

**Tài liệu đặc tả lập trình dành cho lập trình viên & AI Agent thao tác với hệ thống trồng hoa nhà kính (`FlowerSystem`).**

---

## 1. Public Events (`Sự Kiện Phát Ra — Published Signals`)
Các tín hiệu mà `FlowerSystem` phát ra lên `Global Event Bus` (`EventBus.Emit()`) khi thực thi thành công:

| Signal Name (`Tên Sự Kiện`) | JSON Payload Structure (`Cấu Trúc Payload`) | Thời Điểm Phát Ra (`Trigger Hook`) | Modules Lắng Nghe (`Authorized Consumers`) |
| --- | --- | --- | --- |
| `FlowerHarvested` | `{ "flower_id": "string", "yield_qty": number, "grid_x": number, "grid_y": number }` | Khi người chơi thu hoạch hoa thành công tại ô đất `Stage == 3`. | `InventoryModule` (thêm vào Satchel), `JournalModule` (mở khóa trang/cấp độ). |
| `FlowerWatered` | `{ "grid_x": number, "grid_y": number, "new_moisture": number }` | Khi người chơi dùng bình tưới `Watering Can` lên ô đất. | `AudioModule` (phát SFX nước chép chép), `WeatherModule` (đồng bộ độ ẩm). |
| `FlowerBloomed` | `{ "flower_id": "string", "grid_x": number, "grid_y": number, "rarity": number }` | Khi hoa tiến hóa từ `Stage 2 (Budding)` lên `Stage 3 (Blooming)`. | `AudioModule` (phát SFX chuông nở rực rỡ), `JournalModule` (ghi nhận lần nở đầu tiên). |
| `HybridMutationOccurred`| `{ "parent_a": "string", "parent_b": "string", "hybrid_seed": "string", "grid_x": number, "grid_y": number }` | Khi hai bông hoa kề cận lai tạo ra hạt giống mới lúc chuyển ngày. | `InventoryModule` (thêm hạt giống lai vào Satchel), `JournalModule`. |

---

## 2. Consumed Signals (`Sự Kiện Lắng Nghe — Consumes`)
Các tín hiệu từ `EventBus` mà `FlowerSystem` lắng nghe để điều chỉnh trạng thái nội bộ:

| Signal Name (`Sự Kiện Lắng Nghe`) | Module Phát Ra (`Publisher`) | Hành Vi Thực Thi Của FlowerSystem (`System Response`) |
| --- | --- | --- |
| `WeatherChanged` | `WeatherModule` | Đọc cấu hình `weather_profile.moisture_modifier`. Nếu thời tiết là `weather_spring_rain` (`is_raining == true`), tự động nạp `moisture_level = 100` cho tất cả 400 ô đất nhà kính! |
| `TimeMinuteTicked` | `TimeTicker Singleton`| Thực thi vòng lặp chia tải (`Time-Sliced Processing`), giảm độ ẩm đất `2% / 10 phút` (nếu trời nắng) và gia tăng `accumulated_growth_minutes`. |
| `PlantSeedTriggered` | `UI / Satchel Modal`| Kiểm tra ô đất mục tiêu (`grid_x, grid_y`). Nếu ô đất đang trống (`slot.state == Empty`), khởi tạo cây mầm mới với `flower_ref_id = payload.flower_id`. |

---

## 3. Public Functions (`Các Hàm / Hành Vi Thực Thi Nội Bộ`)
Mô tả logic chuẩn xác được bọc trong tệp hệ thống `Source/Systems/flower_system.json`:

### `PlantFlower(grid_x: number, grid_y: number, flower_id: string)`
- **Quy tắc kiểm tra (`Pre-condition`):** `GridSlotObject.state == Empty` AND `InventorySlot.GetCount(flower_id_seed) >= 1`.
- **Hành vi (`Action`):**
  1. Gán `GridSlotObject.flower_ref_id = flower_id`.
  2. Gán `GridSlotObject.stage = 0 (Seed)`.
  3. Gán `GridSlotObject.accumulated_minutes = 0`.
  4. Gán `GridSlotObject.moisture_level = 100` (đất mới gieo luôn đủ ẩm ban đầu).
  5. Phát tín hiệu tiêu thụ hạt giống tới `InventoryModule`.

### `WaterFlower(grid_x: number, grid_y: number)`
- **Quy tắc kiểm tra (`Pre-condition`):** `GridSlotObject.state != Empty`.
- **Hành vi (`Action`):**
  1. Gán `GridSlotObject.moisture_level = 100`.
  2. Cập nhật animation sprite của ô đất sang `Soil_Wet`.
  3. Phát `EventBus.Emit("FlowerWatered", "{ \"grid_x\": " + grid_x + ", \"grid_y\": " + grid_y + ", \"new_moisture\": 100 }")`.

### `HarvestFlower(grid_x: number, grid_y: number)`
- **Quy tắc kiểm tra (`Pre-condition`):** `GridSlotObject.stage == 3 (Blooming)`.
- **Hành vi (`Action`):**
  1. Đọc thuộc tính `yield_item_id` từ `flower_catalog.json`.
  2. Phát `EventBus.Emit("FlowerHarvested", "{ \"flower_id\": \"" + yield_item_id + "\", \"yield_qty\": 1, \"grid_x\": " + grid_x + ", \"grid_y\": " + grid_y + " }")`.
  3. Xóa ô đất (`GridSlotObject.ResetToEmpty()`) hoặc trả về `Stage 2` nếu là cây lâu năm (`perennial trait`).

---

## 4. Returned Data Structures (`Cấu Trúc Dữ Liệu Trả Về / Đối Tượng`)

Đối tượng thực thể cây hoa trên lưới (`FlowerInstanceObject`) mang các thuộc tính instance:
```json
{
  "instance_id": "flower_inst_001",
  "flower_ref_id": "flower_white_lily",
  "grid_x": 5,
  "grid_y": 8,
  "stage": 2,
  "accumulated_minutes": 85,
  "moisture_level": 70,
  "is_stasis": false
}
```

---

## 5. API Versioning & Compatibility Matrix (`Bản Đồ Tương Thích Phiên Bản`)

Mọi thay đổi đối với hợp đồng API của `FlowerModule` phải được cập nhật vào bảng dưới đây để các AI Agent và kỹ sư sau này nhận biết ngay lập tức các thay đổi breaking:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        FLOWER API COMPATIBILITY                        │
├────────────────────────────────────────────────────────────────────────┤
│ API Version:        │ 1.0.0-M1                                         │
│ Compatible Since:   │ Milestone M1 (Vertical Slice Garden)             │
│ Authoritative Owner:│ Core Module 01 (Flower Module)                   │
│ Deprecated APIs:    │ None                                             │
│ Breaking Changes:   │ None                                             │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Signal Ownership & Subscriber Registry (`Ma Trận Sở Hữu & Lắng Nghe Tín Hiệu`)

Để ngăn chặn nhầm lẫn ai là người phát và ai là người nhận khi debug qua Event Bus, dưới đây là đặc tả sở hữu từng tín hiệu (`Signal Ownership`):

| Signal Name | Authoritative Owner (`Module Sở Hữu`) | Publisher (`Hệ Thống Phát`) | Authorized Subscribers (`Các Hệ Thống Lắng Nghe`) |
| --- | --- | --- | --- |
| `FlowerHarvested` | **Flower Module (01)** | `FlowerSystem` (`flower_system.json`) | `InventorySystem` (cộng Satchel), `QuestSystem` (đếm nhiệm vụ), `JournalSystem` (ghi nhận kinh nghiệm), `AudioSystem` (phát SFX thu hoạch). |
| `FlowerWatered` | **Flower Module (01)** | `FlowerSystem` | `AudioSystem` (SFX nước tưới), `WeatherSystem` (đồng bộ độ ẩm). |
| `FlowerBloomed` | **Flower Module (01)** | `FlowerSystem` | `AudioSystem` (SFX chuông nở rực rỡ), `JournalSystem` (ghi nhận lần nở đầu tiên). |
| `HybridMutationOccurred` | **Flower Module (01)** | `FlowerSystem` | `InventorySystem` (thêm hạt giống lai vào Satchel), `JournalSystem` (mở khóa nhật ký hoa hiếm). |
