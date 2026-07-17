# AI_BOOTSTRAP.md (`Project Constitution & Quick Context Loader`)

> ⚠️ **MANDATORY AI BOOTSTRAP PROTOCOL (`READ FIRST IN 30 SECONDS`)**
> Bất kỳ AI Agent nào (`Codex`, `Claude`, `ChatGPT`, `Antigravity`, `Gemini`) trước khi bắt đầu phiên làm việc trong dự án **Plant Tales** phải nạp tài liệu này để xác lập thẩm quyền, hiểu cấu trúc ranh giới và chuẩn bị chu trình gỡ lỗi theo đúng Hiến Pháp.

---

## Q1. Project này là gì? (`What is Plant Tales?`)
- **Tên dự án:** `Plant Tales`
- **Thể loại:** `Cozy Botanical RPG` (Nhập vai quản lý nhà kính và chăm sóc thực vật trong không gian bình yên).
- **Kiến trúc cốt lõi:** `Data-Driven Architecture` (Dữ liệu tĩnh tách biệt hoàn toàn khỏi logic Event Sheet).
- **Chế độ chơi:** `Single Player` (Offline / Prototype Single-player).
- **Engine & Nền tảng:** `GDevelop 5` (`Windows Desktop Target`).

---

## Q2. Đọc tài liệu nào trước? (`Authoritative Reading Order`)
Khi đối diện với một nhiệm vụ mới, AI **không được đọc lung tung hay đọc hết 500 trang Bible**. Tuân thủ trình tự nạp ngữ cảnh tối cao:
```text
┌────────────────────────────────────────────────────────────────────────┐
│                      AUTHORITATIVE READING ORDER                       │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [Level 0: Reality] ──► Kiểm tra thực tế mã nguồn & thư mục trong repo.│
├────────────────────────────────────────────────────────────────────────┤
│ 2. [AI_BOOTSTRAP.md] ───► Nạp 8 câu hỏi cốt lõi này trong 30 giây.     │
├────────────────────────────────────────────────────────────────────────┤
│ 3. [Production Overview]► `Docs/07_Production_Bible/00_Production_Overview`│
├────────────────────────────────────────────────────────────────────────┤
│ 4. [Project Architecture]► `Docs/07_Production_Bible/01_Project_Architecture`│
├────────────────────────────────────────────────────────────────────────┤
│ 5. [Data Constitution] ─► `Docs/07_Production_Bible/03_Data_Architecture`│
├────────────────────────────────────────────────────────────────────────┤
│ 6. [Module Contracts] ──► `Docs/07_Production_Bible/10_Module_Architecture`│
└────────────────────────────────────────────────────────────────────────┘
```
*(Chỉ đọc thêm các tài liệu sâu hơn như `05_Event`, `06_Save`, `09_QA` khi thực thi nhiệm vụ chạm vào đúng miền tương ứng).*

---

## Q3. AI được phép làm gì? (`Allowed AI Actions — ✅`)
- ✅ **Create:** Tạo file mới trong đúng 8 thư mục quy định bên trong `Source/` theo chuẩn `snake_case`.
- ✅ **Expand:** Bổ sung trường dữ liệu mới vào Schema hoặc Profile JSON tĩnh sau khi đã kiểm tra tuân thủ `03_Data_Architecture`.
- ✅ **Refactor internally:** Tối ưu hóa logic nội bộ bên trong một module cụ thể để đạt `Performance Contract (CPU < 12ms, RAM < 400MB)`.
- ✅ **Review:** Tự động kiểm tra chéo (`Self-Review Mandate`) và chạy thẩm định `Continuous Verification Dry-Run`.
- ✅ **Document:** Cập nhật `walkthrough.md`, ghi nhận `Decision Log (ADR)` và xuất báo cáo Handoff chuẩn xác.

---

