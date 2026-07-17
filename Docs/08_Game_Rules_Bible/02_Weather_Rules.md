# Chapter 02: Weather, Time & Season Rules (`Atmospheric & Temporal Laws`)

**Quy tắc điều phối thời gian thế giới, chu kỳ 4 mùa, hệ số chiếu sáng và các hiện tượng thời tiết bình yên (`Cozy Weather Mechanics`) trong Plant Tales.**

---

## 1. Constitutional Rule 002: No Destructive Natural Disasters (`Luật Bất Biến: Không Thiên Tai Phá Hủy`)

Trong các tựa game sinh tồn hoặc nông nghiệp có yếu tố hardcore, thiên tai như bão lớn (`Typhoons`), sấm sét hay hạn hán cực đoan có thể quật ngã cây trồng, phá hủy nhà kính hoặc giết chết gia súc, tạo ra cảm giác căng thẳng và tước đoạt thành quả lao động của người chơi.

> [!IMPORTANT]
> **CONSTITUTIONAL LAW IN PLANT TALES**
> Thời tiết trong Plant Tales được thiết kế để **TĂNG CƯỜNG CHIỀU SÂU THẨM MỸ VÀ HỖ TRỢ NGƯỜI CHƠI (`Visual Beauty & Gameplay Aid`)**, tuyệt đối không bao giờ phá hủy khu vườn. Không có bão tố quật ngã hoa, không có sét đánh cháy cây. Mưa rào chỉ giúp tưới nước miễn phí (`moisture_level = 100`), sương mù chỉ giúp giữ ẩm lâu hơn, và nắng ấm giúp cây sinh trưởng đều đặn.

---

## 2. Chu Kỳ Thời Gian & Lịch Trình 4 Mùa (`Time Ticker & Seasonal Calendar`)

Hệ thống thời gian thế giới được điều phối tập trung thông qua `TimeTicker Singleton` (`TimeMinuteTicked` mỗi 1 giây ngoài đời tương ứng `+10 phút` game time):

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        TEMPORAL CALENDAR HIERARCHY                     │
├────────────────────────────────────────────────────────────────────────┤
│ 1 Hour (60 mins)  ──► 6 ticks (6 giây đời thực ở tốc độ tiêu chuẩn)    │
│ 1 Day (24 hours)  ──► 144 ticks (24 phút đời thực / ngày game)         │
│ 1 Season (28 days)──► Chu kỳ mùa chuẩn (`Spring -> Summer -> Autumn`)  │
│ 1 Year (4 seasons)──► `Spring -> Summer -> Autumn -> Winter`           │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Danh Mục Thời Tiết & Hệ Số Tác Động (`Weather Profiles Matrix`)

Toàn bộ thời tiết được lưu trong tệp tĩnh `weather_profiles.json` và thực thi theo công thức vô danh (`ADR-005`):

| Weather ID (`Mã Thời Tiết`) | Tên Hiển Thị (`Display Name`) | Cờ Mưa (`is_raining`) | Hệ Số Độ Ẩm (`moisture_modifier`) | Tints Ánh Sáng (`light_tint_hex`) | Tác Động Đặc Biệt Lên Nhà Kính & Hoa (`Gameplay Impact`) |
| --- | --- | :---: | :---: | --- | --- |
| `weather_sunny` | Nắng Ấm (`Sunny Day`) | `false` | `1.0x` | `#FFFFFF` (Trong suốt) | Tiêu chuẩn. Đất khô `-2% / 10 phút`. |
| `weather_spring_rain` | Mưa Rào Mùa Xuân | `true` | `2.0x` | `#D0E8FF` (Xanh dịu mát)| Tự động khóa độ ẩm toàn bộ ô đất ở `100%`. Gia tốc lớn hoa `+25%`. |
| `weather_morning_fog`| Sương Mù Buổi Sớm | `false` | `1.2x` | `#EAEAEB` (Bạc sương mù)| Giảm hao hụt độ ẩm xuống `-1% / 10 phút`. Tăng tỷ lệ lai hoa `+5%`. |

---

## 4. Thuật Toán Lựa Chọn Thời Tiết Hàng Ngày (`Daily Weather Generation Engine`)

Tại thời điểm chuyển ngày (`06:00 AM — DayAdvanced`), `WeatherSystem` tính toán thời tiết ngày mới dựa trên tỷ lệ theo mùa (`Seasonal Weights Table`):

$$\text{NextWeather} = \text{WeightedRandom}(\text{SeasonProfiles}[g\_TimeTicker.current\_season], \text{WorldSeed} + current\_day)$$

- **Bảo chứng xác định (`Deterministic Seed Guarantee`):** Khi kiểm thử với `g_WorldSeed = 123456`, thời tiết của Ngày 1 luôn là `weather_sunny`, Ngày 2 luôn là `weather_spring_rain` và Ngày 3 luôn là `weather_morning_fog`, đảm bảo kiểm thử QA chính xác tuyệt đối.

---

## 5. Bảng Kịch Bản Kiểm Định QA (`Verification Test Cases`)

| Test ID | Rule Liên Quan (`Rule Governed`) | Kịch Bản Thiết Lập (`Setup / Trigger Steps`) | Kết Quả Mong Đợi (`Expected Deterministic Result`) | Trạng Thái (`QA Status`) |
| --- | --- | --- | --- | :---: |
| **TC-WE-01** | `Rule 002 (No Disaster)` | 1. Đặt thời tiết là `weather_spring_rain`.<br>2. Chờ 24 giờ simulation ngoài trời. | Không có cây nào bị gãy đổ hay mất tác dụng. Độ ẩm toàn nhà kính được duy trì ở mức `100%`. | ✅ `Passed` |
| **TC-WE-02** | `Rain Moisture Restoration`| 1. Các ô đất đang có `moisture_level = 10%`.<br>2. Kích hoạt tín hiệu `EventBus.Emit("WeatherChanged", { "weather_id": "weather_spring_rain" })`. | `WeatherSystem` cập nhật, `FlowerSystem` nhận tín hiệu và tức thì phục hồi toàn bộ 400 ô đất về `moisture_level = 100`. | ✅ `Passed` |
| **TC-WE-03** | `Light Tint Transition` | 1. Đồng hồ chuyển sang `18:00 PM` (Hoàng hôn) và `22:00 PM` (Đêm). | Lớp `LightTintLayer` đổi màu chính xác sang `#FFD8B0` lúc 18:00 và `#202840` lúc 22:00 một cách mượt mà (`Fade 1.5s`). | ✅ `Passed` |
| **TC-WE-04** | `Deterministic Generation` | 1. Khởi động lại game với `DEBUG_SEED = 123456`.<br>2. Tiến thời gian đến Ngày 2 `06:00 AM`. | Thời tiết Ngày 2 phát ra từ `WeatherSystem` chính xác là `weather_spring_rain` 100% số lần chạy thử. | ✅ `Passed` |
