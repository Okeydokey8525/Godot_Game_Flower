# Game Rules Bible Index (The Immutable Constitution)

**Bộ hiến pháp luật bất biến của dự án Plant Tales (Game Rules Bible / Immutable Constitution Index).**

---

## 1. Mục Tiêu & Vai Trò Của Game Rules Bible

**Game Rules Bible (`Docs/08_Game_Rules_Bible/`)** không phải tài liệu thiết kế kịch bản (`Design`), cũng không phải tài liệu kỹ thuật lập trình (`Code`). Đây là **Hiến pháp Tối cao — Bộ luật bất biến (*Immutable Constitution*)** của toàn bộ dự án **Plant Tales**.

Trong suốt hành trình dài phát triển và cập nhật trò chơi, dù có bổ sung thêm hàng trăm tính năng mới hay sử dụng hàng loạt AI Agent để mở rộng nội dung, chỉ cần một tính năng vi phạm bất kỳ điều luật nào trong hiến pháp này, tính năng đó lập tức bị phán quyết là **không hợp lệ và bị loại bỏ** để bảo vệ trọn vẹn bản sắc thư giãn, ấm cúng (*Cozy Identity*) của trò chơi.

---

## 2. Bảng Tra Cứu Các Chương Hiến Pháp & Quy Tắc Trò Chơi (`Rules Registry Table`)

| Mã Chương | Tên Tài Liệu & Đường Dẫn (`Authoritative Link`) | Phạm Vi Chi Phối & Nội Dung Cốt Lõi (`Core Rules Governed`) | Trạng Thái (`Status`) |
| --- | --- | --- | :---: |
| **00A** | [00_Simulation_Flow_Rules.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/08_Game_Rules_Bible/00_Simulation_Flow_Rules.md) | Thứ tự mô phỏng bất biến (`Minute -> Weather -> Growth...`) & Daily Event Timeline | ✅ `Approved` |
| **00B** | [00_Gameplay_Loops.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/08_Game_Rules_Bible/00_Gameplay_Loops.md) | Hiến pháp vòng lặp (`Core Loop 3-5m -> Secondary Loop 15m -> Meta Loop`) | ✅ `Approved` |
| **01** | [01_Flower_Rules.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/08_Game_Rules_Bible/01_Flower_Rules.md) | Luật Thực Vật (`Rule 001 Stasis`), 4 giai đoạn sinh trưởng, công thức độ ẩm & di truyền lai tạo | ✅ `Approved` |
| **02** | [02_Weather_Rules.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/08_Game_Rules_Bible/02_Weather_Rules.md) | Quy tắc thời tiết 4 mùa, chu kỳ ngày đêm, hệ số độ ẩm & ánh sáng nhà kính | ✅ `Approved` |
| **03** | `03_NPC_Rules.md` *(Pending)* | Quy tắc hành xử townsfolk, lịch trình sinh hoạt, độ thiện cảm (`Heart Levels`) & quà tặng yêu/ghét | `Scheduled` |
| **04** | `04_Economy_Rules.md` *(Pending)* | Luật kinh tế, giá bán hoa, lạm phát 0% (`No Inflation Law`) & cửa hàng mầm non | `Scheduled` |
| **05** | `05_Festival_Rules.md` *(Pending)* | Quy tắc tổ chức lễ hội mùa, cơ chế tham gia không FOMO & phần thưởng kỷ niệm | `Scheduled` |
| **06** | `06_Journal_Rules.md` *(Pending)* | Quy tắc ghi chép Bloom Journal, hoa khô ép ký ức (`Pressed Memories`) & cốt truyện ông ngoại | `Scheduled` |

---

## 3. Triết Lý Thực Thi Song Song (`Parallel Implementation Workflow`)

Để đảm bảo Game Rules Bible luôn thực tế và không bị over-documentation, mỗi chương quy tắc được phát triển **song song cùng mã nguồn prototype (`Milestone Parallel Execution`)** theo chu trình chuẩn:

```text
Game Rules Chapter (e.g. 01_Flower_Rules) 
       ➔ Check Module Contract & ADR 
       ➔ Implement Objects & Systems (`Source/`) 
       ➔ Smoke Test Verification 
       ➔ Create Developer API Docs (`10_API_REFERENCE/`)
```
