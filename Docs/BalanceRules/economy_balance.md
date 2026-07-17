# 💰 Economy Balance & Progression Audit Rules

## M4.2B Authoritative Economy Methodology

All time conversions use [Time Convention](../Architecture/Time_Convention.md).
`ROI/day` is an analytical rate; it does not credit wallet gold. The authoritative
wallet simulation credits sale value only when a crop reaches its harvest event and
records the corresponding seed purchase as a sink.

### Fixed-Anchor Normalized ROI Score (v1)

The report retains raw `profit`, `ROI`, `ROI/day`, `ROI/stamina`, and `ROI/tile`.
It additionally reports a stable 0–100 score:

```text
score = clamp(100 × (ROI/day − 10) / (95 − 10), 0, 100)
```

The fixed anchors are **10 G/day** (minimum viable economic pacing) and **95 G/day**
(upper balance ceiling). They are policy constants for M4.2B v1, not values derived
from the present crop list. A content change therefore changes only that crop's
score; it cannot rescale every other crop as EOS did. Any future anchor change is a
versioned balance decision and requires rerunning the full report. The old
best-crop-relative Economic Opportunity Score (EOS) is deprecated and is not an
acceptance metric.

### Simulation authority and KPI policy

`scratch/simulation_core.py` is the single deterministic economy authority used by
both economy validation and telemetry production. It runs 50 seeded simulations,
models planting, maturity, harvest, wallet income, and seed spending. It does not
invent festival income and does not use quest rewards as an assumed Autumn subsidy.

Autumn passes only when the unified mean net gold is at least `9,000 G`. The money
sink report uses `money_spent / money_earned` and fixed categories: `seeds`,
`tools`, `shop`, `festival`, `upgrades`, and `other`. Categories without an
authoritative transaction remain zero, not inferred spending.

Inventory-full frequency is `null / not_observable` until a canonical stack-capacity
rule and an `InventoryFull` event exist. It must never be reported as zero.

Tài liệu này xác lập **Quy tắc Cân bằng Tổng thể Nền kinh tế (`Macro-Economic & Progression Rules`)** cùng **Ý đồ Thiết kế (`Design Intent`)** trong Plant Tales. Mục tiêu tối thượng là đảm bảo người chơi có cảm giác thành tựu và thu nhập gia tăng đều đặn qua từng mùa mà không rơi vào trạng thái nghèo kiệt sức (`Starvation Lock`) hoặc giàu quá mức mất động lực (`Hyper-Inflation`).

---

## 1. Chu Kỳ Thu Nhập Kế Hoạch (`Expected Seasonal Income Targets`)

Một mùa trong Plant Tales dài `28 ngày game`. Bảng dưới đây quy định thu nhập kỳ vọng trung bình của một người chơi chăm chỉ:

| Giai Đoạn (`Progression Phase`) | Thu Nhập Ngày (`Daily Income`) | Thu Nhập Mùa (`Seasonal Net Gold`) | Chi Tiêu Kế Hoạch (`Major Sinks`) |
| :--- | :---: | :---: | :--- |
| **Mùa 1 (Spring — Khởi nghiệp)** | `50 ~ 150 Gold` | `1,500 ~ 3,500 Gold` | Mua hạt giống cơ bản, mở rộng 1 lần (`500G`) |
| **Mùa 2 (Summer — Tăng tốc)** | `150 ~ 350 Gold` | `4,000 ~ 8,000 Gold` | Nâng cấp bình tưới (`500G+Copper`), mở rộng đất |
| **Mùa 3 (Autumn — Lai tạo hiếm)** | `350 ~ 650 Gold` | `9,000 ~ 16,000 Gold` | Mua hạt giống quý, đầu tư tự động hóa |
| **Mùa 4 (Winter — Nghệ nhân)** | `500 ~ 1,000 Gold` | `15,000 ~ 25,000 Gold` | Hoàn thành bộ sưu tập, mua kỷ vật hiếm |

### 🎯 Ý Đồ Thiết Kế (`Design Intent — Economic Pacing & Gold Sinks`):
- **Spring (Khởi nghiệp):**
  - *Intent:* Giúp người chơi học cách đầu tư xoay vòng vốn (`Seed Re-investment`). Chi tiêu thấp, thu nhập đủ để cảm nhận sự phát triển qua mỗi đợt hoa nở.
- **Summer (Tăng tốc & Đầu tư công cụ):**
  - *Intent:* Người chơi bắt đầu thấy sự mệt mỏi nếu phải tưới từng ô đất (`Stamina/Time pressure`). Đây là lúc xuất hiện nhu cầu nâng cấp `Watering Can` (tưới 3x1 ô) với chi phí `500 Gold + Copper`, tạo động lực tích lũy vàng mười ngày giữa mùa Hạ.
- **Autumn (Mở rộng quy mô & Lai tạo):**
  - *Intent:* Thu nhập tăng đột phá nhờ các loài hoa giá trị cao (`Peony, Orchid`). Người chơi chuyển sang chi tiêu vàng cho hạt giống hiếm và mở rộng toàn bộ lưới đất nhà kính.
- **Winter (Hoàn thiện & Vinh danh):**
  - *Intent:* Trải nghiệm nghệ nhân (`Endgame Prestige`). Nền kinh tế ổn định, vàng được dùng để sưu tầm toàn bộ danh mục và hoàn thành các thử thách danh dự của thị trưởng Elena.

### Quy tắc kiểm tra tự động (`Validator Enforcement`):
- **Rule E-001 (Daily Income Cap):** Không một đơn hàng bán lẻ hoa (`single stack harvest <= 10`) nào được tạo ra dòng tiền vượt quá `2,000 Gold` trong một lần thu hoạch thông thường nếu không phải hoa lai biến dị.
- **Rule E-002 (Tool Upgrade Sinks Proportionality):** Giá nâng cấp công cụ (`tool_watering_can_upgrade`) phải tỷ lệ thuận với thu nhập mùa (`500 ~ 1500 Gold`). Nếu giá nâng cấp `< 100 Gold` ➔ Cảnh báo quá rẻ; nếu `> 10,000 Gold` ➔ Cảnh báo gây nản lòng (`Softlock barrier`).

---

## 2. Quy Tắc Lạm Phát & Hoàn Tiền (`Inflation & Refund Dampening`)

- **Rule E-003 (Seed Buy vs Sell Margin):** Tỷ lệ `buy_price` của hạt giống so với `sell_price` của hoa thu hoạch từ hạt đó phải luôn duy trì ở mức tối thiểu `1 : 2.5` và tối đa `1 : 4.0`. Nếu vượt ra ngoài khung này, hệ thống kiểm tra tự động (`ContentManagerSystem`) phải ghi log cảnh báo chênh lệch biên độ lợi nhuận (`Abnormal Profit Margin`).
