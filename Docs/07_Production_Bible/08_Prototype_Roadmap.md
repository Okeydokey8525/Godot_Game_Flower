# Milestone-Driven Prototype Roadmap & Engineering Delivery GPS

**Khung lộ trình xây dựng nguyên mẫu theo từng cột mốc, bản đồ GPS điều hướng cho Codex/AI Agents và tiêu chí hoàn thành (`Exit Criteria / Definition of Done`) cho dự án Plant Tales (Milestone-Driven Prototype Roadmap Document).**

---

## 1. Roadmap Philosophy (`The GPS of AI Engineering`)

Tài liệu **Prototype Roadmap (`08_Prototype_Roadmap.md`)** được ban hành với vai trò là **Hệ Thống Định Vị Toàn Cầu (*The GPS of Codex & AI Engineering*)** – bản đồ dẫn đường cốt lõi giúp bất kỳ lập trình viên hay AI Agent nào (`Codex`, `Antigravity`, `Claude`, `ChatGPT`) ngay lập tức xác định chính xác trình tự xây dựng, ưu tiên module và điểm dừng rõ ràng mà không phải đoán mò hay xây dựng lộn xộn.

Thay vì liệt kê theo thời gian phi tuyến tính kiểu `"Day 1, Day 2, Day 3"` (vốn cực kỳ dễ gãy và mất ý nghĩa khi thay đổi tốc độ code), lộ trình của **Plant Tales** được kiến trúc hóa dựa trên phương pháp **Milestone-Driven Execution (*Lập trình hướng Cột Mốc Kiến Trúc*)**.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   MILESTONE-DRIVEN ROADMAP HIERARCHY                   │
├────────────────────────────────────────────────────────────────────────┤
│ M0: [Project Bootstrap] ──► Nền móng Engine, Boot Scene, Input Core    │
│            │                                                           │
│            ▼                                                           │
│ M1: [Vertical Slice Garden] ──► Di chuyển, Trồng hoa, Tưới nước, Save  │
│            │                                                           │
│            ▼                                                           │
│ M2: [Core Gameplay Loop] ──► Thu hoạch, Satchel, Nhật ký, Hội thoại NPC│
│            │                                                           │
│            ▼                                                           │
│ M3: [World Simulation] ──► Đồng hồ nhịp tim, Thời tiết mưa/nắng, Lễ hội │
│            │                                                           │
│            ▼                                                           │
│ M4: [Content Expansion] ──► Lai tạo di truyền, Ký ức ép hoa, Nâng cấp  │
│            │                                                           │
│            ▼                                                           │
│ M5: [Polish & Optimization] ──► Culling 60 FPS, Object Pool, VFX rèm   │
│            │                                                           │
│            ▼                                                           │
│ M6: [Release Candidate] ──► Khóa Checksum Save, Kiểm thử QA, Đóng gói  │
└────────────────────────────────────────────────────────────────────────┘
```

### 4 Nguyên Tắc Bất Biến Của Lộ Trình Cột Mốc
1. **No Milestone Skipping (`Cấm nhảy cóc cột mốc`):** Nghiêm cấm hoàn toàn việc AI bắt tay vào code `M3 — Weather System` hay `M4 — Genetics` khi cột mốc `M1 — Vertical Slice` chưa vượt qua bài kiểm tra `Exit Criteria`.
2. **Clear Exit Criteria (`Định nghĩa hoàn thành tuyệt đối`):** Mỗi Milestone không được coi là "Xong" dựa trên cảm tính. Một Milestone chỉ đóng lại (`Closed/Passed`) khi vượt qua 100% danh sách tiêu chí kiểm định (`Exit Criteria Checkbox`).
3. **Decoupled Delivery (`Giao nộp độc lập`):** Mỗi cột mốc sau khi hoàn thành phải có khả năng chạy độc lập (`Playable Prototype Build`), không crash ngay cả khi các hệ thống ở cột mốc tương lai chưa hề viết code.
4. **Architectural Traceability (`Truy xuất ngược Constitution`):** Mọi module code trong Roadmap đều phải trỏ rõ ràng về các Hiến pháp `01-07` của Production Bible và `00-08` của Asset Bible.

---

## 2. Milestone M0 — Project Bootstrap (`Engine Core Scaffolding`)

Cột mốc 0 là giai đoạn dựng khung xương sống kỹ thuật cơ bản nhất trong Engine **GDevelop 5**. Không có bất kỳ hình ảnh hoa lá trang trí phức tạp nào, M0 tập trung 100% vào sự ổn định của luồng boot khởi động và hệ thống tín hiệu ngầm.

### 2.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Folder Scaffolding:** Tạo chuẩn xác 8 thư mục độc tôn bên trong `Source/` theo đúng `02_Folder_Convention.md`.
- **BootScene & MainMenuScene Setup:** Khởi tạo `BootScene` làm điểm nạp dữ liệu tĩnh và khởi tạo 4 Singletons (`GameManager`, `EventBus`, `TimeTicker`, `SaveManager`).
- **Input Controller Module:** Khởi tạo bộ gom tín hiệu đầu vào (`InputManager`) chuyển hóa từ bàn phím (`WASD/Arrows`) và Chuột sang tín hiệu hướng di chuyển chuẩn hóa.
- **Save Skeleton & JSON Loader:** Khởi tạo `SaveManager` trống có khả năng tạo file `save_slot_01.json` mặc định và nạp `flower_definition_*.json` vào bộ nhớ đọc.
- **Debug Overlay Console:** Lắp đặt bảng thông tin kỹ thuật F3 (`FPS`, `RAM`, `Current Scene`, `Active Singletons`, `Time Ticker State`).

### 2.2. Tiêu Chí Hoàn Thành (`M0 Exit Criteria / Definition of Done`)
- [ ] **1. Clean Boot:** Game khởi chạy thẳng vào `BootScene`, nạp xong 4 Singletons trong dưới `1.0s` rồi tự động chuyển tiếp sang `MainMenuScene`.
- [ ] **2. Zero Errors:** Log Console hoàn toàn sạch sẽ, không có bất kỳ cảnh báo `Null Reference`, `Missing Asset` hay `JSON Parse Error` nào.
- [ ] **3. Input Verified:** Nhấn phím `WASD` phát tín hiệu `OnMovementInput` ghi log chính xác ra Debug Console mà không phụ thuộc sprite nhân vật.
- [ ] **4. Skeleton Save Check:** Nhấn nút `F5` tạo ra tệp tin `save_slot_01.json` chuẩn 10 ngăn kèm khối `metadata.version` theo đúng `06_Save_Load_System.md`.

---

## 3. Milestone M1 — Vertical Slice Garden (`The Playable Core`)

Đây là cột mốc sống còn của toàn bộ dự án. M1 mang đến một lát cắt trải nghiệm hoàn chỉnh (`Vertical Slice`): người chơi bước vào nhà kính, trồng một hạt giống, tưới nước cho đất ẩm, nhìn thấy bông hoa lớn lên và lưu lại thành tích đó.

```text
┌────────────────────────────────────────────────────────────────────────┐
│               M1 VERTICAL SLICE GARDEN CORE LOOP                       │
├────────────────────────────────────────────────────────────────────────┤
│ [Walk to Grid Slot] ──► [Select Seed Item] ──► [Plant `FlowerInstance`]│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Chuyển sang Stage 1: Hạt mầm)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Equip Watering Can] ──► [Water Slot] ──► [Moisture Level -> 100%]     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (`TimeTicker` tích tắc mỗi giây)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Growth Stage Advancement] ──► Stage 1 ➔ Stage 2 ➔ Stage 3 (Bloom!)    │
└────────────────────────────────────────────────────────────────────────┘
```

### 3.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Player Movement & Camera Follow:** Kết nối sprite Mia/Okeydokey vào `InputManager`, tích hợp hệ thống camera theo dõi mượt mà (`Lerp Damping`).
- **Greenhouse Grid & Soil System:** Khởi tạo lưới đất trồng `GreenhouseScene` (`Tile Grid Matrix`), quản lý trạng thái từng ô đất (`Dry / Wet / Occupied`).
- **Flower Instance Module (Core):** Dựng class `FlowerInstance` với các thuộc tính (`instance_id`, `flower_ref_id`, `grid_x`, `grid_y`, `stage`, `moisture_level`).
- **Watering & Growth Pipeline:** Lập logic kiểm tra độ ẩm từ `TimeTicker`: nếu `moisture > 0`, hoa tích lũy thời gian sinh trưởng để nhảy sang giai đoạn tiếp theo (`Stage 1 -> 2 -> 3`).
- **Atomic Save & Reload Integration:** Kết nối `FlowerSystem` vào `SaveManager`, bảo đảm khi thoát game và vào lại, toàn bộ chậu hoa nằm đúng vị trí và đúng giai đoạn phát triển.

### 3.2. Tiêu Chí Hoàn Thành (`M1 Exit Criteria / Definition of Done`)
- [ ] **1. Smooth Movement:** Nhân vật di chuyển mượt mà 8 hướng trong Nhà kính, va chạm không xuyên tường (`Tile Collisions`).
- [ ] **2. Planting & Watering verified:** Có thể click vào ô đất trống trồng `White Lily`, lấy bình tưới nước làm đất biến đổi màu sang ẩm (`Wet Soil`).
- [ ] **3. Real Growth Tick:** Bông hoa tự động lớn từ Hạt Mầm (`Stage 1`) lên Mầm Lá (`Stage 2`) và Nở Hoa (`Stage 3`) đúng theo chu kỳ thời gian cấu hình.
- [ ] **4. 30-Minute Stability & Save Loop:** Có thể lưu game thủ công, tắt GDevelop, mở lại tải save và nhìn thấy đúng khu vườn đang trồng mà **không crash trong 30 phút test liên tục**.

---

## 4. Milestone M2 — Core Gameplay Loop (`The Cozy Economy`)

Khóa xong M1, cột mốc M2 biến lát cắt kỹ thuật thành một vòng lặp trò chơi hoàn chỉnh (`Cozy Economy Loop`). Người chơi có thể thu hoạch hoa, cất vào túi xách, mở trang tiêu bản ghi nhận thành tích và tương tác với các cư dân thị trấn.

### 4.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Harvest & Loot Drop System:** Xử lý sự kiện click thu hoạch hoa nở (`Stage 3/4`), phát Signal `FlowerHarvested`, sinh ra vật phẩm nạp vào Satchel.
- **Inventory Module (`Satchel Slots`):** Xây dựng kho đồ 20 ô (`InventorySlot`) với khả năng xếp chồng tối đa `99 item/stack`, kiểm tra kho đầy (`Overflow Protection`).
- **Journal & Pressed Memory Module (Core):** Khi một loài hoa mới được thu hoạch lần đầu, tự động mở khóa trang tiêu bản (`JournalEntry.unlocked = true`) và kích hoạt hiệu ứng chúc mừng (`Bloom Alert UI`).
- **NPC State & Dialogue Box System:** Đưa 3 NPC cốt lõi (`Florist`, `Mayor`, `Old Gardener`) vào `VillageScene`. Xây dựng khung hội thoại chuẩn (`Dialogue Box UI`) với khả năng đếm điểm thân thiện (`Heart Points`).
- **Gift Giving Mechanics:** Cho phép chọn hoa trong Satchel mang tặng NPC, kích hoạt phản ứng hội thoại riêng biệt theo sở thích (`NPCData.loved_items`).

### 4.2. Tiêu Chí Hoàn Thành (`M2 Exit Criteria / Definition of Done`)
- [ ] **1. Harvest to Satchel:** Thu hoạch 5 bông hoa `Blue Lavender`, mở Satchel UI hiển thị đúng 1 ô chứa `Blue Lavender x5`.
- [ ] **2. Journal Unlocked:** Lật trang sách Tiêu Bản (`Journal UI`), nhìn thấy trang `Blue Lavender` đã sáng màu từ trạng thái bóng đen (`Silhouette`).
- [ ] **3. Interactive Dialogue:** Nói chuyện với `Florist` hiển thị đúng câu chào theo khung thoại từng chữ (`Typewriter Effect`), không bị nghẽn hay lặp phím.
- [ ] **4. Gift & Heart Tracking:** Tặng hoa cho `Florist` tăng điểm `Hearts +50`, lưu lại thành công và duy trì điểm số qua ngày mới.

---

## 5. Milestone M3 — World Simulation (`The Living Soundscape & Time`)

M3 thổi hồn vào thế giới Plant Tales, biến một khu vườn tĩnh lặng thành một hệ sinh thái đang hít thở (`Living World Simulation`) với sự xoay chuyển ngày đêm, thời tiết và âm thanh sống động.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                     M3 WORLD SIMULATION TIMELINE                       │
├────────────────────────────────────────────────────────────────────────┤
│ [Morning (06:00)] ──► Ánh nắng trong trẻo, BGM nhẹ nhàng, NPC ra quảng │
│                       trường.                                          │
├────────────────────────────────────────────────────────────────────────┤
│ [Afternoon (14:00)] ──► Thời tiết đổi: Mưa Rào (`Spring Rain`).        │
│                         ➔ Tự động làm ẩm (`Moisture = 100%`) toàn bộ   │
│                            hoa ngoài trời mà không cần tưới tay!      │
├────────────────────────────────────────────────────────────────────────┤
│ [Evening (20:00)] ──► Đèn lồng bật sáng lung linh, BGM đệm Acoustic.   │
├────────────────────────────────────────────────────────────────────────┤
│ [Midnight (24:00)] ──► Kích hoạt `Auto Save`, chuyển sang `Day + 1`.  │
└────────────────────────────────────────────────────────────────────────┘
```

