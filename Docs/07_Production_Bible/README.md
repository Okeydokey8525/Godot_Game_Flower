# Production Bible Index

**Bộ tài liệu quy chuẩn kỹ thuật lập trình, kiến trúc dữ liệu và quy định hợp tác AI cho dự án Plant Tales (Production Bible Repository Index).**

---

## 1. Mục Tiêu & Vai Trò Của Production Bible

Nếu **Game Design Bible** giải quyết câu hỏi *"Trò chơi hoạt động như thế nào?"* và **Asset Bible** giải quyết câu hỏi *"Trò chơi trông và nghe như thế nào?"*, thì **Production Bible (`Docs/07_Production_Bible/`)** trả lời câu hỏi cốt lõi trước khi viết dòng code đầu tiên:

> **"Trò chơi được xây dựng về mặt kỹ thuật và kiến trúc như thế nào?"**

Đây là tài liệu đặc thù dành riêng cho **Lập trình viên (Codex), GDevelop Engine, và các AI Agent** làm việc trực tiếp với mã nguồn. Mục tiêu tối thượng của bộ tài liệu này là **khóa chặt kiến trúc kỹ thuật (*Architectural Lockdown*)**, ngăn chặn tuyệt đối tình trạng rác mã nguồn (*Code rot*), lệch lạc cấu trúc dữ liệu và sự ngẫu hứng nguy hiểm khi sử dụng đa AI Agent trong thời gian dài.

---

## 2. Sự Khác Biệt Giữa 3 Bộ Bible Cốt Lõi

| Tiêu chí | Game Design Bible (`01–02`) | Asset Bible (`06`) | Production Bible (`07`) |
| --- | --- | --- | --- |
| **Đối tượng đọc chính** | Game Designer, Game Director, Storywriter | Artist, Animator, Sound Designer | Lập trình viên, Codex, GDevelop Engine, AI Coding Agent |
| **Góc nhìn về Hoa** | Ý nghĩa Language of Flowers, chỉ số lai tạo, giá trị kinh tế | Sprite `32x32`, Palette sepia, Animation lắc gió `6-8` FPS | Cấu trúc class `FlowerDefinition`, Schema `json`, vị trí lưu trữ `Assets/Flowers/Rose/` |
| **Góc nhìn về Journal** | Sổ tay Bloom Journal ghi chép, nhiệm vụ & tiêu bản | UI giấy da parchment nhám nẹp gỗ sồi, lật trang sột soạt | Cấu trúc dữ liệu `class PressedMemory`, event lật trang, Z-order layer quản lý UI |
| **Góc nhìn về NPC** | Tính cách, sở thích quà tặng, chu kỳ sinh hoạt thị trấn | Sprite 4 hướng `32x48`, Portrait `512x512` biểu cảm | Module logic `NPCManager`, State machine `Schedule -> Dialogue -> Relationship` |

---

## 3. Danh Mục Tài Liệu Production Bible (10 Modules)

Dưới đây là danh sách toàn bộ 10 tài liệu cấu thành hiến pháp lập trình của **Plant Tales**, được triển khai theo lộ trình kỹ thuật:

| Mã số | Tên tài liệu | Mô tả trọng tâm | Trạng thái |
| --- | --- | --- | --- |
| **00** | [00_Production_Overview.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/00_Production_Overview.md) | Tổng quan kiến trúc kỹ thuật & Nguyên tắc AI Collaboration Standard cơ bản | `Approved` |
| **01** | [01_Project_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/01_Project_Architecture.md) | Cấu trúc tổng thể Engine GDevelop 5, tổ chức 13 mục chuẩn kỹ thuật Technical Director | `Approved` |
| **02** | [02_Folder_Convention.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/02_Folder_Convention.md) | Cây thư mục chuẩn xác cho code và import asset, 15 mục chuẩn Studio Pipeline | `Approved` |
| **03** | [03_Data_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/03_Data_Architecture.md) | **Data Constitution:** Khóa chặt Schema `FlowerDefinition`, `NPCData`, `PressedMemory`... | `Approved` |
| **04** | [04_Coding_Convention.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/04_Coding_Convention.md) | **AI Coding Constitution:** Quy ước đặt tên biến, hàm, event, scene, 16 luật lập trình | `Approved` |
| **05** | [05_Event_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/05_Event_Architecture.md) | **Event Architecture Constitution:** Kiến trúc Event Sheet, Signal Bus, 18 luật sự kiện | `Approved` |
| **06** | [06_Save_Load_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/06_Save_Load_System.md) | **Persistence Constitution:** Kiến trúc lưu trữ, Dirty Cache, Versioning & Migration | `Approved` |
| **07** | [07_AI_Collaboration.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/07_AI_Collaboration.md) | **AI Operating System:** Priority Stack, Decision Tree, Confidence Rules, Handoff Protocol | `Approved` |
| **08** | [08_Prototype_Roadmap.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/08_Prototype_Roadmap.md) | **Milestone Roadmap:** M0-M6 Deliverables, Exit Criteria & Traceability Matrix | `Approved` |
| **09** | [09_Testing_Debugging.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/09_Testing_Debugging.md) | **QA Constitution:** Shift-Left, Bug Severity Matrix, F3/F4 Tools, DoD & 18 Chapters | `Approved` |
| **10** | [10_Module_Architecture.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/07_Production_Bible/10_Module_Architecture.md) | **Module Contracts:** Đặc tả `Owns \| Publishes \| Consumes` cho 8 Core Modules & 4 Ma trận | `Approved` |

---

## 4. Nguyên Tắc Cốt Lõi Của Production Bible

1. **Khóa Độc Tôn Định Danh (*Strict Naming & Schema Lockdown*):** Mọi cấu trúc dữ liệu chỉ có **đúng 1 tên định danh hợp lệ**. Khi đã chốt `FlowerDefinition`, tuyệt đối không cho phép bất kỳ AI nào tự ý chế tạo thêm `FlowerData`, `FlowerInfo`, `FlowerAsset` hay `PlantSystem`.
2. **Quy Định Hợp Tác AI (*AI Collaboration Standard*):** AI viết code phải tuân thủ tuyệt đối các Data Schema và Folder Convention đã khóa. Nghiêm cấm tự tạo trường dữ liệu (*Arbitrary Field Creation*) nằm ngoài quy chuẩn.
3. **Cầu Nối Hoàn Hảo Đến Prototype:** Toàn bộ cấu trúc thư mục code và biến số trong tài liệu này phản ánh 1-to-1 cấu trúc project GDevelop thực tế khi triển khai prototype.
