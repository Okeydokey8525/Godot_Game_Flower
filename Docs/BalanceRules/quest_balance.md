# 📜 Quest Balance & Gameplay Validation Rules

Tài liệu này xác lập **Quy tắc Cân bằng Nhiệm vụ & Thưởng Phạt (`Quest Balance & Reward Audit Rules`)** cùng **Ý đồ Thiết kế (`Design Intent`)** trong Plant Tales. Nhiệm vụ là động lực dẫn dắt người chơi khám phá, nhưng nếu phần thưởng vượt quá khuyến nghị hoặc cấu trúc phụ thuộc bị vòng lặp, nền kinh tế sẽ đổ vỡ ngay lập tức.

---

## 1. Khung Phần Thưởng Theo Mức Độ Nhiệm Vụ (`Reward Brackets by Quest Type`)

| Loại Nhiệm Vụ (`Type/Difficulty`) | Mô Tả Yêu Cầu (`Step Requirements`) | Ngưỡng Thưởng Vàng (`Gold Reward Bounds`) | Ngưỡng Thưởng Vật Phẩm (`Item Reward Bounds`) |
| :---: | :--- | :---: | :--- |
| **Intro / Tutorial** | Thu hoạch/Nói chuyện 1-3 lần (`quest_001..003`) | `50 ~ 200 Gold` | `2 ~ 5 Hạt giống cơ bản` |
| **Seasonal Routine** | Giao nộp 3-6 hoa Tier 1/Tier 2 theo mùa | `180 ~ 450 Gold` | `1 ~ 3 Hạt giống trung cấp` |
| **Rare / Challenge** | Giao nộp hoa hiếm Tier 3 (`Lotus, Orchid`) | `500 ~ 1,000 Gold` | `1 ~ 3 Hạt giống hiếm` |
| **Mastery / Legacy** | Giao nộp hoa toàn bộ 4 mùa (`quest_015`) | `2,000 ~ 6,000 Gold` | Danh hiệu / Ký ức đặc biệt |

### 🎯 Ý Đồ Thiết Kế (`Design Intent — Why each quest type exists`):
- **Intro / Tutorial (`quest_001..003`):**
  - *Intent:* Dẫn dắt người chơi làm quen với NPC (`Thomas, Anna`) và vòng lặp gieo - tưới - thu hoạch - giao nộp. Thưởng ngay một lượng vàng nhỏ và hạt giống mới để tạo động lực tiếp tục trồng trọt (`Immediate positive reinforcement`).
- **Seasonal Routine (`quest_004..008, 013, 014`):**
  - *Intent:* Định hình nhịp sống của làng quê qua từng mùa (`Seasonal Flavor & Goal Setting`). Cung cấp cho người chơi mục tiêu ngắn hạn (`2-5 ngày`) ngoài việc bán hoa ra chợ. Thưởng hạt giống đặc trưng của mùa tiếp theo để chuẩn bị quá trình chuyển giao mùa mượt mà.
- **Resource Sinks (`quest_010..011 — Blacksmith Copper & Iron`):**
  - *Intent:* Thúc đẩy người chơi tương tác với Marcus và đầu tư vào nâng cấp công cụ. Thay vì chỉ thưởng vàng, các nhiệm vụ này mở ra các tiện ích mới (`Watering Can Upgrade`, `Faster Action Pace`), đóng vai trò như các mốc tiến trình dài hạn (`Mid-game Progression Gates`).
- **Mastery / Challenge (`quest_009, 012, 015 — Sacred Lotus, Moonlight Orchid, Grand Botanist`):**
  - *Intent:* Thử thách cao nhất cho những người chơi đam mê lai tạo và sưu tầm toàn bộ danh mục hoa (`Endgame Prestige & Completionist Goal`). Thưởng số vàng lớn xứng đáng (`1,000 ~ 5,000 Gold`) và huy chương danh giá nhằm chốt lại hoàn hảo trải nghiệm Vertical Slice.

### Quy tắc kiểm tra tự động (`Validator Enforcement`):
- **Rule Q-001 (Gold Reward Ceiling):** Nếu nhiệm vụ thông thường (`repeatable == true` hoặc không mang tag `mastery`) có thưởng `gold > 1500` ➔ Phát cảnh báo: `[WARNING] Quest '{id}' gold reward ({gold}) exceeds non-mastery ceiling (1500 Gold). Inflation risk!`
- **Rule Q-002 (Effort vs Reward Proportionality):** Tổng giá trị phần thưởng (Vàng + Giá bán hạt thưởng) không được cao gấp hơn `4 lần` tổng giá trị hoa giao nộp (`Step target sell_price * count`). Nếu vượt quá, người chơi sẽ chỉ làm nhiệm vụ thay vì bán hoa ra chợ.
- **Rule Q-003 (Circular Dependency Check):** Cấm vòng lặp phụ thuộc nhiệm vụ (`Quest A depends on B, B depends on A`). Nếu phát hiện, hệ thống nạp tự động khóa ngay (`CRITICAL AUDIT ERROR`).

---

## 2. Quy Tắc Lặp Lại & Mùa (`Repeatability & Seasonal Constraints`)

- **Rule Q-004 (Repeatable Reward Dampening):** Các nhiệm vụ lặp lại hàng ngày/tuần (`repeatable: true`) chỉ được phép thưởng Vàng (`Gold`) hoặc hạt giống Tier 1, cấm thưởng công cụ nâng cấp hoặc tài nguyên hiếm để tránh farm lạm phát.