## Q4. AI tuyệt đối không được làm gì? (`Forbidden AI Actions — ❌ RED LIGHT`)
- ❌ **Rename IDs:** Cấm tự ý đổi ID gốc (`flower_white_lily` cấm đổi thành `flower_lily_01`).
- ❌ **Invent Schema:** Cấm tự ý chèn key lạ vào JSON nếu chưa được định nghĩa trong `03_Data_Architecture.md`.
- ❌ **Duplicate Systems:** Cấm tạo ra `InventoryNew.json` hay `SaveSystemV2.json` để né sửa code cũ.
- ❌ **Cross-Write:** Cấm Module A ghi/sửa trực tiếp biến đối tượng hoặc instance của Module B.
- ❌ **Break Contracts:** Cấm bỏ qua Global Signal Bus; cấm truy xuất `SaveManager` hoặc `UI` trực tiếp từ trong vòng lặp gameplay.
- ❌ **God Sheets:** Cấm tạo Event Sheet hoặc hàm dài vượt quá 150 blocks / 40 dòng (`Single Responsibility`).

---

## Q5. Module Ownership Table (`Who Owns What?`)
Toàn bộ dữ liệu trong game thuộc quyền sở hữu độc quyền của 8 Core Modules. **AI cấm vi phạm ranh giới sở hữu:**

| Tên Module (`Core Module`) | Sở Hữu Độc Quyền Dữ Liệu Tĩnh (`Schemas`) | Sở Hữu Độc Quyền Đối Tượng Động (`Instances`) | Tín Hiệu Phát Ra (`Emitted Signals`) |
| --- | --- | --- | --- |
| **01. Flower Module** | `FlowerDefinition` & `FlowerCatalog` | `FlowerInstance`, `GreenhouseGrid [20x20]` | `FlowerHarvested`, `HybridMutationOccurred` |
| **02. Inventory Module** | `ItemDefinition` & `ItemCatalog` | `InventorySlot [0..19]`, `PlayerEconomy.gold`| `InventoryItemAdded`, `GoldBalanceChanged` |
| **03. NPC Module** | `NPCDefinition` & Dialogue Trees | `NPCInstance` (`pos, hearts, daily flags`) | `NPCTalked`, `NPCGiftReceived` |
| **04. Quest Module** | `QuestDefinition` & Errands | `QuestInstance` (`status, progress`) | `QuestCompleted`, `QuestProgressUpdated` |
| **05. Journal Module** | `CompendiumDefinition` | `JournalEntryInstance`, `MemoryCardInstance` | `JournalEntryUnlocked`, `MemoryCardUnlocked`|
| **06. Weather Module** | `WeatherProfile` | `WeatherState` (`current_profile, is_raining`)| `WeatherChanged` |
| **07. Audio Module** | `AudioProfile` | `AudioState` (`channels, ducking, volume`) | `AudioBGMCrossfadeStarted`, `AudioSFXPlayed`|
| **08. Festival Module** | `FestivalDefinition` | `FestivalState` (`display_slots, score`) | `FestivalStarted`, `FestivalConcluded` |

---

## Q6. Data Flow Diagram (`Authoritative Pipeline`)
Toàn bộ luồng dữ liệu của dự án Plant Tales phải chảy một chiều theo biểu đồ tối cao:
```text
┌────────────────────────────────────────────────────────────────────────┐
│                  AUTHORITATIVE ONE-WAY DATA PIPELINE                   │
├────────────────────────────────────────────────────────────────────────┤
│ [Input Layer] ──► Nhận tín hiệu từ Bàn phím/Chuột (`InputManager`).    │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Phát tín hiệu
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Gameplay Layer] ► `Flower / NPC / Weather / Quest` xử lý logic.       │
│                    ➔ Cấm cập nhật UI hay Save trực tiếp tại tầng này!  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Phát Signal qua `EventBus.Emit()`
            ┌───────────────────────┴───────────────────────┐
            ▼                                               ▼
┌───────────────────────────────────────┐   ┌───────────────────────────────────────┐
│ [Presentation Layer (`UI presentation`)]│   │ [Persistence Layer (`SaveManager`)]   │
│ ➔ Lắng nghe Signal cập nhật HUD      │   │ ➔ Lắng nghe Signal kích hoạt `MarkDirty`│
│ ➔ `Satchel UI`, `Journal UI`          │   │ ➔ Ghi JSON `save_slot_01.json` khi save│
└───────────────────────────────────────┘   └───────────────────────────────────────┘
```

