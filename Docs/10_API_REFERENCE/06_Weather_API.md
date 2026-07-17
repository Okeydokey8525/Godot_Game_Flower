# WeatherModule API Reference (`Core Module 06 Spec v1.0`)

**Tài liệu đặc tả lập trình dành cho lập trình viên & AI Agent thao tác với hệ thống điều phối thời gian & thời tiết (`WeatherSystem`).**

---

## 1. Public Events (`Sự Kiện Phát Ra — Published Signals`)
Các tín hiệu mà `WeatherSystem` (hoặc `TimeTicker Singleton`) phát ra lên `Global Event Bus` (`EventBus.Emit()`) theo Trục Thời Gian chuẩn:

| Signal Name (`Tên Sự Kiện`) | JSON Payload Structure (`Cấu Trúc Payload`) | Thời Điểm Phát Ra (`Trigger Hook`) | Modules Lắng Nghe (`Authorized Consumers`) |
| --- | --- | --- | --- |
| `WeatherChanged` | `{ "weather_id": "string", "is_raining": boolean, "moisture_modifier": number }` | Khi thời tiết thay đổi lúc `06:00 AM` (hoặc mốc chuyển nhịp trưa/tối). | `FlowerModule` (phục hồi `moisture = 100` nếu mưa), `AudioModule` (phát BGM mưa rào/nắng dịu), `NPCModule` (townsfolk che ô/về nhà). |
| `DayAdvanced` | `{ "day": number, "season": "string" }` | Khi đồng hồ điểm đúng `06:00 AM` chuyển sang ngày mới. | `FlowerModule` (kiểm tra lai tạo di truyền), `NPCModule` (nạp lịch trình sinh hoạt mới), `EconomyModule` (làm mới kệ hàng). |
| `SeasonAdvanced`| `{ "old_season": "string", "new_season": "string" }`| Khi `current_day` vượt quá 28 và bước sang mùa kế tiếp. | `FlowerModule` (kiểm tra cây theo mùa), `AudioModule`, `FestivalModule`. |

---

## 2. Consumed Signals (`Sự Kiện Lắng Nghe — Consumes`)
`WeatherSystem` lắng nghe các tín hiệu từ `EventBus` để tính toán trạng thái thời tiết:

| Signal Name (`Sự Kiện Lắng Nghe`) | Module Phát Ra (`Publisher`) | Hành Vi Thực Thi Của WeatherSystem (`System Response`) |
| --- | --- | --- |
| `TimeMinuteTicked` | `TimeTicker Singleton`| Kiểm tra giờ hiện tại (`current_hour`). Nếu đạt mốc `18:00` hoặc `22:00`, tự động điều chỉnh màu lớp ánh sáng `LightTintLayer` (Hoàng hôn / Đêm). |
| `DayAdvanced` | `TimeTicker Singleton`| Thực thi thuật toán `EvaluateDailyWeather()` dựa trên `g_WorldSeed + current_day`, phát tín hiệu `WeatherChanged`. |

---

## 3. Public Functions (`Các Hàm / Hành Vi Thực Thi Nội Bộ`)
Mô tả logic chuẩn xác bên trong `Source/Systems/weather_system.json`:

### `EvaluateDailyWeather(seed_offset: number)`
- **Quy tắc kiểm tra (`Pre-condition`):** Nhận tín hiệu `DayAdvanced`.
- **Hành vi (`Action`):**
  1. Đọc bảng `weather_profiles.json`.
  2. Dùng hàm ngẫu nhiên có seed (`WeightedRandom(seed_offset)`) chọn `weather_id` theo mùa.
  3. Gán `g_CurrentWeatherId = weather_id`.
  4. Phát `EventBus.Emit("WeatherChanged", payload)`.

### `ApplyLightTint(hour: number)`
- **Hành vi (`Action`):**
  1. Đọc cấu hình màu (`light_tint_hex`) từ thời tiết hiện tại kết hợp với giờ trong ngày.
  2. Thực thi hiệu ứng `LayerTweenColor("Background", target_color, duration_seconds: 1.5)`.

---

## 4. Returned Data Structures (`Cấu Trúc Dữ Liệu Trả Về / Đối Tượng`)

Đối tượng bộ điều khiển thời tiết & thời gian (`WeatherControllerObject`) trên scene:
```json
{
  "instance_id": "weather_ctrl_001",
  "current_weather_id": "weather_spring_rain",
  "is_raining": true,
  "light_tint_hex": "#D0E8FF",
  "current_day": 2,
  "current_season": "Spring"
}
```

---

## 5. API Versioning & Compatibility Matrix (`Bản Đồ Tương Thích Phiên Bản`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        WEATHER API COMPATIBILITY                       │
├────────────────────────────────────────────────────────────────────────┤
│ API Version:        │ 1.0.0-M2                                         │
│ Compatible Since:   │ Milestone M2 (Weather & Time Cycle)              │
│ Authoritative Owner:│ Core Module 06 (Weather Module)                  │
│ Deprecated APIs:    │ None                                             │
│ Breaking Changes:   │ None                                             │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Signal Ownership & Subscriber Registry (`Ma Trận Sở Hữu & Lắng Nghe Tín Hiệu`)

| Signal Name | Authoritative Owner (`Module Sở Hữu`) | Publisher (`Hệ Thống Phát`) | Authorized Subscribers (`Các Hệ Thống Lắng Nghe`) |
| --- | --- | --- | --- |
| `WeatherChanged` | **Weather Module (06)** | `WeatherSystem` | `FlowerSystem` (hồi đủ ẩm nếu mưa), `AudioSystem` (đổi BGM), `NPCSystem` (tìm chỗ trú). |
| `DayAdvanced` | **Weather Module (06) / TimeTicker** | `TimeTicker Singleton` | `WeatherSystem` (đổi thời tiết), `FlowerSystem` (lai hoa), `NPCSystem` (đổi lịch), `SaveManager` (dirty check). |
| `SeasonAdvanced`| **Weather Module (06) / TimeTicker** | `TimeTicker Singleton` | `FlowerSystem`, `AudioSystem`, `FestivalSystem`. |
