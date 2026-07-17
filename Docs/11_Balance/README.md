# Balance Layer Index (`Docs/11_Balance/`)

**Tảng kiến trúc cuối cùng của Studio Operating System — Phân tách tường minh giữa Quy tắc (`Rules / WHAT`) và Chỉ số cân bằng (`Balance / NUMBERS`).**

---

## 1. Triết Lý Phân Tách Rules vs. Balance

Trong các studio AAA và các dự án game quy mô lớn, **Quy tắc (`Game Rules`)** và **Chỉ số cân bằng (`Balance Tables`)** luôn được tách biệt thành 2 tầng độc lập:
- **Game Rules (`Docs/08_Game_Rules_Bible/`):** Trả lời câu hỏi *WHAT* và *WHY*. Ví dụ: "Hoa lớn qua 4 giai đoạn, cần tưới nước, nếu khô đất thì ngủ đông (`Stasis`) chứ không chết héo (`Rule 001`)."
- **Game Balance (`Docs/11_Balance/`):** Trả lời câu hỏi *HOW MUCH* / *NUMBERS*. Ví dụ: "Hạt giống Hoa Hồng Đỏ (`Rose`) mua tốn `80 Gold`, mất `18 giờ` để lớn lên, bán được `220 Gold`, thuộc độ hiếm `Rare`."

Nhờ sự phân tách này, khi Game Designer hoặc AI Agent cần điều chỉnh giá bán hay giảm thời gian mọc cây để cân bằng kinh tế (`Economic Tuning`), họ **chỉ sửa tệp chỉ số trong `11_Balance/` (hoặc tệp `catalog.json` tương ứng)** mà không bao giờ đụng vào hay phá vỡ các quy tắc logic hay mã nguồn Event Sheet.

---

## 2. Danh Mục Tài Liệu Cân Bằng (`Balance Registry Table`)

| Mã Tài Liệu | Đường Dẫn (`Authoritative Link`) | Phạm Vi Chỉ Số Cân Bằng (`Numerical Scope Governed`) | Tệp JSON Đồng Bộ (`Sync Target`) | Trạng Thái (`Status`) |
| --- | --- | --- | --- | :---: |
| **01** | [01_Flower_Balance.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/11_Balance/01_Flower_Balance.md) | Giá hạt giống, thời gian sinh trưởng từng stage, giá thu hoạch, độ hiếm & tỷ lệ lai tạo | `Source/Data/Static/flower_catalog.json` | ✅ `Approved v1.0` |
| **02** | `02_Economy_Balance.md` *(Pending)* | Lạm phát 0%, giá mua/bán công cụ (`Watering Can`, `Satchel Upgrades`), phần thưởng Daily Quests | `Source/Data/Static/item_catalog.json` | `Scheduled (M3)` |
| **03** | `03_NPC_Balance.md` *(Pending)* | Ngưỡng điểm thiện cảm (`Heart Points`: `100 HP = 1 Heart`), điểm thưởng quà Yêu (+50) / Ghét (-10) | `Source/Data/Static/npc_catalog.json` | `Scheduled (M3)` |
| **04** | `04_Weather_Balance.md` *(Pending)* | Trọng số xuất hiện thời tiết theo mùa (`Spring: 60% Sunny, 30% Rain, 10% Fog`), hệ số nhân tốc độ | `Source/Data/Static/weather_profiles.json`| `Scheduled (M3)` |
| **05** | `05_Festival_Balance.md` *(Pending)* | Điểm trang trí yêu cầu để mở khóa mầm non hiếm, quà kỷ niệm lễ hội | *(TBD)* | `Scheduled (M5)` |

---

## 3. Quy Tắc Đồng Tiến Hóa (`Balance ↔ JSON Co-Evolution`)
Mọi con số trong tài liệu `Docs/11_Balance/` là nguồn sự thật duy nhất (`Single Source of Truth`). Khi cập nhật bất kỳ con số nào trong bảng cân bằng dưới đây, AI Agent phải đồng bộ chính xác vào tệp catalog JSON tĩnh tương ứng trong `Source/Data/Static/`.
