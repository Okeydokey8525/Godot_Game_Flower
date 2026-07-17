# 📖 Plant Tales — Game Design Document (GDD) Bible

Chào mừng bạn đến với bộ tài liệu thiết kế gốc (**Game Design Bible**) của dự án **Plant Tales**.  
Bộ tài liệu này đã được chuẩn hóa sang định dạng **GitHub Markdown (`.md`)** sạch, cấu trúc rõ ràng và chuẩn xác 100% nội dung từ các file Word ban đầu để phục vụ cho việc quản lý phiên bản trên Git/GitHub, phát triển lâu dài và làm đầu vào chính xác tuyệt đối cho **Codex / AI Engineering Tools**.

---

## 🏗️ Cấu Trúc Tài Liệu Game Design

Toàn bộ hệ thống được chia thành **16 tài liệu chính** (bao gồm 1 bài tổng quan và 15 hệ thống chi tiết):

| Mã số | Tài liệu | Mô tả ngắn gọn | Liên kết nhanh |
| --- | --- | --- | --- |
| **00** | **Game Overview** | Tổng quan kiến trúc GDD, các trụ cột thiết kế (Core Pillars) và vòng lặp gameplay cốt lõi. | [00_Game_Overview.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/00_Game_Overview.md) |
| **01** | **Flower Definition** | Blueprint định nghĩa toàn bộ dữ liệu, thông số và cấu trúc của một loài hoa trong game. | [01_Flower_Definition.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/01_Flower_Definition.md) |
| **02** | **Prototype Scope** | Phạm vi và danh sách câu hỏi kiểm chứng cho phiên bản thử nghiệm Prototype đầu tiên. | [02_Prototype_Scope.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/02_Prototype_Scope.md) |
| **03** | **Rarity System** | Phân cấp 6 độ hiếm (Common → Mythic), điều kiện mở khóa và triết lý tiến trình người chơi. | [03_Rarity_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/03_Rarity_System.md) |
| **04** | **Quality System** | Hệ thống chất lượng hoa (★1–★5) và các yếu tố chăm sóc quyết định độ hoàn hảo. | [04_Quality_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/04_Quality_System.md) |
| **05** | **Growth System** | Các giai đoạn sinh trưởng từ hạt giống đến khi héo (Seed → Perfect Bloom → Wilt). | [05_Growth_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/05_Growth_System.md) |
| **06** | **Breeding System** | Cơ chế lai tạo giống, đột biến di truyền và khám phá loài hoa mới (Linh hồn của game). | [06_Breeding_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/06_Breeding_System.md) |
| **07** | **Economy System** | Dòng chảy tiền tệ, cơ chế thu nhập, chi phí nâng cấp và điểm cân bằng kinh tế game. | [07_Economy_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/07_Economy_System.md) |
| **08** | **Seed System** | Cơ chế hoạt động và dữ liệu của hạt giống trong Inventory và khi gieo trồng. | [08_Seed_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/08_Seed_System.md) |
| **09** | **Inventory System** | Trung tâm luân chuyển tài nguyên (Shop, Vườn, NPC, Tools) và quản lý túi đồ. | [09_Inventory_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/09_Inventory_System.md) |
| **10** | **Prototype Flower Database** | Cơ sở dữ liệu nội dung thực tế của các giống hoa mẫu phục vụ test hệ thống. | [10_Prototype_Flower_Database.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/10_Prototype_Flower_Database.md) |
| **11** | **Bloom Journal** | Nhật ký học giả, bộ sưu tập hoa, phác thảo thực vật và các ký ức ép hoa (*Pressed Memories*). | [11_Bloom_Journal.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/11_Bloom_Journal.md) |
| **12** | **NPC System** | Hệ thống nhân vật, lịch trình sinh hoạt, sở thích hoa và mối quan hệ với người chơi. | [12_NPC_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/12_NPC_System.md) |
| **13** | **Village System** | Thiết kế thị trấn, các khu vực chức năng và tiến trình phát triển thế giới sống động. | [13_Village_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/13_Village_System.md) |
| **14** | **Story System** | Cốt truyện chính, tiến trình mở khóa chương hồi và sự tương hỗ giữa Gameplay & Story. | [14_Story_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/14_Story_System.md) |
| **15** | **Festival System** | Điểm hội tụ của toàn bộ hệ thống: Lễ hội Hoa truyền thống và các cuộc thi thực vật. | [15_Festival_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/15_Festival_System.md) |

---

## 📌 Quy Tắc Chuẩn Hóa & Định Dạng (Dành cho Codex / Developers)

Toàn bộ các tài liệu trong thư mục `GameDesign/` tuân thủ nghiêm ngặt 15 quy tắc chuẩn hóa:
1. **Bảo toàn thông tin:** 100% nội dung gốc được giữ nguyên (không tự ý tóm tắt, thêm bớt hay diễn đạt lại).
2. **Heading chuẩn GitHub:** Chỉ sử dụng `#` (Heading 1), `##` (Heading 2), và `###` (Heading 3).
3. **Bảng biểu chuẩn (Markdown Table):** Mọi bảng biểu từ Word đều được chuyển đổi thành bảng Markdown với cú pháp `| Col | Col |`.
4. **Danh sách gạch đầu dòng:** Định dạng đồng bộ với cú pháp `- Item`.
5. **Sơ đồ luồng & ASCII Diagram:** Được đặt trong khối code block ` ```text ... ``` ` và bảo toàn tuyệt đối mọi khoảng trắng cũng như ký tự sơ đồ (`│`, `├──`, `└──`, `↓`, `▼`).
6. **Không sử dụng HTML hay Markdown mở rộng:** Đảm bảo khả năng hiển thị hoàn hảo và tương thích tuyệt đối trên cả **VS Code**, **GitHub Preview** và hệ thống đọc code của **Codex**.
