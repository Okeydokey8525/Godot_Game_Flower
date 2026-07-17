# ADR-003: Adopt Strict Module Contracts & Global Signal Bus vs Direct Cross-Writes

**Status:** `Accepted`
**Date:** `2026-07-16`
**Deciders:** Technical Director, Lead Software Architect, Senior Systems Engineer
**Related Documents:** [05_Event_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/05_Event_Architecture.md), [10_Module_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/10_Module_Architecture.md)

---

## 1. Context & Problem Statement

Trong GDevelop 5, mọi Event Sheet có thể dễ dàng liên kết hoặc gọi trực tiếp các biến toàn cục và biến đối tượng (`Object Variables`) của bất kỳ scene hay module nào. Ví dụ: từ trong Event Sheet của `NPCModule`, AI Agent có thể viết lệnh cộng thẳng `+10` vào `SatchelSlot[0].quantity` khi NPC tặng quà, hoặc từ trong `WeatherModule`, AI có thể vòng lặp qua từng `FlowerInstance` để đổi trực tiếp biến `moisture_level = 100`.

Tuy nhiên, thói quen lập trình gọi chéo trực tiếp (*Direct Cross-Writes / Tightly Coupled Spaghettification*) tạo ra hệ quả tàn khốc:
- Khi cần thay đổi cấu trúc kho Satchel từ mảng đơn sang rương nâng cấp (`Chest`), toàn bộ code trong NPC, Quest, Shop và Harvest đều bị gãy đổ đồng loạt vì chúng trỏ trực tiếp vào biến cấu trúc cũ.
- Khi xảy ra lỗi âm tiền hoặc nhân bản vật phẩm, không thể truy vết được module nào trong số 8 module đã thực thi lệnh ghi lỗi (`Missing Audit Trail`).

---

## 2. Decision

Chúng tôi quyết định **ban hành Hợp Đồng Ranh Giới Module Cưỡng Chế (`Strict Module Contracts`) kết hợp với Global Signal Bus**:
- **Độc quyền sở hữu dữ liệu (`Authoritative Ownership Matrix`):** Mỗi Core Module (`Flower`, `Inventory`, `NPC`, `Quest`, `Journal`, `Weather`, `Audio`, `Festival`) sở hữu độc quyền (`Owns & Writes`) cấu trúc dữ liệu và runtime instance của mình. Cấm tuyệt đối module khác ghi sửa trực tiếp!
- **Giao tiếp qua Signal Bus (`Publish / Consume Law`):** Khi Module A muốn báo tin cho Module B, nó **buộc phải phát ra tín hiệu qua Global Signal Bus** (`EventBus.Emit`). Ví dụ: `FlowerModule` chỉ phát Signal `FlowerHarvested (id, qty)`, còn `InventoryModule` lắng nghe Signal đó để tự cộng vào Satchel của mình.
- **Phân tầng phụ thuộc (`Master Dependency Matrix`):** Áp đặt luật phân tầng một chiều (`Downstream -> Upstream`). Module tầng trên được phép gọi API đọc (`Read-only`) từ module tầng dưới, cấm tuyệt đối phụ thuộc ngược hoặc phụ thuộc vòng tròn (`Circular Dependency`).

---

## 3. Alternatives Considered

1. **Direct Event Sheet Linking (`Liên kết Event trực tiếp kiểu truyền thống`):**
   - *Ưu điểm:* Viết code nhanh, ít phải khai báo tên sự kiện trung gian.
   - *Nhược điểm:* Độ cô lập bằng 0, sửa 1 file kéo theo lỗi ở 10 file khác, cực kỳ khó bảo trì khi dự án vượt 10,000 blocks.
2. **Monolithic Game Controller (`Dồn toàn bộ logic xử lý chéo vào một GameManager khổng lồ`):**
   - *Ưu điểm:* Quản lý tập trung tại 1 điểm.
   - *Nhược điểm:* Biến `GameManager` thành một God Sheet khổng lồ 5,000 dòng, vi phạm nguyên tắc Single Responsibility và gây nghẽn tài nguyên CPU mỗi frame.

---

## 4. Trade-offs (`Sự Đánh Đổi`)

- **👍 Điểm được (`Gains`):**
  - **Khả năng cô lập lỗi tuyệt đối (`Zero Spaghetti & High Modularity`):** Khi sửa chữa hoặc viết mới thuật toán trong `BeeKeeping` hay `Inventory`, lập trình viên hoàn toàn yên tâm 100% không làm hỏng logic của `NPC` hay `Flower`.
  - **Truy vết lỗi minh bạch (`Audit Log via EventBus`):** Khi bật chế độ Debug F3, toàn bộ lịch sử phát tín hiệu (`Signal Trace`) hiển thị rành mạch từng mili giây, giúp phát hiện ngay lập tức tín hiệu nào phát sai thông số.
  - **Khả năng kiểm thử độc lập (`Unit Testability`):** Có thể chạy kiểm thử `FlowerModule` riêng rẽ bằng cách giả lập phát Signal từ Console F4 mà không cần nạp toàn bộ các module khác.
- **👎 Điểm chấp nhận đánh đổi (`Losses / Costs`):**
  - Đòi hỏi kỷ luật thiết kế ban đầu: lập trình viên và AI phải tốn thời gian tra cứu `10_Module_Architecture.md` và khai báo Signal mới tại `05_Event_Architecture.md` trước khi viết code.

---

## 5. Consequences (`Hệ Quả Kỹ Thuật`)

- **Positive:** Giúp dự án đạt chuẩn độ sạch mã nguồn của AAA Studio, biến việc mở rộng tính năng trong tương lai thành quy trình lắp ghép Lego đơn giản theo chuẩn 6 bước tại `Chương 13: Extension Guide`.
- **Negative / Risks:** Nếu khai báo quá nhiều Signal nhỏ lẻ không kiểm soát, có thể gây tràn bộ đệm Event Bus. => **Giải pháp giảm thiểu rủi ro:** Áp dụng `Performance Budget` (Chương 11 của hợp đồng từng module) quy định rõ mỗi module chỉ phát ra tối đa các tín hiệu mức domain lớn (`Domain Events`), cấm phát tín hiệu vụn vặt mỗi frame (`No Per-Frame Signals`).