### 5.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Time Ticker & Day/Night Cycle:** Hoàn thiện đồng hồ thời gian thực (`1 giây ngoài đời = 1 phút trong game`), lớp phủ ánh sáng thay đổi từ Sáng ➔ Trưa ➔ Hoàng Hôn ➔ Đêm (`Color Tint Matrix`).
- **Weather Module (`Spring Rain & Sunshine`):** Khởi tạo hệ thống thời tiết ngẫu nhiên theo mùa. Khi mưa (`Rain Profile`), tự động duy trì độ ẩm `100%` cho các chậu hoa ngoài trời và thay đổi hiệu ứng âm thanh môi trường.
- **Audio Soundscape Engine (`08_Audio.md`):** Quản lý 3 lớp thanh âm (`Layered Audio`): `Base BGM` + `Environmental Ambience (Gió/Mưa/Chim)` + `Interactive SFX`. Tự động gãy gọn chuyển đoạn âm nhạc khi qua lại nhà kính.
- **Festival Display Module (Spring Bloom Day):** Dựng khung sự kiện Lễ Hội Hoa Xuân (`Day 28`), cho phép đặt hoa lên bàn trưng bày để nhận điểm số theo thông số độ hiếm.

### 5.2. Tiêu Chí Hoàn Thành (`M3 Exit Criteria / Definition of Done`)
- [ ] **1. Day/Night Tinting:** Lớp phủ ánh sáng tự động chuyển màu mượt mà theo kim đồng hồ mà không làm sụt giảm FPS.
- [ ] **2. Rain Moisture Sync:** Khi hệ thống nổ mưa (`Weather = Rain`), kiểm tra tất cả các chậu hoa ngoài trời đều tự động nhảy độ ẩm lên `100%`.
- [ ] **3. Dynamic Audio Layering:** BGM tự động giảm âm lượng nhẹ (`Duck Volume`) khi mở màn hình Nhật Ký hoặc khi có thoại NPC, chuyển cảnh mượt không bị khựng tiếng.
- [ ] **4. Day-Transition Auto Save:** Chuyển từ ngày 14 sang ngày 15 tự động kích hoạt `SaveManager.MarkDirty()`, tạo ra `save_auto.json` an toàn hoàn hảo.

