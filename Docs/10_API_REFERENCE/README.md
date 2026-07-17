# Developer API Reference Index (`Docs/10_API_REFERENCE/`)

**Tài liệu đặc tả giao diện phát triển (`Developer Documentation / API Reference`) cho 8 Core Modules của Plant Tales.**

---

## 1. Mục Tiêu Của API Reference

Khi codebase mở rộng lên hàng nghìn dòng lệnh GDevelop và hàng trăm sự kiện, các lập trình viên hoặc AI Agent mới tham gia dự án (`Codex`, `Claude`, `ChatGPT`) cần tra cứu nhanh cách gọi hàm, các sự kiện phát ra (`Public Events`), các sự kiện lắng nghe (`Consumes`) và cấu trúc trả về (`Returns`) mà không cần phải đọc toàn bộ 10 chương `Production Bible` hay `Game Rules Bible`.

---

## 2. Danh Sách Các Module API Reference (`Core Module API Registry`)

| Mã Module | Tài Liệu API (`Developer Spec Link`) | Phạm Vi API & Trách Nhiệm (`Responsibility`) | Trạng Thái (`Status`) |
| --- | --- | --- | :---: |
| **Module 01** | [01_Flower_API.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/10_API_REFERENCE/01_Flower_API.md) | Gieo hạt, tưới nước, chia tải sinh trưởng theo thời gian & thu hoạch | ✅ `Active v1.0` |
| **Module 02** | `02_Inventory_API.md` *(Pending)* | Thêm/bớt vật phẩm Satchel, ngăn xếp (`Max Stack`) & ô chứa | `Scheduled (M2)` |
| **Module 03** | `03_NPC_API.md` *(Pending)* | Di chuyển lịch trình, tặng quà & cập nhật độ thiện cảm (`Heart Level`) | `Scheduled (M3)` |
| **Module 04** | `04_Quest_API.md` *(Pending)* | Giao nhiệm vụ, kiểm tra điều kiện hoàn thành & trao thưởng | `Scheduled (M3)` |
| **Module 05** | `05_Journal_API.md` *(Pending)* | Ghi nhận hoa thu hoạch mới, ép ký ức & mở khóa trang nhật ký | `Scheduled (M4)` |
| **Module 06** | [06_Weather_API.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/10_API_REFERENCE/06_Weather_API.md) | Cập nhật thời tiết 4 mùa, hệ số độ ẩm & ánh sáng nhà kính | ✅ `Active v1.0` |
| **Module 07** | `07_Audio_API.md` *(Pending)* | Phát âm thanh BGM, SFX & điều phối âm lượng theo cảnh | `Scheduled (M4)` |
| **Module 08** | `08_Festival_API.md` *(Pending)* | Kích hoạt sự kiện lễ hội village & kiểm tra trang trí | `Scheduled (M5)` |

---

## 3. Quy Chuẩn Đọc & Gọi API (`Contract Compliance Notice`)

Mọi lời gọi hàm hoặc lắng nghe tín hiệu trong các tài liệu API này đều phải tuân thủ tuyệt đối **Hợp Đồng Module (`Module Contracts - 10_Module_Architecture.md`)** và **Quyết Định Kiến Trúc `ADR-003`** (Cấm gọi chéo ghi dữ liệu trực tiếp, luôn đi qua Global Signal Bus).
