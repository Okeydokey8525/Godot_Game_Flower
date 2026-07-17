# Chapter 00: Universal Simulation Flow & Order (`Deterministic Engine Execution Laws`)

**Quy tắc tối cao về thứ tự mô phỏng bất biến (`Simulation Order`) và Trục Thời Gian Sự Kiện (`Event Timeline`) trong vòng lặp game Plant Tales.**

---

## 1. Luật Thứ Tự Mô Phỏng Bất Biến (`Simulation Order Rule`)

Để bảo đảm tính xác định tuyệt đối (`Deterministic Execution`), không phụ thuộc vào tốc độ khung hình (`Framerate-independent`) và ngăn chặn xung đột trạng thái khi nhiều hệ thống (`FlowerSystem`, `WeatherSystem`, `QuestSystem`) chạy đồng thời, mọi chu kỳ thời gian thế giới (`Minute Tick / Day Tick`) **BẮT BUỘC** phải thực thi theo đúng thứ tự tuyến tính 8 bước dưới đây:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   IMMUTABLE SIMULATION ORDER PIPELINE                  │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [TimeTicker Singleton] ──► Tiến đồng hồ +10 phút (phát TimeMinuteTicked)
│                               │                                        │
│                               ▼                                        │
│ 2. [WeatherSystem] ─────────► Đánh giá chu kỳ mưa & độ chiếu sáng nhà kính
│                               │                                        │
│                               ▼                                        │
│ 3. [Moisture Engine] ───────► Giảm/tăng độ ẩm đất theo hệ số thời tiết │
│                               │                                        │
│                               ▼                                        │
│ 4. [Growth Calculation] ────► Cộng dồn accumulated_minutes cho thực vật│
│                               │                                        │
│                               ▼                                        │
│ 5. [Mutation & Genetics] ───► Kiểm tra lai tạo hoa lúc 06:00 AM mỗi ngày
│                               │                                        │
│                               ▼                                        │
│ 6. [Bloom & Stage Hook] ────► Chuyển đổi stage và phát tín hiệu Bloomed│
│                               │                                        │
│                               ▼                                        │
│ 7. [Quest & Journal Sync] ──► Cập nhật chỉ số nhiệm vụ và sổ tay       │
│                               │                                        │
│                               ▼                                        │
│ 8. [Save Dirty Hook] ───────► Đánh dấu cache SaveManager.is_dirty = true
└────────────────────────────────────────────────────────────────────────┘
```

> [!CAUTION]
> **NGHIÊM CẤM ĐẢO THỨ TỰ HOẶC THỰC THI SONG SONG KHÔNG ĐỒNG BỘ**
> Nếu một AI Agent sửa đổi thứ tự (ví dụ: chạy bước `Growth Calculation` trước bước `WeatherSystem`), cây hoa sẽ bị tính sai hệ số độ ẩm của thời tiết cũ, dẫn đến sai lệch tiến trình mô phỏng giữa các ca lập trình và phá vỡ kiểm định `Deterministic Seed Checking`.

---

## 2. Trục Thời Gian Sự Kiện Chuẩn (`Event Timeline Reference`)

Khi một ngày mới bắt đầu tại `06:00 AM` hoặc tại các mốc giờ quan trọng, chuỗi sự kiện được kích hoạt theo Trục Thời Gian (`Event Timeline`) chuẩn xác sau đây:

```text
================================================================================
  DAILY EVENT TIMELINE (`06:00 AM -> 24:00 PM`)
================================================================================
[06:00 AM - DAY START]
  ├── TimeTicker.Emit("DayAdvanced", { day: current_day, season: current_season })
  ├── WeatherSystem.EvaluateDailyWeather() -> EventBus.Emit("WeatherChanged", { weather_id })
  ├── FlowerSystem.EvaluateHybridMutations() -> EventBus.Emit("HybridMutationOccurred")
  └── NPCSystem.LoadDailySchedules() -> Townsfolk rời nhà di chuyển theo route

[08:00 AM - MORNING ROADS]
  ├── NPC Thomas arrives at GreenhouseScene
  └── Store opens (`EconomySystem`)

[12:00 PM - NOON CHECK]
  └── WeatherSystem.EvaluateMiddayTransition() (Trời có thể chuyển sương mù hoặc nắng gắt)

[18:00 PM - EVENING DUSK]
  ├── LightTintLayer chuyển sang tông hoàng hôn (`#FFD8B0`)
  └── Townsfolk bắt đầu quay về khu vực Village Square

[22:00 PM - NIGHTFALL]
  └── LightTintLayer chuyển sang tông đêm thư giãn (`#202840`) — Không có quái vật hay trừng phạt!
```

---

## 3. Quy Tắc Debug & Truy Vết (`Traceability Rules`)
Khi phát hiện lỗi bất thường trong tiến trình lớn của cây hoa hay lịch trình NPC, kỹ sư/AI phải mở tệp log `g_SignalTraceHistory` trong `EventBus Singleton` và đối chiếu trực tiếp với Trục Thời Gian ở Chương 00 này để xác định chính xác bước nào đã vi phạm thứ tự mô phỏng!