---

## 6. Milestone M4 — Content Expansion (`Genetics, Memories & Advanced NPC`)

Cột mốc M4 mở khóa các hệ thống chiều sâu (*Deep Gameplay Systems*), biến Plant Tales từ một game cozy cơ bản thành một cuốn sổ tay thực vật học thực thụ đầy cuốn hút.

### 6.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Flower Genetics & Hybrid Mutation Engine:** Xây dựng thuật toán lai tạo (`Cross-Pollination Engine`). Khi 2 hoa liền kề nở rộ (`White Lily + Red Rose`), có xác suất `15%` sinh ra hạt giống biến dị (`Pink Hybrid Lily`).
- **Pressed Memory System (`Epiphany Trigger`):** Khi chạm vào các kỷ vật trong nhà kính ông nội, kích hoạt cutscene ép hoa (`Memory Cutscene`), mở khóa thẻ ký ức kèm hiệu ứng hạt lấp lánh (`Particle VFX`).
- **Advanced NPC Schedules (`AI Pathfinding Routine`):** Định nghĩa lịch trình di chuyển theo khung giờ cho NPC (`Florist`: 08h Mở tiệm ➔ 12h Ăn trưa quảng trường ➔ 18h Đi dạo bờ hồ).
- **Greenhouse Expansion Module:** Cho phép dùng tiền (`Gold`) mua thêm các ô đất canh tác mới, mở rộng lưới nhà kính từ `10x10` lên `20x20`.

