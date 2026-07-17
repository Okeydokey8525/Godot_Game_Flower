# Production Overview & AI Collaboration Standard

**Tài liệu tổng quan kiến trúc kỹ thuật và tiêu chuẩn hợp tác AI toàn cục cho dự án Plant Tales (Production Overview & AI Collaboration Standard Document).**

---

## 1. Purpose & Scope

Tài liệu **Production Overview (`00_Production_Overview.md`)** là văn bản nền tảng khởi đầu cho bộ **Production Bible (`Docs/07_Production_Bible/`)** của dự án **Plant Tales**. 

Trong một dự án phát triển game hiện đại có sự phối hợp liên tục giữa **Game Director (Con người)**, **Project Manager / File Generator (Antigravity AI)** và **Core Lập trình viên / Code Generator (Codex AI)**, việc thiết lập một bộ quy tắc kỹ thuật nghiêm ngặt trước khi tạo ra tệp tin project thực tế là yêu cầu sống còn. Mục đích cốt lõi của tài liệu này:
- **Xây dựng cầu nối từ Thiết kế sang Mã nguồn (*Design-to-Code Bridge*):** Chuyển đổi toàn bộ các triết lý nghệ thuật và gameplay từ **Game Design Bible (`01–02`)** và **Asset Bible (`06`)** thành cấu trúc biến số, lớp đối tượng (*Class/Schema*) và kiến trúc sự kiện (*Event Sheet*) chuẩn xác.
- **Khóa chặt cấu trúc kỹ thuật (*Technical Lockdown*):** Loại bỏ hoàn toàn sự tự do ngẫu hứng của lập trình viên và các AI Agent khi đặt tên biến, tên class, hay tự ý bổ sung các trường dữ liệu ngoài quy chuẩn.
- **Tiêu chuẩn hóa quy trình làm việc đa AI (*AI Collaboration Standard*):** Định hướng hành vi lập trình cho Codex và các AI hỗ trợ, đảm bảo sau hàng tháng trời đồng phát triển, cấu trúc mã nguồn vẫn giữ được sự tinh gọn, thống nhất như được viết bởi một kỹ sư trưởng duy nhất.

---

## 2. Core Technical Philosophy

Hệ thống mã nguồn và cấu trúc GDevelop của **Plant Tales** được xây dựng dựa trên 4 triết lý kỹ thuật nền tảng:

- **Single Source of Truth (Nguồn chân lý duy nhất):**
  - Mọi thực thể dữ liệu trong game (Hoa, Cư dân, Tòa nhà, Ký ức ép) chỉ có **đúng 1 class/schema duy nhất** và **đúng 1 file định danh JSON/Data structure**. Tuyệt đối không cho phép tồn tại cấu trúc dữ liệu trùng lặp dưới nhiều tên gọi khác nhau.
- **Strict Separation of Concerns (Phân tách trách nhiệm rõ ràng):**
  - **Data (Dữ liệu tĩnh):** Chỉ chứa các chỉ số thông số ban đầu của hoa, tiểu sử NPC (*Definitions/Schemas*).
  - **Logic/Events (Xử lý sự kiện):** Các Event sheet hoặc Behavior xử lý chuyển động, va chạm, tính toán lai tạo hoa.
  - **Presentation (Hiển thị):** Các lớp Layer, Sprite và VFX chịu trách nhiệm xuất ra màn hình dựa trên tín hiệu từ Logic.
- **No Hallucination Architecture (Kiến trúc chống ảo giác AI):**
  - Khi yêu cầu AI viết một tính năng mới, AI buộc phải tham chiếu **Production Bible (`07`)** để kế thừa class có sẵn thay vì tự sáng tạo ra một class hoàn toàn mới.
- **Long-term Scalability (Khả năng mở rộng bền vững):**
  - Cấu trúc project phải hỗ trợ mở rộng thêm hàng trăm loài hoa Mythic, hàng chục sự kiện Lễ hội mới hay hệ thống Ký ức Thị trấn mà không làm xáo trộn các module đã có sẵn.

---

## 3. AI Collaboration Standard (Tiêu chuẩn Hợp tác AI Toàn cục)

Đây là quy chuẩn đặc thù tối quan trọng của **Plant Tales** — **AI Collaboration Standard**. Mọi AI Agent (Antigravity, Codex, GDevelop Copilot) tham gia viết code, tạo Event Sheet hoặc sinh dữ liệu mẫu bắt buộc phải tuân thủ các điều luật bất di bất dịch sau:

### 3.1. Luật Khóa Độc Tôn Tên Định Danh (`Strict Name Locking`)
Mọi thực thể cốt lõi đã được định nghĩa trong **Production Bible** phải được gọi đúng tên tuyệt đối. Nghiêm cấm sử dụng từ đồng nghĩa hoặc tự chế tên hệ thống mới:

