# 🌦️ Season, Weather & Schedule Audit Rules

Tài liệu này xác lập **Quy tắc Kiểm tra Tính Hợp lệ của Mùa, Thời tiết và Lịch trình di chuyển NPC (`Season, Weather & Schedule Rules`)** cùng **Ý đồ Thiết kế (`Design Intent`)** trong Plant Tales. Để thế giới game vận hành tự nhiên và không sinh lỗi vô lý (`Logical Contradictions`), mọi cấu trúc lịch trình và thời tiết đều phải tuân thủ các chuẩn mực nghiêm ngặt.

---

## 1. Ý Đồ Thiết Kế Mùa, Thời Tiết & Lịch Trình (`Design Intent`)

### 🎯 Ý Đồ Thời Tiết & Mùa (`Weather & Seasons`):
- **`season_spring` & `weather_sunny`:**
  - *Intent:* Mùa khởi động tươi sáng, tỷ lệ ngày nắng (`Sunny`) cao tới `70%` giúp người chơi dễ dự đoán và làm quen với nhịp tưới nước đều đặn mỗi sáng (`Daily Routine Building`).
- **`season_summer` & `weather_rain`:**
  - *Intent:* Mùa bùng nổ năng lượng. Tỷ lệ xuất hiện mưa (`Rain`) tăng (`35%`). Mưa có cơ chế `auto_water_crops = true`, như một "món quà" ngẫu nhiên cho phép người chơi tiết kiệm thể lực tưới nước để dành thời gian đi giao lưu NPC và làm nhiệm vụ làng quê (`Social & Exploration Opportunity`).
- **`season_autumn` & `weather_cloudy`:**
  - *Intent:* Mùa chuyển tiếp êm ả (`Harvest Season`). Trời nhiều mây (`Cloudy`) giảm tốc độ bốc hơi nước của đất, giữ cho cây hoa phát triển vững chắc trước mùa đông.
- **`season_winter`:**
  - *Intent:* Thử thách kiên nhẫn (`Reflective Season`). Nhịp độ chậm lại, chỉ hoa chịu lạnh (`Bluebell, Carnation`) mới mọc được, khuyến khích người chơi tập trung vào nhà kính và nâng cấp mối quan hệ NPC.

### 🎯 Ý Đồ Lịch Trình NPC (`NPC Schedules & Social Flows`):
- **Thomas the Florist:** Luôn ở `GreenhouseScene` buổi sáng (`08:00~12:00`) để hướng dẫn và bán hạt giống cho người chơi trước giờ làm vườn. Buổi chiều (`14:00`) đi dạo ra `VillageScene` tạo cảm giác nhân vật sống động.
- **Anna the Merchant:** Mở cửa hàng tạp hóa tại `VillageScene` vào khung giờ vàng `09:00~17:00`.
- **Marcus the Blacksmith:** Mở lò rèn từ `10:00~18:00`, nơi người chơi mang khoáng sản và vàng đến nâng cấp bình tưới lúc giữa ngày.
- **Elena the Mayor:** Đứng tại `VillageTownHallScene` buổi sáng để tiếp nhận nhiệm vụ làng, buổi tối (`19:00`) ra `VillageTavernScene` trò chuyện thư giãn cùng dân làng.

---

## 2. Quy Tắc Lịch Trình & Tọa Độ NPC (`NPC Schedule & Scene Bounds Validation`)

Mỗi NPC trong Plant Tales có lịch trình di chuyển theo ca (`default, morning, evening`).

### Quy tắc kiểm tra tự động (`Validator Enforcement`):
- **Rule S-001 (Valid Scene Check):** Tất cả các giá trị `scene` trong object `default_schedule` bắt buộc phải là một trong các Scene đã được đăng ký trong kiến trúc (`BootScene`, `MainMenuScene`, `GreenhouseScene`, `VillageScene`, `VillageTownHallScene`, `VillageTavernScene`). Nếu chứa scene không xác định (ví dụ: `"UnknownPlace"` hoặc `"VillageMarket"`) ➔ Phát lỗi nghiêm trọng: `[CRITICAL AUDIT FAIL] NPC '{id}' schedule references unknown scene '{scene}'.`
- **Rule S-002 (Coordinate Bounds Check):** Tọa độ `x, y` trong lịch trình không được âm (`< 0`) hoặc vượt quá kích thước tối đa của bản đồ village (`< 3200`).
- **Rule S-003 (Hour Valid Bounds):** Nếu lịch trình có chỉ định giờ mở cửa/chuyển ca (`open_hour`, `close_hour` hoặc `trigger_hour`), giá trị phải nằm trong khoảng chuẩn `0 ~ 23`. Nếu `= 25:00` hoặc `< 0` ➔ Phát lỗi: `[CRITICAL AUDIT FAIL] NPC '{id}' hour value invalid ({hour}).`

---

## 3. Quy Tắc Đồ Thị Hội Thoại (`Dialogue Graph & Loop Audit`)

Hội thoại nhiều nhánh (`Dialogue Branches`) kết nối các trạng thái (`lines.state` -> `lines.next_state`).

### Quy tắc kiểm tra tự động (`Validator Enforcement`):
- **Rule S-004 (Infinite Loop Detection):** Validator phải kiểm tra đồ thị chuyển tiếp nhánh (`next_state`). Nếu một trạng thái chỉ lặp lại chính nó (`state == next_state` mà không có điều kiện thoát) hoặc tạo vòng lặp kín không có nút kết thúc (`A -> B -> A` mà không có `next_state: ""` hoặc `"DONE"`) ➔ Phát cảnh báo/lỗi: `[CRITICAL AUDIT FAIL] Dialogue '{id}' has infinite loop at state '{state}'.`
- **Rule S-005 (Orphan State Check):** Bất kỳ `next_state` nào được trỏ tới phải tồn tại trong danh sách `lines` của tệp hội thoại đó (hoặc là chuỗi rỗng `""` / `"DONE"`).

---

## 4. Quy Tắc Tác Động Thời Tiết (`Weather Growth Modifiers`)

- **Rule S-006 (Growth Bonus Ceiling):** Thông số `growth_speed_bonus` trong thời tiết (`Weather`) không được vượt quá `0.5` (`+50% tốc độ`). Ngưỡng chuẩn: `-0.2 ~ +0.25`.