### 6.2. Tiêu Chí Hoàn Thành (`M4 Exit Criteria / Definition of Done`)
- [ ] **1. Hybrid Seed Generation:** Trồng 2 hoa cạnh nhau đủ điều kiện, kiểm tra thành công việc sinh ra hạt giống lai (`Hybrid Seed`) và cất vào Satchel.
- [ ] **2. Memory DTO Unlocked:** Kích hoạt ký ức số 1, kiểm tra `save_slot_01.json` đã lưu trường `"memories": ["memory_01"]` chuẩn xác.
- [ ] **3. Schedule Routine Verified:** Khi đồng hồ chỉ `12:00`, `Florist` tự động di chuyển theo đường đi tới quảng trường, không bị kẹt vào các vật cản tĩnh.
- [ ] **4. Expansion Grid Sync:** Mua mở rộng đất, thoát ra nạp lại save, số lượng ô đất tăng lên hiển thị đúng không bị mất dữ liệu hoa trồng cũ.

---

## 6.B. Sprint M4.1D — Automated Content Audit (`Gameplay Balance Rules & Asset Budget`)

Đây là chặng kiểm định tự động thứ 3 (`Quality Gate / Layer 3 Audit`) trước khi bước sang cân bằng thực tế (`Pre-Alpha Stabilization`). Mục tiêu là phát hiện tự động các lỗi thiết kế hợp lệ về mặt JSON (`Schema OK, References OK`) nhưng vô lý hoặc phá vỡ cân bằng gameplay (`Gameplay Balance Fail`).