| Thực thể cốt lõi | Tên định danh chuẩn duy nhất (`REQUIRED`) | Các tên bị cấm tuyệt đối (`PROHIBITED / FORBIDDEN`) |
| --- | --- | --- |
| **Định nghĩa loài hoa** | `FlowerDefinition` | `FlowerData`, `FlowerInfo`, `FlowerBlueprint`, `FlowerAsset`, `PlantSystem`, `PlantDatabase` |
| **Dữ liệu cư dân NPC** | `NPCData` | `CharacterInfo`, `NpcBlueprint`, `VillagerData`, `NPCSystem` |
| **Ký ức hoa ép** | `PressedMemory` | `MemoryData`, `PressedFlowerInfo`, `MemoryBlueprint`, `JournalMemory` |
| **Quản lý lịch trình** | `ScheduleManager` | `TimeController`, `RoutineSystem`, `DailyLifeManager`, `ClockSystem` |

### 3.2. Luật Không Tự Tạo Trường Dữ Liệu (`No Arbitrary Field Creation`)
Khi làm việc với các định nghĩa dữ liệu (ví dụ cấu trúc loài hoa hoặc NPC), AI **nghiêm cấm tự ý bổ sung trường dữ liệu mới (*Arbitrary Fields*)** nằm ngoài bản thiết kế Schema đã duyệt.

- **Ví dụ minh họa quy chuẩn (*Example Constraint*):**  
  Với `FlowerDefinition`, schema chuẩn chỉ bao gồm:
  ```json
  {
    "flower_id": "flower_rose_common",
    "flower_name": "Common Rose",
    "scientific_name": "Rosa rubiginosa",
    "category": "Rose",
    "rarity": "Common",
    "bloom_time_seconds": 300,
    "flower_language_meaning": "Love and Resilient Devotion"
  }
  ```
  ❌ **AI nghiêm cấm tự ý chèn thêm các trường không tồn tại như:**  
  `"flower_title"`, `"flower_code"`, `"flower_type"`, `"internal_code"`, hay `"ui_display_name"` để tránh làm rác database và gãy hệ thống đọc dữ liệu của engine.

### 3.3. Quy Tắc Định Danh ID Chuẩn (`Strict ID Formatting`)
- Toàn bộ ID khóa chính trong hệ thống phải tuân thủ định dạng **snake_case** và mang prefix rõ ràng theo nhóm:
  - `flower_id`: e.g., `flower_tulip_white`, `flower_lavender_calm`
  - `npc_id`: e.g., `npc_florist`, `npc_librarian`, `npc_mayor`
  - `memory_id`: e.g., `memory_grandpa_first_seed`, `memory_festival_golden_era`

---

## 4. Bridge: Asset Bible to Project Structure

Cầu nối minh bạch ánh xạ từ thư mục quy chuẩn tài nguyên (**Asset Bible (`06`)**) vào thư mục mã nguồn và lưu trữ dự án engine thực tế (**Production Bible (`07`)**):

```text
Asset Bible Specification (Tài liệu chuẩn)       Production Engine Directory (Thư mục Engine thực tế)
Docs/06_Asset_Bible/02_Flowers.md         ➔      Assets/Flowers/[category]/[flower_id]/
                                                  ├── Sprites/ (anim_flower_sway.png)
                                                  ├── Icons/ (icon_flower.png)
                                                  └── Data/ (flower_definition.json)

Docs/06_Asset_Bible/05_NPC.md             ➔      Assets/NPC/[role]/[npc_id]/
                                                  ├── Sprites/ (npc_walk.png)
                                                  ├── Portraits/ (portrait_neutral.png)
                                                  └── Data/ (npc_schedule.json)

Docs/06_Asset_Bible/06_UI.md              ➔      Assets/UI/[module]/
                                                  ├── Journal/ (ui_journal_spread.png)
                                                  └── HUD/ (ui_hud_time_clock.png)
```

---

## 5. Production Bible Roadmap (Phase 1 Execution Plan)

Để hoàn thiện trọn vẹn nền tảng lập trình trong **Phase 1 (3–5 ngày)**, bộ Production Bible được triển khai theo đúng thứ tự logic từ tổng quan kiến trúc, dữ liệu đến sự kiện và quy trình kiểm thử:

1. `00_Production_Overview.md` *(Tài liệu hiện tại - Tổng quan & AI Collaboration Standard)*
2. `01_Project_Architecture.md` *(Cấu trúc Engine GDevelop 5, tổ chức Scene & Module logic)*
3. `02_Folder_Convention.md` *(Cây thư mục chuẩn xác cho Source Code và import asset)*
4. `03_Data_Architecture.md` *(Khóa chặt Schema JSON: `FlowerDefinition`, `NPCData`, `PressedMemory`...)*
5. `04_Scene_Architecture.md` *(Cấu trúc Scene, Layer, Z-order, và quản lý Camera)*
6. `05_Event_Architecture.md` *(Kiến trúc Event Sheet, Custom Behaviors & Signal decoupling)*
7. `06_Save_System.md` *(Quy chuẩn cấu trúc Save file JSON, versioning & migration)*
8. `07_AI_Workflow.md` *(AI Collaboration Standard chi tiết chuyên sâu cho Codex)*
9. `08_Coding_Convention.md` *(Quy ước đặt tên biến, hàm, event & comment chuẩn)*
10. `09_Testing_Checklist.md` *(Quy trình kiểm thử, Debugging tools & QA Verification)*
