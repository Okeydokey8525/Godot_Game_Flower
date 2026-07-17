# ADR-002: Adopt Milestone-Driven Execution over Calendar-Days

**Status:** `Accepted`
**Date:** `2026-07-16`
**Deciders:** Game Director, Technical Director, Agile Engineering Architect
**Related Documents:** [08_Prototype_Roadmap.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/08_Prototype_Roadmap.md), [09_Testing_Debugging.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/09_Testing_Debugging.md)

---

## 1. Context & Problem Statement

Khi lên kế hoạch xây dựng nguyên mẫu (`Prototype Scaffolding`) cho Plant Tales, phương pháp phân bổ theo lịch trình ngày calendar truyền thống (*Day-based Schedule: Day 1 làm Boot, Day 7 làm NPC, Day 14 làm Thời tiết*) thường xuyên được đề xuất vì tính trực quan thời gian.

Tuy nhiên, khi áp dụng trong thực tế phát triển có sự tham gia song song của lập trình viên và nhiều AI Agent khác nhau (`Codex`, `Claude`, `ChatGPT`), phương pháp Day-based bộc lộ nhược điểm chí mạng: tốc độ gõ code và xử lý logic của mỗi agent/lập trình viên không đồng nhất. Nếu ngày thứ 7 nhiệm vụ `NPC Module` gặp trục trặc chưa hoàn tất, ngày thứ 8 AI nhận ca làm tiếp `Weather Module` sẽ bị lệch toàn bộ tọa độ tài liệu, dẫn đến viết code gối đầu lên những hệ thống nền móng chưa hề chạy ổn định.

---

## 2. Decision

Chúng tôi quyết định **bác bỏ hoàn toàn mô hình Calendar-Days và thay thế bằng Mô hình Xây dựng Hướng Cột Mốc Kiến Trúc (`Milestone-Driven Execution Roadmap`)**:
- **Cấu trúc 7 Cột Mốc Tuyến Tính (`M0 -> M6`):** Tiến trình dự án chỉ được đo lường bằng việc mở khóa lần lượt các cột mốc: `M0 (Bootstrap)`, `M1 (Vertical Slice Garden)`, `M2 (Core Loop)`, `M3 (World Sim)`, `M4 (Content Expansion)`, `M5 (Polish & Opt)`, `M6 (Release Candidate)`.
- **Cổng Kiểm Định Tuyệt Đối (`Exit Criteria / Definition of Done Gate`):** Một cột mốc không bao giờ được coi là "Xong" dựa trên số ngày trôi qua. Một cột mốc chỉ chính thức đóng lại (`Signed-Off`) khi vượt qua 100% danh sách kiểm tra tiêu chí hoàn thành (`Exit Criteria Checkbox`) và qua bài test ổn định không crash.
- **Nghiêm Cấm Nhảy Cóc (`No Milestone Skipping Law`):** Cấm tuyệt đối việc viết code cho hệ thống thuộc M3 (Thời tiết) khi M1 (Lưới trồng hoa và Save core) chưa vượt qua `Exit Gate`.

---

## 3. Alternatives Considered

1. **Calendar Day-by-Day Schedule (`Lịch trình ngày tuyến tính Day 1 -> Day 30`):**
   - *Ưu điểm:* Dễ dự báo thời gian hoàn thành tổng thể trên giấy tờ quản lý dự án.
   - *Nhược điểm:* Cực kỳ dễ gãy đổ khi có trễ hạn kỹ thuật nhỏ (`Cascading Delays`), AI bị hoang mang khi ngày thực tế và ngày trong tài liệu không khớp nhau.
2. **Feature-Driven Kanban (`Làm tính năng song song tự do`):**
   - *Ưu điểm:* Các kỹ sư làm việc linh hoạt, không ai phải chờ ai.
   - *Nhược điểm:* Trong game RPG, các hệ thống phụ thuộc mật thiết vào nhau (hoa cần thời tiết, thời tiết cần kim đồng hồ). Làm song song tự do gây ra tình trạng ghép nối thất bại (`Integration Hell`) vào phút chót.

---

## 4. Trade-offs (`Sự Đánh Đổi`)

- **👍 Điểm được (`Gains`):**
  - **Sự kiên định chất lượng tuyệt đối:** Mỗi cột mốc khi hoàn thành đều là một bản Build có thể chơi độc lập (`Playable Vertical Slice`) và ổn định, không bao giờ rơi vào trạng thái "code dở dang toàn project".
  - **Định hướng rõ ràng cho AI (`AI GPS`):** Khi một AI mới (Codex hoặc ChatGPT) mở project nhận bàn giao, chỉ cần đọc `Exit Criteria` của cột mốc hiện tại là biết chính xác 100% mục tiêu duy nhất cần chinh phục.
- **👎 Điểm chấp nhận đánh đổi (`Losses / Costs`):**
  - Đòi hỏi sự kiên nhẫn cao độ từ Game Director: không thể đòi hỏi "xem ngay tính năng mưa rào" nếu cột mốc M1 chưa hoàn tất 100% bài kiểm tra va chạm lưới đất.

---

## 5. Consequences (`Hệ Quả Kỹ Thuật`)

- **Positive:** Giảm thiểu tối đa rủi ro technical debt sinh ra từ việc viết code vội vàng cho kịp deadline ngày. Nếu M1 cần thêm 3 lần refactor để ổn định 60 FPS, tiến trình M1 tiếp tục mở rộng cho đến khi đạt chuẩn hoàn hảo.
- **Negative / Risks:** Có nguy cơ bị nghẽn cổ chai (`Bottleneck`) tại một cột mốc phức tạp nếu gặp lỗi logic khó. => **Giải pháp giảm thiểu rủi ro:** Ban hành `Known Issues Register` trong Hiến pháp QA (`09_Testing_Debugging.md`), cho phép ghi nợ các lỗi nhỏ S2/S3 sang M5 Polish để không khóa cứng tiến trình của các module cốt lõi.