---

## Q7. Handoff Format (`Mandatory AI Report Template`)
Khi kết thúc mỗi ca làm việc, AI buộc phải nộp báo cáo theo biểu mẫu Handoff chuẩn hóa 13 mục từ `07_AI_Collaboration.md`:
```markdown
### 📋 [AI HANDOFF PROTOCOL REPORT]
**Agent Executing:** [Tên AI Agent] | **Task Title:** [Tên nhiệm vụ] | **Status:** `SUCCESS`/`PARTIAL`/`BLOCKED`
#### 1. Executive Summary: [Tóm tắt 2-3 câu]
#### 2. Files Created / Modified: `[NEW]` or `[MODIFY]` [path](file:///path) *(Lý do)*
#### 3. Architecture & Schema Impact: [Database / Save / Signals Added]
#### 4. Authoritative Registry Additions (`New IDs`): [...]
#### 5. Breaking Changes & Compatibility Warnings: `None` / [...]
#### 6. Risk Level Assessment: `LOW` / `MEDIUM` / `HIGH` / `CRITICAL`
#### 7. Architecture Decision Log (`ADR — Decision Log`) ⭐: AD-XXX (`Reason & Trade-off`)
#### 8. Deferred Decisions: [Tính năng hoãn lại & cột mốc review]
#### 9. Technical Debt Register: [Nợ kỹ thuật chấp nhận & deadline fix]
#### 10. Architecture Compliance Score: `100% Compliance`
#### 11. Time & Dependency Impact: [Review time & affected modules]
#### 12. Rollback Strategy: `1. Revert new file -> 2. Restore JSON -> 3. Reset commit`
#### 13. Next Recommended Task for Subsequent AI Agent: [Nhiệm vụ kế tiếp ưu tiên]
```

---

## Q8. Quick Reference Table (`Where to Look?`)
Bảng tra cứu nhanh tài liệu chuyên sâu dành cho AI:

| Khi AI Cần Tra Cứu Vấn Đề (`Need To Know?`) | Trở Ngay Về Tài Liệu Chân Lý (`Authoritative Document`) |
| --- | --- |
| **Quy tắc tạo/sửa file, chuẩn đặt tên thư mục?** | 👉 `Docs/07_Production_Bible/02_Folder_Convention.md` |
| **Quy chuẩn định nghĩa Schema JSON, thêm trường dữ liệu mới?** | 👉 `Docs/07_Production_Bible/03_Data_Architecture.md` |
| **Quy chuẩn viết code GDevelop, 16 luật lập trình AI?** | 👉 `Docs/07_Production_Bible/04_Coding_Convention.md` |
| **Cách khai báo Signal, kiến trúc Global Signal Bus?** | 👉 `Docs/07_Production_Bible/05_Event_Architecture.md` |
| **Cách lưu game, Dirty Flag, Migration, Checksum bảo mật?** | 👉 `Docs/07_Production_Bible/06_Save_Load_System.md` |
| **Quy tắc phối hợp AI, Tháp 7 tầng Priority Stack (`Reality`)?** | 👉 `Docs/07_Production_Bible/07_AI_Collaboration.md` |
| **Lộ trình M0-M6, Tiêu chí hoàn thành (`Exit Criteria`)?** | 👉 `Docs/07_Production_Bible/08_Prototype_Roadmap.md` |
| **Bug SLA Matrix (`S0-S4`), Ngân sách hiệu năng, Debug F3/F4, DoD?** | 👉 `Docs/07_Production_Bible/09_Testing_Debugging.md` |
| **Hợp đồng ranh giới 8 Core Modules (`Owns/Reads/Writes/Publishes`)?**| 👉 `Docs/07_Production_Bible/10_Module_Architecture.md` |
| **Lý do vì sao kiến trúc được chọn (`ADR Registry`)?** | 👉 `Docs/09_Architecture_Decisions/README.md` |
| **Lấy mẫu template chuẩn (ADR, Bug, Handoff, PR, Event)?** | 👉 `Docs/Templates/README.md` |