### 6.B.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Balance Rules Repository (`Docs/BalanceRules/`):** Ban hành 5 tài liệu quy chuẩn (`flower_balance.md, quest_balance.md, economy_balance.md, season_balance.md, asset_budget.md`) xác lập các ngưỡng Tier, ROI, giờ hợp lệ `0~23`, chống lạm phát vàng và trần ngân sách tài nguyên trước Alpha.
- **Layer 3 Automated Audit Engine:** Tích hợp kiểm tra luật cân bằng vào `ContentManagerSystem`: cảnh báo hoa sai Tier, kiểm tra đồ thị hội thoại chống vòng lặp vô tận (`Dialogue Graph check`), kiểm tra tọa độ NPC trong các scene hợp lệ.
- **Asset Budget Enforcement:** Động cơ kiểm tra trần giới hạn (`12 Flowers, 4 NPCs, 15 Quests, 4 Seasons...`). Nếu AI hoặc Designer tạo vượt ngân sách, hệ thống phát `[WARNING/CRITICAL AUDIT]` ngăn chặn phình to dự án (`Scope Creep`).

### 6.B.2. Tiêu Chí Hoàn Thành (`M4.1D Exit Criteria / Definition of Done`)
- [ ] **1. 4-Layer Audit Pipeline Verified:** `ContentManagerSystem` thực thi đầy đủ 3 lớp tự động (`Schema, Reference, Balance Audit`) và xuất báo cáo sạch `SUCCESS_DATA_DRIVEN` ra `Content_Validation_Report.txt`.
- [ ] **2. Asset Budget Locked:** Kiểm định thành công 100% các hạng mục (`Flowers 12/12, NPCs 4/4, Quests 15/15, Seasons 4/4`) đều đạt khóa chuẩn trước Alpha.

---

---

## 6.C. Milestone M4.2 — Pre-Alpha Stabilization (`Content Lock & 4-Phase Verification`)

Sau khi vượt qua `M4.1D Automated Content Audit`, toàn bộ dữ liệu nội dung JSON (`Flowers, NPCs, Quests, Dialogues, Weather, Seasons`) chính thức được khóa cứng (`Content Lock`). Để đảm bảo tính chính xác và an toàn trước khi gửi bản build cho người chơi thật, M4.2 phân biệt rõ ràng giữa **Mô phỏng tự động (`Automated Simulation Runs`)** và **Kiểm thử bởi người chơi thật (`Human Playtests / Internal QA`)** theo lộ trình 5 bước chuẩn studio chuyên nghiệp:

```text
M4.2A.0: Measurement Freeze ➔ M4.2A: Gameplay Balance (ACCEPTED via Automated Simulation) ➔ M4.2B: Economy Validation ➔ M4.2C: Performance Validation ➔ M4.2D: Internal QA (Human Playtests) ➔ Alpha Candidate ➔ Internal Alpha ➔ Telemetry ➔ Balance Patch ➔ Steam Demo
```

> [!IMPORTANT]
> **Quy Tắc Phân Biệt Dữ Liệu (`Simulation vs Human Telemetry Mandate`):**
> - **Automated Simulation Runs (`M4.2A / M4.2B`):** Dùng script tự động lặp (`run_telemetry_sim.py`) để kiểm chứng logic kinh tế lý tưởng, tỷ suất hoàn vốn (`ROI`), và không lỗi đường cong.
> - **Human Playtests (`M4.2D / Internal Alpha`):** Dữ liệu từ người chơi thật có hành vi khó đoán (quên tưới, spam ngủ, AFK, đầy inventory, bỏ qua NPC/Quest, trồng mono-crop, reset save). Mọi báo cáo phải ghi rõ nguồn dữ liệu là `Simulation` hay `Human Playtest`.

### 6.C.0. Sprint M4.2A.0 — Measurement Freeze (`Pre-Balance Foundational Lock — COMPLETED`)
Khóa kín cơ sở hạ tầng đo đạc, ý đồ thiết kế và ngân sách trước khi bước vào cân bằng:
- **Design Intent Mandate:** Bổ sung lý do tồn tại và ý đồ thiết kế vào `flower_balance.md, quest_balance.md, economy_balance.md, season_balance.md`.
- **Session Metadata Logging:** Cập nhật Telemetry nạp header `Run ID, Random Seed, Build Version, Schema Version` vào `session_telemetry.jsonl`.
- **Soft vs Hard Limit Budget:** Khóa `asset_budget.md` theo 2 tầng `Soft Limit` (Cảnh báo) vs `Hard Limit` (Block merge).
- **Regression Priority Tiering:** Phân cấp `Regression_Checklist.md` thành `P0, P1, P2`.
- **Performance Budget Constitution:** Ban hành `Performance_Budget.md` khóa hợp đồng hiệu năng (`Boot < 0.2s, RAM < 5MB, Draw Calls < 250, FPS >= 60`).

