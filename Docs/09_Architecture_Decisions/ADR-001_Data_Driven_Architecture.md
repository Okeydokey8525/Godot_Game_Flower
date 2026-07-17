# ADR-001: Adopt Static Data-Driven Architecture vs Hardcoded Logic

**Status:** `Accepted`
**Date:** `2026-07-16`
**Deciders:** Technical Director, Senior Systems Architect, Lead Gameplay Engineer
**Related Documents:** [03_Data_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/03_Data_Architecture.md), [06_Save_Load_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/06_Save_Load_System.md)

---

## 1. Context & Problem Statement

Trong dự án **Plant Tales**, khu vườn thực vật và thị trấn mở rộng theo quy mô lớn: dự kiến sẽ có hơn **50+ loài hoa** (mỗi loài có từ 3 đến 5 giai đoạn sinh trưởng, giá bán, độ hiếm, yêu cầu độ ẩm), **20+ vật phẩm Satchel**, **15+ NPC** và hàng chục công thức lai tạo (`Genetics`).

Nếu lập trình viên hoặc AI Agent sử dụng phương pháp gán cứng mã logic thông thường trong GDevelop (*Hardcoded Condition Checks*):
```text
IF flower_name == "White Lily" THEN set growth_time = 120, set rarity = 1
IF flower_name == "Red Rose" THEN set growth_time = 180, set rarity = 2
IF flower_name == "Blue Lavender" THEN ... (Lặp lại 500 lần)
```
Hệ quả tất yếu sau 2 tháng phát triển: Event Sheet của GDevelop phình to thành các khối God Sheet dài hàng nghìn blocks, tốc độ nạp khung hình sụp đổ, việc cân bằng chỉ số kinh tế (`Balancing`) yêu cầu sửa code trực tiếp trong hàng chục Event Sheet khác nhau và không thể dịch thuật (`Localization`).

---

## 2. Decision

Chúng tôi quyết định **áp dụng toàn diện Kiến Trúc Hướng Dữ Liệu Tĩnh (`Static Data-Driven Architecture`)**:
- **Bóc tách triệt để Dữ Liệu (`Definitions`) ra khỏi Logic (`Events`):** Toàn bộ chỉ số cấu hình của hoa, vật phẩm, NPC và nhiệm vụ được lưu trữ tĩnh trong các tệp tin `JSON` riêng biệt (`flower_definition_*.json`, `item_catalog_*.json`, `npc_definition_*.json`) tại thư mục authoritative.
- **Quy tắc sở hữu (`Database vs Instance`):** Dữ liệu tĩnh JSON là nguồn chân lý duy nhất (`Single Source of Truth`). Khi game chạy runtime, `GameManager` chỉ tạo ra các `Instance DTO` tham chiếu bằng cấu trúc gọn gàng: `instance.flower_ref_id = "flower_white_lily"`.
- **Nghiêm cấm Hardcode:** Cấm tuyệt đối việc viết cấu trúc `IF id == "xxx" THEN value = y` bên trong Event Sheet để xác định thuộc tính sinh trưởng hay kinh tế.

---

## 3. Alternatives Considered

1. **Hardcoded GDevelop Event Sheets (`Phương án Event nhúng`):**
   - *Ưu điểm:* Dễ viết ngay phút đầu tiên, không cần nạp tệp JSON ngoại vi.
   - *Nhược điểm:* Phá hủy bộ nhớ RAM khi game lớn, cực kỳ khó bảo trì, Game Designer không thể tự điều chỉnh chỉ số mà không nhờ lập trình viên hoặc AI sửa code.
2. **Dynamic Script Variable Arrays (`Phương án Mảng cấu trúc bộ nhớ trong`):**
   - *Ưu điểm:* Nhanh gọn hơn đọc file đĩa.
   - *Nhược điểm:* Dữ liệu bị khóa chết trong bộ nhớ khi compile build, không hỗ trợ hot-reload chỉnh thông số tức thời và khó đồng bộ với các công cụ cân bằng bảng biểu của Designer.

---

## 4. Trade-offs (`Sự Đánh Đổi`)

- **👍 Điểm được (`Gains`):**
  - **Tối ưu hóa RAM tối đa:** Dữ liệu tĩnh chỉ nạp 1 lần lúc boot (`BootScene`) vào các bộ nhớ đệm `Catalogs` đọc tĩnh (`Read-only`).
  - **Cân bằng game siêu tốc (`Instant Balancing`):** Game Designer có thể chỉnh sửa giá bán hoa từ `15 Gold` lên `25 Gold` trong tệp `JSON` và xem kết quả ngay lập tức mà không cần động đến một dòng Event GDevelop.
  - **Save File siêu nhỏ gọn (`Lite Persistence`):** File `save.json` chỉ lưu IDs và trạng thái động (`stage = 2`), không bao giờ lưu lặp lại chuỗi văn bản mô tả hay thông số gốc.
- **👎 Điểm chấp nhận đánh đổi (`Losses / Costs`):**
  - Cần thêm thời gian `< 0.5s` lúc khởi động game (`BootScene`) để parse và nạp cấu trúc các tệp tĩnh vào bộ nhớ.
  - Đòi hỏi kỷ luật quản lý Schema khắt khe tại `03_Data_Architecture.md` (AI không được tùy tiện chèn key lạ vào JSON nếu chưa khai báo).

---

## 5. Consequences (`Hệ Quả Kỹ Thuật`)

- **Positive:** Mở đường cho hệ thống **Modding & Expansion DLC** tương lai một cách tự nhiên (chỉ cần thả thêm tệp `flower_definition_dlc_01.json` vào folder là game có ngay 20 loài hoa mới).
- **Negative / Risks:** Nếu tệp JSON bị cú pháp lỗi (`Syntax Parse Error`), game có thể không boot được. => **Giải pháp giảm thiểu rủi ro:** Khóa cổng kiểm nghiệm `Continuous Verification Dry-Run CLI` (chương 18 của `09_Testing_Debugging.md`) tự động kiểm tra cú pháp JSON trước mỗi lần build.
