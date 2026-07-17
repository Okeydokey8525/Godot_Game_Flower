# ADR-004: Adopt GDevelop 5 Engine vs Unity, Godot, or Unreal Engine

**Status:** `Superseded by [ADR-006](ADR-006_Migrate_Runtime_From_GDevelop_To_Godot.md)`
**Date:** `2026-07-16`
**Deciders:** Game Director, Technical Director, Senior Systems Architect
**Related Documents:** [00_Production_Overview.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/00_Production_Overview.md), [01_Project_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/01_Project_Architecture.md)

> **Historical notice (M4.3A.0):** This record preserves the original accepted
> GDevelop decision and its rationale. The target production runtime is now Godot
> under ADR-006; no historical reasoning below has been rewritten.

---

## 1. Context & Problem Statement

Khi lựa chọn nền tảng Game Engine để xây dựng **Plant Tales** (`Cozy Botanical RPG Single-player 2D`), các lập trình viên và AI Agent thường có xu hướng đặt câu hỏi trong quá trình phát triển dài hạn: *"Tại sao chúng ta lại dùng GDevelop 5 mà không phải Unity C#, Godot GDScript hay Unreal Engine C++? Liệu chúng ta có nên chuyển engine để có hiệu năng mạnh mẽ hơn hay không?"*.

Nếu không xác lập rõ ràng lý do, giới hạn chấp nhận và điều kiện chuyển đổi ngay từ đầu, dự án rất dễ bị rơi vào cạm bẫy *"Engine Hopping"* (chuyển đổi engine giữa chừng do cảm tính khi gặp một khó khăn kỹ thuật nhỏ), tiêu tốn hàng tháng trời viết lại mã nguồn và hủy hoại toàn bộ tiến trình nguyên mẫu.

---

## 2. Decision

Chúng tôi quyết định **chọn GDevelop 5 làm Game Engine chính thức cho toàn bộ giai đoạn Prototype (`M0 -> M6`) và phiên bản phát hành thương mại đầu tiên của Plant Tales**:
- **Lý do cốt lõi (`Why GDevelop?`):**
  - **Khả năng Lặp & Thử Nghiệm Siêu Tốc (`Hyper-Fast Iteration`):** Hệ thống Event-based Visual Scripting kết hợp với kiến trúc Data-Driven của chúng ta cho phép Game Designer và AI lập trình/kiểm thử các vòng lặp nông nghiệp (`Farming Loop`), hệ thống thời tiết và giao tiếp NPC cực nhanh mà không bị cản trở bởi thời gian compile code nặng nề như Unity/Unreal.
  - **Tối ưu hóa tuyệt hảo cho 2D Pixel Art & Tilemaps:** Engine tích hợp sẵn các công cụ render sprite, tilemap 2D nhẹ nhàng, hỗ trợ xuất xưởng gọn gàng trên nền tảng Windows Desktop và Web Assembly (`HTML5 Web Target`) mà không mang theo hàng trăm MB overhead dư thừa.
  - **Khả năng kiểm soát AI cộng tác (`AI-Friendly Event Sheets`):** Cấu trúc khối sự kiện GDevelop lưu trữ dưới dạng JSON/XML rõ rệt, giúp các AI Agent (`Codex`, `Claude`, `ChatGPT`, `Antigravity`) đọc hiểu, phân tích và tạo khối lệnh chính xác mà không gặp rủi ro lỗi con trỏ (`Pointer errors`) hay rò rỉ bộ nhớ thấp.

---

## 3. Acceptable Limitations (`Giới Hạn Chấp Nhận Được`)

Khi chọn GDevelop 5, chúng tôi chấp nhận một cách có ý thức các giới hạn kỹ thuật sau (đây KHÔNG phải là lý do để đổi engine):
- **Giới hạn về đa luồng (`Single-Threaded Loop`):** GDevelop chạy trên nền tảng PixiJS/JavaScript đơn luồng. => *Giải pháp:* Áp dụng nghiêm ngặt Hiến pháp Quản trị Hiệu năng `Performance Budget (CPU < 12ms, RAM < 400MB)` và kỹ thuật chia tải theo thời gian (`Time-Slicing Pathfinding` tại `05_Event_Architecture.md`).
- **Không phù hợp cho thế giới mở liền mạch 3D (`No 3D Open-World Simulation`):** Plant Tales được thiết kế theo cấu trúc phòng/scene 2D (`VillageScene`, `GreenhouseScene`, `HouseScene`). Việc chuyển cảnh có màn hình chờ (`Screen Transition Fade`) là hoàn toàn phù hợp với nhịp độ Cozy RPG.

---

## 4. Engine Migration Conditions & Cost (`Điều Kiện & Chi Phí Chuyển Đổi Engine`)

Để ngăn chặn chuyển đổi cảm tính, Hiến pháp Studio áp đặt điều kiện: **Chỉ được phép xem xét chuyển sang Godot 4 hoặc Unity khi và chỉ khi xảy ra TRỌNG BỆNH KỸ THUẬT không thể vượt qua, đồng thời thỏa mãn đồng thời 3 điều kiện:**
1. **Vi phạm cấu trúc:** Game phát triển lên quy mô Multiplayer Online Đồng Bộ (`Synchronous MMO 100+ players`) hoặc mở rộng thế giới mở liền mạch vượt quá `100,000 active objects` mỗi frame khiến engine PixiJS sụp đổ dưới `30 FPS` dù đã tối ưu hết mức (`Pool + Time-slicing`).
2. **Sự đồng thuận tối cao:** Được sự thống nhất tuyệt đối bằng văn bản của Game Director và Technical Director thông qua một cuộc họp kiểm toán kiến trúc khẩn cấp (`Emergency ADR Audit`).
3. **Chi phí chấp nhận (`Migration Cost Assessment`):**
   - *Thời gian viết lại:* Ước tính `3 - 4 tháng` kỹ sư toàn thời gian.
   - *Dữ liệu giữ lại được (`Saved Assets`):* Nhờ áp dụng **Data-Driven Architecture (`ADR-001`)** và **Module Contracts (`ADR-003`)**, 100% tệp dữ liệu tĩnh (`*.json`), tệp hình ảnh Sprite, âm thanh BGM/SFX và thiết kế Game Design Bible/Asset Bible được bảo toàn tuyệt đối 100%. Chỉ phải viết lại tầng logic Engine Event sang GDScript/C#.

---

## 5. Consequences (`Hệ Quả Kỹ Thuật`)

- **Positive:** Đội ngũ yên tâm tuyệt đối vào nền tảng GDevelop 5, tập trung tối đa tâm lực vào việc xây dựng trải nghiệm bình yên cho người chơi (`Cozy Gameplay`) và hoàn thành các cột mốc nguyên mẫu đúng hạn.
- **Negative / Risks:** Phải giám sát chặt chẽ số lượng object trên màn hình không vượt ngưỡng `2,000 objects/scene` để tránh nghẽn cổ chai PixiJS renderer.