### 6.C.1. Danh Sách Hệ Thống Cần Xây Dựng & Thẩm Định (`Deliverables`)
- **M4.2A — Gameplay Balance (`ACCEPTED via 50 Automated Simulation Runs`):** Tinh chỉnh nhịp điệu sinh trưởng (`growth_time`), giá bán (`sell_price`), và xác thực 5 Core KPIs lý tưởng qua script mô phỏng.
- **M4.2B — Economy Validation (`ROI Matrices & Behavioral Telemetry Suite`):**
  - **Khung ROI đa chiều:** Tính toán & xác thực `ROI, ROI/day, ROI/stamina, ROI/season, ROI/weather` bảo đảm hoa cao cấp (`Lotus, Orchid`) thực sự mang lại lợi thế vượt trội so với cây khởi đầu (`Daisy`), chấm dứt nghịch lý tier thấp lời hơn tier cao.
  - **6 Chỉ số hành vi (`Behavioral KPIs`):** Bổ sung hệ thống đo đạc hành vi chuẩn bị đón người chơi thật:
    1. *FTUE Time:* Average tutorial completion time (`Target < 15 mins`).
    2. *Stamina Utilization:* Average stamina left before sleep (`Target: không ngủ với > 40 stamina thừa`).
    3. *Watering Engagement:* Average watered crops/day (`Target > 3 cây/ngày`).
    4. *Quest Friction:* Quest abandon rate / ignored rate / retry count.
    5. *NPC Interaction:* Average NPC interaction/day (`Target: người chơi chủ động trò chuyện để nhận thưởng`).
    6. *Economy Source Breakdown:* Phân tích % thu nhập từ `Quest vs Flower vs Shipping vs Item`.
- **M4.2C — Performance Validation (`From Budget Contract to Measurement Evidence`):** Chuyển dịch từ Hợp đồng Ngân sách (`Performance Budget`) sang Bằng chứng Đo đạc thực tế (`Performance Measurement Evidence`) cho 7 chỉ số: `Boot Time, JSON Parse Time, Peak RAM Usage, Frame Time (ms), Object Count, Save File Size, Save/Load Execution Time`.
- **M4.2D — Internal QA (`Human Playtest Verification & Checklist`):** Thu thập dữ liệu thực tế từ 50 người thử nghiệm nội bộ (`Internal Playtesters`) trước khi cấp chứng chỉ `Alpha Candidate`:
  - `50 bug reports` & `20 feedback forms`.
  - `Top 10 frustrations` vs `Top 10 favorite features`.
  - `Most ignored flower / NPC` & `Most failed quest`.
  - `Average session duration` & `Average retention rate`.

### 6.C.2. Tiêu Chí Hoàn Thành (`M4.2 Exit Criteria / Definition of Done`)
- [x] **1. M4.2A Accepted via Simulation:** Kiểm chứng đạt 5 Core KPIs qua 50 lượt mô phỏng tự động (`50 Automated Simulation Runs`).
- [ ] **2. M4.2B Economy Validation Verified:** Bảng ma trận `ROI/day, ROI/stamina, ROI/season` chứng minh đúng hierarchy tầng cấp hoa (`Tier 1 -> Tier 3`) và 6 chỉ số hành vi được tích hợp vào bộ đo đạc.
- [ ] **3. M4.2C Performance Measurement Signed-off:** Báo cáo đo đạc thực nghiệm chứng minh cả 7 chỉ số hiệu năng nằm dưới trần `Performance_Budget.md`.
- [ ] **4. M4.2D Human Playtest Gate Passed:** Hoàn tất thu thập báo cáo từ người chơi thử nội bộ, xử lý các frustration chính, đạt điều kiện bước lên `Alpha Candidate`.
- [ ] **5. Zero Gameplay Code Modification:** Toàn bộ quá trình chuẩn hóa M4.2 tuân thủ tuyệt đối việc chỉ can thiệp thông số dữ liệu JSON, `0` dòng code lập trình GDevelop bị chỉnh sửa.
- [ ] **6. Alpha Candidate Certification:** Ký nghiệm thu chính thức đủ điều kiện mở van `Internal Alpha Playtests`.

---

## 7. Milestone M5 — Polish, VFX & Performance Optimization

M5 là giai đoạn nâng tầm thẩm mỹ và hiệu năng (*AAA Polish & Optimization*). Đảm bảo game không chỉ chạy tốt mà phải đạt chuẩn "sững sờ" (`Wow Factor`) với 60 FPS kiên định ngay cả khi khu vườn nở rộ hàng trăm đóa hoa.

