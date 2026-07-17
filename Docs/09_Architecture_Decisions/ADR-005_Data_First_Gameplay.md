# ADR-005: Adopt Data-First Gameplay Execution vs Hardcoded Logic

**Status:** `Accepted`
**Date:** `2026-07-16`
**Deciders:** Game Director, Technical Director, Lead Gameplay Architect
**Related Documents:** [ADR-001_Data_Driven_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-001_Data_Driven_Architecture.md), [03_Data_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/03_Data_Architecture.md), [10_Module_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/10_Module_Architecture.md)

---

## 1. Context & Problem Statement

Khi bước vào giai đoạn thực thi mã nguồn (`Implementation`), với một tựa game RPG quản lý sinh thái có quy mô dài hạn như Plant Tales (`500+ loài hoa`, `300+ NPC`, `200+ nhiệm vụ`, `100+ sự kiện lễ hội`), một câu hỏi cốt lõi về triết lý viết code xuất hiện: *"Tại sao chúng ta không được phép viết logic xử lý riêng lẻ cho từng vật phẩm hay từng loài hoa (ví dụ: tạo khối Event riêng cho `White Lily` và khối Event riêng cho `Red Rose`)?"*.

Nếu lập trình viên hoặc AI cho phép logic gameplay phụ thuộc vào mã định danh cứng (*Hardcoded Identity-Based Logic*):
- Khi cần thêm loài hoa thứ 501 (`Golden Lotus`), lập trình viên buộc phải tạo thêm khối Event xử lý riêng, sửa đổi kiểm tra điều kiện trong nhiệm vụ và cập nhật mã hiển thị nhật ký.
- Mã nguồn sẽ biến thành một mê cung Event khổng lồ, không thể kiểm soát được lỗi sinh ra khi có hàng nghìn nhánh `IF/ELSE` lồng nhau.

---

## 2. Decision

Chúng tôi quyết định **ban hành Triết Lý Thực Thi Gameplay Ưu Tiên Dữ Liệu (`Data-First Gameplay Execution Law`)**:
- **Luật vô danh trong logic (`Identity-Agnostic Engine Loop`):** Toàn bộ các khối Event GDevelop trong các Core Module (`FlowerModule`, `InventoryModule`, `NPCModule`...) **phải được viết theo cơ chế tổng quát hoàn toàn vô danh**. Engine không quan tâm hoa đó tên là Lily hay Rose; nó chỉ thực thi công thức chung dựa trên các tham số số học trích xuất từ dữ liệu tĩnh JSON:
  $$\text{GrowthDelta} = \text{DeltaMinutes} \times \text{MoistureModifier}(\text{FlowerInstance.moisture\_level}) \times \text{Definition.growth\_rate}$$
- **Mọi tính năng mới bắt đầu từ Schema (`Schema-First Expansion`):** Khi muốn thêm một tính năng hoặc một loài hoa mới có cơ chế đặc biệt (ví dụ: `Carnivorous Flower` — hoa bắt sâu), cấm viết code logic cứng cho ID hoa đó. Thay vào đó, mở rộng thuộc tính Schema tĩnh JSON (`"trait": "carnivorous", "pest_consumption_rate": 2`) và để vòng lặp chung tự động đọc và xử lý thuộc tính đó cho bất kỳ loài hoa nào có mang cờ `trait: carnivorous`.
- **Nghiêm cấm Magic Strings & Hardcoded IDs trong Logic:** Cấm tuyệt đối việc sử dụng `FlowerInstance.flower_ref_id == "..."` bên trong các khối Event logic sinh trưởng chung.

---

## 3. Alternatives Considered

1. **Scripted Object Behaviors / Individual Event Blocks (`Mỗi loài hoa / NPC có một khối Event riêng`):**
   - *Ưu điểm:* Dễ tùy biến những hành vi cực kỳ lập dị cho từng cá thể rành mạch.
   - *Nhược điểm:* Phá hủy hoàn toàn khả năng mở rộng nhanh. Khi có 500 loài hoa, số lượng Event block sẽ vượt quá 50,000 blocks, làm engine GDevelop đơ cứng khi compile và tải scene.
2. **Polymorphic Subclasses in Code (`Tạo hàng trăm lớp con class riêng lẻ`):**
   - *Ưu điểm:* Quen thuộc với lập trình hướng đối tượng (`OOP`) truyền thống.
   - *Nhược điểm:* Không tương thích tối ưu với Visual Scripting của GDevelop và làm chậm quá trình thiết kế của Game Designer.

---

## 4. Trade-offs (`Sự Đánh Đổi`)

- **👍 Điểm được (`Gains`):**
  - **Khả năng mở rộng vô hạn với chi phí mã nguồn bằng 0 (`Zero-Code Scaling`):** Khi Game Designer hoặc AI chèn thêm `300 loài hoa mới` hoặc `50 NPC mới` vào file `JSON`, engine lập tức chạy mượt mà không cần viết thêm hay sửa dù chỉ 1 dòng Event block.
  - **Khả năng kiểm thử tự động toàn phần (`Comprehensive Automated Validation`):** Do toàn bộ luật chơi nằm trong cấu trúc Schema, chúng ta có thể dùng script kiểm định (`CLI Verifier`) quét 100% các tệp JSON trong 2 giây để đảm bảo không có loài hoa nào bị gán giá trị âm hay thời gian sinh trưởng bằng 0 trước khi build game.
- **👎 Điểm chấp nhận đánh đổi (`Losses / Costs`):**
  - Buộc kỹ sư kiến trúc phải thiết kế cấu trúc JSON Schema (`FlowerDefinition`, `NPCDefinition`) ban đầu cực kỳ chu đáo, bao quát được các khả năng biến đổi tính chất (`Traits/Perks`).

---

## 5. Consequences (`Hệ Quả Kỹ Thuật`)

- **Positive:** Đảm bảo kiến trúc phần mềm của Plant Tales mãi mãi nhẹ nhàng, sạch sẽ, đạt tốc độ `60 FPS` ổn định ngay cả khi dung lượng nội dung game phình to gấp 10 lần so với nguyên mẫu ban đầu.
- **Negative / Risks:** Game Designer có thể gặp bối rối ban đầu khi muốn tạo một cơ chế hoàn toàn chưa từng có trong Schema. => *Giải pháp:* Tham chiếu `Chương 13: Extension Guide` trong `10_Module_Architecture.md` và trình văn bản `Feature Request Template` để mở rộng Schema một cách bài bản trước khi triển khai.
