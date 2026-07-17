# 🌸 Flower Balance & Gameplay Validation Rules

> **Canonical time reference:** Historical day-language in this document is design intent only. Use [Time Convention](../Architecture/Time_Convention.md) for `growth_time` storage and every validation or balancing conversion.

Tài liệu này xác lập **Quy tắc Cân bằng Gameplay & Thông số Sinh trưởng (`Gameplay Validation Rules`)** cùng **Ý đồ Thiết kế (`Design Intent`)** cho toàn bộ hệ thống Hoa (`Flower Definitions`) trong Plant Tales. Bất kỳ tệp JSON định nghĩa hoa nào vi phạm các ngưỡng này sẽ kích hoạt cảnh báo (`WARNING`) hoặc từ chối hợp lệ (`ERROR`) từ động cơ kiểm định tự động (`Automated Content Audit — M4.1D`).

---

## 1. Phân Cấp Khung Sinh Trưởng & Giá Bán (`Growth & Price Brackets by Tier`)

Để đảm bảo đường cong kinh tế (`Economic Curve`) và nhịp thu hoạch không bị phá vỡ, các hoa được phân chia thành 3 Tier chính:

| Tier | Độ Khó / Loại | Historical pacing notes (not a conversion rule) | Ngưỡng Giá Bán (`sell_price` Gold) | Ngưỡng Giá Hạt (`buy_price` Gold) | Tỷ Suất Lợi Nhuận Khuyến Nghị (`ROI`) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **Tier 1** | Cây trồng cơ bản, khởi đầu nhanh | `180 ~ 360 phút` (`3 ~ 5 ngày game`) | `15 ~ 30 Gold` | `5 ~ 12 Gold` | `150% ~ 250%` |
| **Tier 2** | Cây trung cấp, cần chăm bón | `420 ~ 540 phút` (`6 ~ 8 ngày game`) | `35 ~ 60 Gold` | `15 ~ 25 Gold` | `200% ~ 300%` |
| **Tier 3** | Cây cao cấp, hoa lai, hiếm | `600 ~ 960 phút` (`9 ~ 14 ngày game`) | `80 ~ 150 Gold` | `30 ~ 60 Gold` | `250% ~ 400%` |

### 🎯 Ý Đồ Thiết Kế (`Design Intent — Why each flower exists`):
- **`flower_white_lily` (Tier 1 - Spring):**
  - *Intent:* Hoa hướng dẫn (`Tutorial Starter`). Tốc độ mọc nhanh nhất (`180p / 3 ngày`), chịu hạn tốt để không phạt người chơi mới quên tưới nước. Dùng cho nhiệm vụ đầu tiên `quest_001`.
- **`flower_rose` (Tier 1 - Spring/Summer):**
  - *Intent:* Cây chủ lực giai đoạn đầu (`Early-game Cash Crop`). Lợi nhuận ổn định, yêu cầu tưới đều đặn mỗi ngày. Là quà tặng yêu thích (`Loved Gift`) của Anna để dạy cơ chế Heart Points.
- **`flower_sunflower` (Tier 2 - Summer):**
  - *Intent:* Cây kiếm tiền chính giữa mùa Hạ (`Mid-Summer Economic Engine`). Thời gian mọc `420p` (`7 ngày`), yêu cầu nắng trời chói chang (`weather_sunny`). Là mục tiêu cất trữ cho `quest_003`.
- **`flower_lavender` & `flower_tulip` (Tier 1/2 - Spring/Summer):**
  - *Intent:* `Tulip` là hoa đầu mùa hạ (`Early Summer Flower`), chi phí bảo dưỡng cực thấp (`low maintenance`), đem lại dòng tiền ổn định trước khi mở khóa `Lavender`. `Lavender` có giá bán cao hơn nhưng cần thời gian chín trọn vẹn 6 ngày, là nguyên liệu pha trà cho `quest_004`.
- **`flower_daisy` & `flower_iris` (Tier 1/2 - Autumn):**
  - *Intent:* `Daisy` là hoa mọc cụm mùa thu (`Autumn Filler`), chu kỳ nhanh (`3 ngày`). `Iris` là hoa mọc gần ven hồ mưa (`Rain-loving Crop`), sinh trưởng bùng nổ khi gặp thời tiết `weather_rain`.
- **`flower_peony` & `flower_carnation` (Tier 2 - Autumn/Winter):**
  - *Intent:* Cây cầu nối kinh tế sang mùa đông. `Peony` cần bón và chăm chút kỹ lưỡng đem lại phần thưởng lớn cho nhiệm vụ chế nước hoa `quest_008`. `Carnation` chịu lạnh bền bỉ giữ cho khu vườn mùa đông không bị đóng băng hoàn toàn.
- **`flower_bluebell` (Tier 1 - Winter):**
  - *Intent:* Hoa chuông xanh mùa đông (`Winter Survival Crop`). Sinh trưởng ngay dưới lớp tuyết và sương mù, giúp người chơi duy trì cảm giác chăm bón hàng ngày trong điều kiện khắc nghiệt.
- **`flower_lotus` & `flower_orchid` (Tier 3 - Legendary / Sacred):**
  - *Intent:* `Lotus` (`Sacred Lotus`) và `Orchid` (`Moonlight Orchid`) là các hoa tối thượng (`Endgame Prestige Flowers`). Thời gian sinh trưởng dài (`12-14 ngày`), tỷ lệ biến dị hiếm, đem lại số vàng khổng lồ (`120-150 Gold`) và dùng để hoàn thành chuỗi nhiệm vụ `Grand Botanist`.

### Quy tắc kiểm tra tự động (`Validator Enforcement`):
- **Rule F-001 (Price/Tier Consistency):** Nếu `tier == 1` mà `sell_price > 35` hoặc `< 10` ➔ Phát cảnh báo: `[WARNING] Flower '{id}' sell_price ({sell_price}) out of Tier 1 range (15~30).`
- **Rule F-002 (Growth Time Bounds):** Evaluate canonical `growth_time` in gameplay minutes according to [Time Convention](../Architecture/Time_Convention.md). Historical bounds here are not a minutes-to-days conversion rule.
- **Rule F-003 (ROI Integrity):** Nếu `sell_price <= buy_price` ➔ Phát lỗi nghiêm trọng: `[CRITICAL AUDIT FAIL] Flower '{id}' sell_price ({sell_price}) <= buy_price ({buy_price}). Infinite loss loop!`

---

## 2. Quy Tắc Tương Thích Mùa & Thời Tiết (`Season & Weather Affinity Rules`)

- **Rule F-004 (Winter Hardy Check):** Hoa sinh trưởng tốt vào mùa Đông (`winter`) phải thuộc nhóm chịu lạnh (`hardy` hoặc `tier >= 2`), cấm cấu hình `preferred_weather = "weather_sunny"` cho hoa mùa đông nếu không có giải thích đặc biệt trong tags.
- **Rule F-005 (Water Consumption Limit):** Lượng nước tiêu thụ mỗi giai đoạn (`moisture_per_stage`) phải nằm trong khoảng `10 ~ 40%`. Nếu `> 50%` sẽ khiến người chơi phải tưới 3 lần/ngày gây mệt mỏi (`Frustration Loop`).

---

## 3. Khung Lai Tạo Di Truyền (`Hybrid Mutation Rules`)

- **Rule F-006 (Mutation Rate Limit):** Tỷ lệ biến dị (`mutation_chance`) không được vượt quá `25%` (`0.25`) để bảo toàn độ hiếm và cảm hứng chinh phục. Ngưỡng chuẩn: `10% ~ 18%`.