### 7.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **Spatial Culling & Object Pools:** Tích hợp kỹ thuật culling tự động ẩn các sprite hoa/NPC nằm ngoài vùng nhìn của camera (`Screen Boundary Check`). Xây dựng `Object Pool` tái sử dụng đạn nước tưới và hạt bụi VFX thay vì sinh/xóa (`Create/Delete`) liên tục.
- **Living Animation Standard (`07_Animation.md`):** Kích hoạt các vi chuyển động (`Micro-animations`): hoa lắc rinh nhẹ theo chiều gió (`Sine Wave Sway`), lá rung khi thu hoạch, bóng rèm cửa sổ nhà kính đung đưa.
- **UI Micro-Interactions & Glassmorphism:** Tinh chỉnh toàn bộ UI (`Satchel`, `Journal`) đạt chuẩn mượt mà: nút bấm phóng to `1.05x` và phát âm sfx thanh nhã khi di chuột over, hiệu ứng kính mờ (`Glassmorphism Backdrop`).
- **Performance Budget Auditing:** Khóa mức sử dụng tài nguyên: CPU không vượt quá `12 ms/frame`, RAM ổn định dưới `400 MB`.

### 7.2. Tiêu Chí Hoàn Thành (`M5 Exit Criteria / Definition of Done`)
- [ ] **1. 60 FPS Stress Test:** Trồng đầy đủ `500 chậu hoa` ở giai đoạn nở rộ (`Stage 3`), di chuyển camera liên tục, FPS kiên định ở mức `60 FPS` không bị rớt/giật.
- [ ] **2. Zero Per-Frame Polling:** Kiểm tra Profiler GDevelop khẳng định không có Event Sheet nào chạy `Check All Objects Every Frame` cho logic va chạm hay sinh trưởng.
- [ ] **3. Smooth Micro-VFX:** Tất cả các hoa trên lưới đều có độ lệch pha rung rinh gió (`Phase Offset`) không bị gật đầu đồng loạt như robot.

---

## 8. Milestone M6 — Release Candidate (`Master Delivery Gate`)

Cột mốc cuối cùng trước khi đóng gói gửi tới người chơi. M6 tập trung vào an ninh dữ liệu, kiểm thử khả năng chịu lỗi tối đa (`Stress & Crash Recovery`) và đóng gói mã nguồn production sạch sẽ.

### 8.1. Danh Sách Hệ Thống Cần Xây Dựng (`Deliverables`)
- **SHA-256 Checksum Security Lock:** Kích hoạt toàn diện cơ chế mã hóa Checksum cho `save_slot_01.json`, tự động khôi phục từ file `.bak` hoặc `.previous` nếu phát hiện hỏng hóc theo đúng `Chương 10-12 của 06_Save_Load_System.md`.
- **Zero-Crash Migration Dry-Runs:** Chạy kiểm nghiệm thực tế việc nạp file save giả lập bản `v1.0.0` lên Engine `v1.2.0`, xác minh bộ `Migrators` tự chèn default values mượt mà không crash.
- **Comprehensive QA Test Suite (`09_Testing_Debugging.md`):** Thực thi toàn diện 50 kịch bản kiểm thử (kiểm thử tràn kho, kiểm thử âm tiền, kiểm thử ngắt điện giữa lúc lưu game...).
- **Master Production Packaging:** Đóng gói bản build Windows (`PC Desktop`), dọn dẹp toàn bộ file test/scratch ra khỏi `Source/`, chốt phiên bản `Release Candidate 1.0.0-RC1`.

### 8.2. Tiêu Chí Hoàn Thành (`M6 Exit Criteria / Definition of Done`)
- [ ] **1. Zero Known Crash:** Vượt qua 100% bộ Test Suite 50 kịch bản, không tồn tại bất kỳ lỗi Crash hay Soft-lock nào trong suốt 48 giờ test tự động.
- [ ] **2. Checksum Recovery Verified:** Mở file `save_slot_01.json` xóa đi nửa dòng, mở game lên hệ thống tự động đổi tên thành `.bad` và khôi phục thành công từ `.bak` kèm thông báo UI.
- [ ] **3. 100% Architecture Compliance Check:** Chạy đánh giá điểm số tuân thủ kiến trúc đạt `100% Compliance` với toàn bộ 10 tài liệu Production Bible.

---

## 9. Summary Table & Architectural Traceability Matrix

Bảng tổng hợp hành trình GPS dẫn đường cho Codex/AI Engineers, trỏ thẳng tới các cột trụ Hiến pháp tương ứng:

