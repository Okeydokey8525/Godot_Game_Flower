# ⚖️ Balance & Gameplay Validation Rules Repository (`Docs/BalanceRules/`)

Thư mục này chứa toàn bộ các Bộ quy tắc Kiểm định Cân bằng Gameplay, Ngân sách Tài nguyên & Hợp đồng Hiệu năng (`Automated Gameplay Balance Rules, Asset Budget & Performance Budget`). Các tài liệu ở đây không chỉ là hướng dẫn thiết kế trên giấy mà được **động cơ kiểm định tự động (`ContentManagerSystem — Layer 3 Automated Audit`)** và **QA System** đọc và thực thi trực tiếp khi kiểm duyệt nội dung của dự án Plant Tales.

---

## 📚 Mục Lục Quy Tắc Kiểm Định & Hợp Đồng (`Audit Rules & Budget Index`)

1. **[flower_balance.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/flower_balance.md):** Khung Tier 1/2/3 cho Hoa, Ý đồ Thiết kế (`Design Intent`), thời gian lớn (`growth_time_minutes`), giá bán (`sell_price`), tỷ suất lợi nhuận (`ROI`), và quy tắc tương thích thời tiết.
2. **[quest_balance.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/quest_balance.md):** Ý đồ Thiết kế từng loại nhiệm vụ (`Tutorial, Seasonal, Sink, Mastery`), ngưỡng phần thưởng nhiệm vụ (`Gold/Item bounds`), tỷ lệ công sức vs thưởng, và kiểm tra vòng lặp phụ thuộc nhiệm vụ.
3. **[economy_balance.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/economy_balance.md):** Ý đồ nhịp điệu kinh tế 4 mùa, chu kỳ thu nhập ngày/mùa (`Daily & Seasonal Income`), chống lạm phát vàng (`Inflation protection`), và biên độ lợi nhuận hạt giống.
4. **[season_balance.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/season_balance.md):** Ý đồ thời tiết và lịch trình NPC, kiểm tra tọa độ & cảnh nền hợp lệ (`Schedule Scene bounds`), khung giờ hợp lệ (`0~23`), đồ thị chống vòng lặp hội thoại (`Dialogue Graph check`).
5. **[asset_budget.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/asset_budget.md):** Bảng trần giới hạn 2 tầng (`Soft Limit Warning vs Hard Limit Merge Block`), chống phình to dự án (`Scope Creep / Bloat prevention`).
6. **[Performance_Budget.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/BalanceRules/Performance_Budget.md):** Hợp đồng Hiệu năng bất khả xâm phạm (`Frozen Performance Contract`), định nghĩa 6 chỉ số vàng (`Boot Time <0.2s, RAM <5MB, Draw Calls <250, FPS >=60`) cùng các quy tắc kiểm tra F3/F4.

---

## 4 Lớp Bảo Vệ Nội Dung Của Plant Tales (`The 4-Layer Defense Pipeline`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        CONTENT VERIFICATION PIPELINE                   │
├────────────────────────────────────────────────────────────────────────┤
│ Layer 1: Schema Validation ──► Kiểm tra đúng cấu trúc trường JSON v1.0 │
│ Layer 2: Reference Validation ──► Kiểm tra ID chéo (seed, dialogue...)  │
│ Layer 3: Gameplay & Balance Audit ──► Kiểm tra Tier, Giờ 0~23, Budget  │
│ Layer 4: Playtest Telemetry ──► Xác nhận bằng dữ liệu chơi thực tế     │
└────────────────────────────────────────────────────────────────────────┘
```