| Milestone (`ID`) | Tên Giai Đoạn (`Title`) | Trọng Tâm Xây Dựng (`Core Deliverables`) | Hiến Pháp Bảo Chứng (`Bible Traceability`) | Tiêu Chí Khóa (`Exit Gate`) |
| :---: | --- | --- | --- | --- |
| **M0** | **Project Bootstrap** | 8 Thư mục `Source/`, BootScene, 4 Singletons, Input Core, Save Skeleton, Debug F3. | `01_Project`, `02_Folder`, `03_Data`, `05_Event` | Clean Boot `< 1.0s`, Zero Console Error, Save Skeleton OK. |
| **M1** | **Vertical Slice Garden**| Di chuyển 8 hướng, Lưới đất trồng, `FlowerInstance`, Tưới nước, Sinh trưởng qua thời gian, Atomic Save. | `03_Data`, `05_Event`, `06_Save`, `Asset 02_Flowers` | Trồng, tưới, hoa nở chuẩn xác. Play & Save ổn định 30 phút. |
| **M2** | **Core Gameplay Loop** | Thu hoạch hoa, Satchel 20 ô xếp chồng, Tiêu bản Nhật ký, Hội thoại NPC, Tặng quà & Heart Points. | `03_Data`, `05_Event`, `Asset 01_Chars`, `Asset 05_NPC` | Thu hoạch vào kho, mở Nhật ký sáng màu, thoại NPC gõ chữ mượt. |
| **M3** | **World Simulation** | Đồng hồ Time Ticker, Lớp phủ ngày đêm, Thời tiết Mưa rào/Nắng, Lễ Hội Hoa Xuân, 3 lớp Audio layer. | `05_Event`, `06_Save`, `Asset 08_Audio` | Mưa tự làm ẩm 100% hoa, BGM ducking khi thoại, Auto save ngày mới. |
| **M4** | **Content Expansion** | Lai tạo di truyền (`Hybrid Mutation`), Ký ức ép hoa (`Pressed Memory`), Lịch trình di chuyển NPC. | `03_Data`, `06_Save`, `GameDesign Bible` | Trồng 2 hoa cạnh nhau nảy mầm lai `15%`, NPC đi đúng giờ không kẹt. |
| **M4.1D** | **Automated Audit** | Kiểm định tự động Lớp 3 (`Layer 3 Balance & Budget`), 5 tệp `BalanceRules/`, khóa Asset Budget trước Alpha. | `03_Data`, `Docs/BalanceRules/` | `0` lỗi cân bằng logic, `100%` ngân sách tài nguyên được khóa. |
| **M4.2A.0** | **Measurement Freeze** | Khóa nền tảng đo đạc: Design Intent, Session Metadata Telemetry, Soft/Hard Budget, P0 Regression, Performance Budget. | `09_Testing`, `Docs/BalanceRules/` | `0` cảm tính phỏng đoán, đủ 5 hợp đồng đo đạc sẵn sàng cho M4.2A. |
| **M4.2** | **Pre-Alpha Stabilization**| Cân bằng 4 giai đoạn (`Gameplay -> Economy -> Performance -> Playtest Lock`), chuẩn bị cho Internal Alpha. | `03_Data`, `08_Prototype_Roadmap` | `0` tệp thêm mới, `0` code GDevelop sửa, nhịp kinh tế chuẩn 1 mùa. |
| **M5** | **Polish & Optimization**| Spatial Culling, Object Pool, Vi chuyển động (`Living Animation`), UI Glassmorphism, Kiểm soát 60 FPS. | `04_Coding`, `Asset 06_UI`, `Asset 07_Animation` | 500 chậu hoa trên màn hình vẫn đạt kiên định `60 FPS`, Zero polling. |
| **M6** | **Release Candidate** | SHA-256 Checksum Lock, Migration Dry-runs, QA Test Suite 50 kịch bản, Master Build Packaging. | `06_Save_Load_System`, `07_AI_Collaboration` | Zero Crash/Soft-lock trong 48h, khôi phục `.bak` tự động thành công. |

---

## Appendix: Production Readiness Checklist & Status

- [x] Khóa triết lý Roadmap hướng Cột Mốc (`Milestone-Driven Execution`) và cấm nhảy cóc cột mốc.
- [x] Định nghĩa trọn vẹn chi tiết 7 cột mốc từ `M0 (Bootstrap)` đến `M6 (Release Candidate)`.
- [x] Thiết lập danh sách `Deliverables` và bộ tiêu chí hoàn thành tuyệt đối `Exit Criteria` cho từng cột mốc.
- [x] Khóa ma trận truy xuất ngược kiến trúc `Traceability Matrix` nối liền Roadmap tới Production Bible & Asset Bible.
- [x] Bảo đảm tính tương thích tuyệt đối với `07_AI_Collaboration.md (7-Tier Priority Stack & Handoff Protocol)`.

**Status: Approved**
*(Khóa lộ trình cột mốc nguyên mẫu toàn cục ở cấp độ hoàn hảo AAA. Sẵn sàng tiến sang Module 09: `09_Testing_Debugging.md`).*
