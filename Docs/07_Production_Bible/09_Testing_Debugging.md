# QA Constitution & Testing & Debugging Standard

**Hiến pháp bảo đảm chất lượng, quy chuẩn kiểm thử đa tầng, hợp đồng hiệu năng (`Performance Contract`), kiểm thử quyết định (`Deterministic Testing`) và công cụ chẩn đoán lỗi (`QA Constitution & Testing & Debugging Standard Document`) cho dự án Plant Tales.**

---

## 1. Testing Philosophy (`The Constitution of Quality Assurance`)

Tài liệu **Testing & Debugging Standard (`09_Testing_Debugging.md`)** được ban hành không chỉ là một tài liệu hướng dẫn gỡ lỗi đơn thuần, mà là **Hiến pháp Kiểm thử và Đảm bảo Chất lượng Tối cao (*The Constitution of Quality Assurance*)** cho toàn bộ dự án **Plant Tales**, được biên soạn dưới thẩm quyền của **Lead QA Architect + Technical Director + Senior Systems Engineer + AI Governance Director**.

Trong một dự án hợp tác đa AI Agent (`Codex`, `Claude`, `ChatGPT`, `Antigravity`), nếu không có một bộ hiến pháp QA chuẩn mực và khắt khe, các AI rất dễ rơi vào ảo giác hoàn thành (*Completion Hallucination*) — tự ý phán kết *"Code đã chạy tốt"* chỉ sau khi viết xong cú pháp mà chưa hề trải qua kiểm nghiệm va chạm thực tế, dẫn đến crash game ngầm hoặc rò rỉ bộ nhớ nghiêm trọng.

Hiến pháp QA thiết lập 6 triết lý kiểm thử bất di bất dịch:

```text
• Quality is built in, not bolted on (Chất lượng phải được nhúng vào từng dòng code ngay từ đầu, không phải vá lỗi sau cùng)
• Shift-Left Testing Mandate           (Kiểm thử phải diễn ra sớm nhất có thể ngay tại tầng Prototype M0/M1)
• Zero Silent Failures                 (Nghiêm cấm nuốt lỗi; mọi ngoại lệ ngầm phải được bọc log Console minh bạch)
• Automated & Manual Synergy           (Kết hợp kiểm thử tự động GDevelop Dry-Runs với kiểm nghiệm cảm giác tay thực tế)
• Deterministic Verification           (Kiểm thử phải có tính lặp lại 100%, khóa seed cố định, không phụ thuộc may rủi)
• AI never self-certifies blindly      (AI cấm tự nhận "Done" nếu chưa qua Checklist kiểm định QA)
```

### 1.1. Chu trình Kiểm thử Nhúng Ngay (`Shift-Left Quality Pipeline`)
```text
┌────────────────────────────────────────────────────────────────────────┐
│               SHIFT-LEFT QUALITY & VERIFICATION PIPELINE               │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [Code / Event Generation] ──► AI Agent sinh ra Event Sheet mới.     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 2. [Static & Syntax Audit] ───► Kiểm tra chuẩn `04_Coding_Convention` │
│                                 và `05_Event_Architecture`.            │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. [5-Minute Smoke Test] ─────► Khởi chạy Boot ➔ Walk ➔ Plant ➔ Save   │
│                                 trong GDevelop Previewer.              │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
            ┌───────────────────────┴───────────────────────┐
            ▼ (Smoke Test PASSED)                           ▼ (Smoke Test FAILED)
┌───────────────────────────────────────┐   ┌───────────────────────────────────────┐
│ 4. [Integration & Stress Test]        │   │ 4. [Immediate Rejection & Debug Log]  │
│    ➔ Kiểm tra ranh giới Module        │   │    ➔ Log Console F3 + Báo cáo lỗi     │
│    ➔ Đo đạc Performance Contract      │   │    ➔ AI tự fix trước khi Handoff      │
└───────────────────────────────────────┘   └───────────────────────────────────────┘
```

---

## 2. Bug Severity Matrix & Action Gates (`Authoritative Error Hierarchy`)

Mọi lỗi phát hiện trong quá trình phát triển phải được phân loại ngay lập tức dựa trên **Ma Trận Mức Độ Nghiêm Trọng Lỗi (*Bug Severity Matrix*)** để xác định thẩm quyền gộp nhánh (`Merge?`), phát hành (`Ship?`) và SLA (*Service Level Agreement*):

| Mức Độ (`Severity`) | Định Nghĩa Kỹ Thuật & Tác Động Trải Nghiệm | Ví Dụ Tiêu Biểu Trong Plant Tales | Cam Kết Sửa Lỗi (`SLA`) | Quyền Merge (`Merge?`) | Quyền Ship (`Ship?`) |
| :---: | --- | --- | --- | :---: | :---: |
| 🚨 **S0 (CRITICAL)** | Crash game, đóng băng màn hình (`Freeze/Soft-lock`), mất hoặc hỏng file save của người chơi, vi phạm Core Engine. | Mất điện khi save làm file `save_slot_01.json` thành 0 byte; Nạp save cũ `v1.0` bị crash ra Desktop. | **Stop-the-line (Sửa ngay lập tức).** Cấm code tính năng mới nếu còn S0. | ❌ **NO** | ❌ **NO** |
| 🔴 **S1 (HIGH)** | Hỏng tính năng cốt lõi (`Core Loop`), rò rỉ RAM vượt `600 MB`, hoặc vi phạm `Performance Contract`. | Thu hoạch hoa không vào Satchel; NPC kẹt tường; CPU Frame Time vượt `12 ms/frame`. | **Trong vòng 24 giờ / Trước khi đóng Milestone mới.** | ❌ **NO** | ❌ **NO** |
| 🟡 **S2 (MEDIUM)** | Tính năng phụ lỗi logic, sai lệch thông số sinh trưởng nhỏ, lỗi lệch UI HUD gây khó chịu nhưng vẫn chơi được. | Hoa nở sớm 2 phút so với Data; Nút mở Nhật ký bị lệch 5px khi đổi độ phân giải. | **Trong Sprint / Trước ca Milestone M5 Polish.** | ⚠ **REVIEW** *(Cần Director duyệt)* | ❌ **NO** |
| 🟢 **S3 (LOW)** | Lỗi thẩm mỹ nhẹ, bóng rèm giật frame ngắn, âm thanh VFX chậm `50ms`, lỗi chính tả thoại NPC. | Thoại Florist gõ thiếu dấu phẩy; Ánh nắng hoàng hôn đổi màu hơi gắt. | **Gom lại sửa trong giai đoạn `M5 — Polish`.** | ✅ **YES** | ✅ **YES** |
| ⚪ **S4 (TRIVIAL)** | Đề xuất cải tiến nhỏ, vi chỉnh tọa độ icon trong Debug Overlay, comment trong Event Sheet chưa thẳng hàng. | Đổi màu chữ của Console Debug từ trắng sang xanh nhạt cho dễ nhìn hơn. | **Backlog (Sửa khi rảnh rỗi).** | ✅ **YES** | ✅ **YES** |

---

## 3. Performance Contract Mandate (`Hardware Budget as Code`)

Để bảo đảm trải nghiệm 60 FPS kiên định và ngăn chặn các thói quen lập trình ngốn tài nguyên, Hiến pháp QA chuyển hóa **Ngân Sách Hiệu Năng (`Performance Budget`)** thành một **Bản Hợp Đồng Hiệu Năng Có Tính Cưỡng Chế (*Performance Contract*)**.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   AUTHORITATIVE PERFORMANCE CONTRACT                   │
├───────────────────────────────────┬────────────────────────────────────┤
│ Chỉ Số Tài Nguyên (`Metric`)       │ Giới Hạn Hợp Đồng Cưỡng Chế (`Cap`)│
├───────────────────────────────────┼────────────────────────────────────┤
│ **Frame Rate (`FPS`)**            │ **`>= 60 FPS` kiên định** (Ổn định 99% thời gian test). │
│ **Memory Usage (`RAM`)**          │ **`<= 400 MB`** (Đỉnh cực đại không vượt `550 MB`).│
│ **CPU Frame Time**                │ **`<= 12.0 ms / frame`** (Để dành `4.6 ms` headroom cho OS).│
│ **Active Object Count**           │ **`<= 1,000 Objects`** đồng thời trên Scene.          │
│ **Particle Budget (`VFX`)**       │ **`<= 2,000 Particles`** đồng thời (Phải dùng Pool).  │
│ **Save File Size**                │ **`<= 250 KB`** cho `save_slot_01.json` (Để Cloud Sync).│
│ **Scene Load Time**               │ **`<= 1.5 Seconds`** từ lúc chuyển cảnh sang chơi được.│
└───────────────────────────────────┴────────────────────────────────────┘
```
❌ **Điều Khoản Vi Phạm Hợp Đồng (`Contract Violation SLA`):** Bất kỳ đoạn code Event nào làm CPU Frame Time vượt quá `12.0 ms` hoặc làm RAM leo thang qua `400 MB` lập tức **bị phân loại tự động là lỗi S1 (HIGH)**, mất quyền merge (`❌ Merge? NO`) và buộc phải tối ưu ngay lập tức trước khi làm bất kỳ việc gì khác.

---

## 4. Deterministic Testing Mandate (`100% Reproducible Environment`)

Một trong những nỗi ác mộng lớn nhất của AI và lập trình viên là debug các tình huống phụ thuộc vào yếu tố ngẫu nhiên (`Random Weather`, `Random Mutation`, `Random NPC Path`). Để tái hiện lỗi chính xác 100%, Hiến pháp QA quy định **Kiểm Thử Quyết Định Cố Định (`Deterministic Testing Mandate`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                  DETERMINISTIC DEBUG ENVIRONMENT SETUP                 │
├────────────────────────────────────────────────────────────────────────┤
│ Khi bật chế độ Kiểm Thử (`DEBUG_MODE = true` hoặc khi chạy QA Script):  │
│ ├── 1. [Fixed World Seed] ──────► Khóa cứng biến toàn cục `WORLD_SEED = 123456`.│
│ │                                  Mọi hàm ngẫu nhiên `Random()` đều phải      │
│ │                                  phát sinh cùng 1 chuỗi kết quả lặp lại!     │
│ ├── 2. [Fixed Weather Profile] ─► Khóa thời tiết ở trạng thái `Sunny`          │
│ │                                  hoặc `Spring Rain` cố định, cấm chuyển động ngẫu nhiên.│
│ ├── 3. [Fixed Time of Day] ─────► Khóa kim đồng hồ tại `09:00 AM` (630 min),   │
│ │                                  tắt tự động trôi thời gian nếu đang test logic tĩnh.│
│ └── 4. [Disable Random Events] ─► Tắt toàn bộ sự kiện đột xuất hay thương    │
│                                    nhân ghé thăm ngẫu nhiên.                  │
└────────────────────────────────────────────────────────────────────────┘
```
 Nhờ môi trường cố định này, nếu một AI Agent phát hiện lỗi tại bước di chuyển số 42, một AI khác mở project lên với `WORLD_SEED = 123456` chắc chắn tái hiện đúng 100% lỗi đó tại bước 42!

---

## 5. Golden Save Files Repository & Regression Testing (`Backward Compatibility Gate`)

Để kiểm nghiệm tính tương thích của dữ liệu Save khi game liên tục cập nhật phiên bản mới, hệ thống thiết lập **Kho Lưu Trữ Tệp Save Chuẩn Vàng (*Golden Save Files Repository*)** bên trong thư mục `Test Saves/`:

### 5.1. Cấu Trúc Kho Golden Saves (`Test Saves/ Hierarchy`)
```text
Test Saves/
├── day_1_fresh_start.json       ◄── Bản save ngày 1, nhà kính rỗng, đồ nghề cơ bản.
├── day_10_growing_garden.json   ◄── Bản save ngày 10, trồng 50 cây lily/lavender đa giai đoạn.
├── day_30_harvest_ready.json    ◄── Bản save ngày 30, toàn bộ hoa nở rộ sẵn sàng thu hoạch.
├── festival_bloom_day.json      ◄── Bản save ngay trước Lễ Hội Hoa Xuân (`Day 28 08:00 AM`).
├── late_game_500_flowers.json   ◄── Bản save mở rộng tối đa `20x20` với 500 chậu hoa (Stress test).
├── empty_inventory_test.json    ◄── Bản save Satchel 0 vật phẩm (kiểm thử rỗng kho).
└── full_inventory_test.json     ◄── Bản save Satchel 20 ô đều full 99 stack (kiểm thử tràn kho).
```

### 5.2. Đường Ống Kiểm Thử Tương Thích Vàng (`Golden Save Regression Pipeline`)
Trước mỗi lần đóng gói Milestone hoặc Merge Pull Request lớn, AI Agent chạy đường ống tự động:
```text
[Load Golden Save (`late_game_500_flowers.json`)]
                   │
                   ▼
[Execute Smoke Test 5-Min in Previewer (`Check Walk, Harvest, Time`)]
                   │
                   ▼
[Execute Save Command (`/save 1` ➔ Export new `save_slot_01.json`)]
                   │
                   ▼
[Schema & Checksum Comparison (`Compare old Golden vs New Saved JSON`)]
 ├── Không mất trường dữ liệu tĩnh hay thông số người chơi? (OK)
 ├── Checksum SHA-256 mới được tạo hợp lệ? (OK)
 └── Migration Engine chạy êm ái không có lỗi ngầm? (OK)
                   │
                   ▼
    ✅ GOLDEN REGRESSION APPROVED! Save hoàn toàn tương thích tới tiếp!
```

---

## 6. Smoke Test Protocol (`The 5-Minute Quick Gate`)

**Smoke Test** là bài kiểm tra nhanh 5 phút bắt buộc phải thực thi trước mỗi lần đóng gói ca làm việc hoặc trước khi gửi báo cáo Handoff:

### 6.1. Kịch Bản Smoke Test 5 Phút (`Mandatory 5-Min Script`)
1. **Boot Check (00:00 - 00:30):** Nhấn `Play` trong GDevelop. Kiểm tra game boot mượt từ `BootScene` sang `MainMenuScene` mà không hiện bảng lỗi đỏ.
2. **Garden Movement Check (00:30 - 01:30):** Vào `GreenhouseScene`. Di chuyển Mia bằng phím `WASD` đủ 8 hướng, chạy quanh luống đất, kiểm tra không bị xuyên qua mép tường.
3. **Core Planting & Watering Check (01:30 - 03:00):** Mở Satchel, chọn `Seed White Lily`, click vào ô đất `Grid(5,5)`. Hoa hiện hình mầm nhạt (`Stage 1`). Lấy bình tưới nước, click vào ô đất, màu đất chuyển ẩm (`Wet`).
4. **Time & Growth Check (03:00 - 04:00):** Nhấn phím F4 mở Console gõ `/fastforward 60` (tăng tốc 60 phút). Kiểm tra hoa chuyển sang `Stage 2`.
5. **Persistence Check (04:00 - 05:00):** Nhấn `F5` (Quick Save). Tắt hẳn GDevelop Preview. Mở lại Preview nhấn `Continue`. Kiểm tra chậu hoa `White Lily` nằm đúng `Grid(5,5)` ở `Stage 2` đất ẩm.

---

## 7. Integration Test Architecture (`Cross-Module Verification`)

Kiểm thử tích hợp tập trung vào ranh giới giao tiếp giữa các module theo chuẩn **Signal Bus** và **Module Contracts**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   INTEGRATION TEST PIPELINE (HARVEST LOOP)             │
├────────────────────────────────────────────────────────────────────────┤
│ [Action: Click Harvest Flower #542 (`White Lily Stage 3`)]             │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ 1. Kiểm tra `FlowerInstance` tự xóa khỏi Grid
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Signal: `EventBus.Emit("FlowerHarvested", {id: "white_lily", qty: 1})`]│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ 2. Kiểm tra `InventoryModule` bắt tín hiệu
            ┌───────────────────────┼───────────────────────┐
            ▼                       ▼                       ▼
┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐
│  [Inventory Check]   │ │  [Journal Check]     │ │  [Quest Check]       │
│ ➔ Satchel Slot #0    │ │ ➔ `JournalEntry`     │ │ ➔ `QuestProgress`    │
│    tăng từ Qty: 12   │ │    của `White Lily`  │ │    tiến độ tăng lên  │
│    lên Qty: 13 OK!   │ │    chuyển sang `true`│ │    `4/5` bông OK!    │
└──────────────────────┘ └──────────────────────┘ └──────────────────────┘
```

---

## 8. Prototype Validation (`GDD Alignment Gate`)

Để đảm bảo các cột mốc nguyên mẫu (`M0 -> M6`) không bị đi chệch hướng khỏi triết lý **Game Design Bible (`00_Game_Overview.md`)**, mỗi nguyên mẫu trước khi duyệt phải trải qua cổng kiểm định **Prototype Validation**:

| Cột Mốc (`Milestone`) | Triết Lý GDD Bảo Chứng | Bài Kiểm Tra Prototype Validation | Tiêu Chí Đạt Chuẩn (`Pass Standard`) |
| --- | --- | --- | --- |
| **M1: Vertical Slice** | *"Đang mở một cuốn sổ tay thực vật học, không phải dùng phần mềm."* | Kiểm tra nhịp điệu trồng và tưới hoa có tạo cảm giác bình yên (`Cozy`) không. | Nhịp di chuyển êm, âm thanh nước róc rách thanh nhã, không có con số nhảy chớp nhoáng gây stress. |
| **M2: Core Loop** | *"Mỗi bông hoa là một câu chuyện, tiêu bản là chứng tích."* | Kiểm tra cảm giác khi lật trang Nhật Ký và đọc thông tin loài hoa vừa thu hoạch. | Trang sách hiển thị rõ ràng, nét vẽ tay sắc sảo, không có cảm giác bảng biểu khô khan. |
| **M3: World Sim** | *"Thế giới trông như đang hít thở."* | Kiểm tra sự chuyển dịch màu sắc bầu trời và âm thanh gió khi chuyển sang buổi chiều mưa. | Lớp phủ mưa rào `Spring Rain` mượt, âm thanh BGM tự lùi sau tiếng mưa chéo góc (`Spatial`). |

---

## 9. F3 Debug Overlay Specification (`Live Telemetry HUD`)

Để hỗ trợ kiểm định hiệu năng thời gian thực mà không cần thoát ra Debugger của GDevelop, hệ thống tích hợp **Bảng Thông Tin Kỹ Thuật Thời Gian Thực (`F3 Debug Overlay HUD`)**, được bật/tắt bằng phím **F3**:

```text
================================================================================
[F3 DEBUG OVERLAY] - PLANT TALES ENGINE v1.2.0 (BUILD 20260716)
================================================================================
 FPS: 60 (Min: 59, Max: 61) | Frame Time: 8.4 ms | RAM: 245 MB / 400 MB Cap
 Current Scene: `GreenhouseScene` | Grid Size: 20x20 | Active Objects: 342 / 1000
 Singletons RAM: [GameMgr: OK] [EventBus: 12 Listeners] [SaveMgr: Dirty=false]
 TimeTicker: Day 14 | Season: Spring | Time: 10:30 AM (630 min) | Speed: 1.0x
 Weather Profile: `weather_spring_rain` | Moisture Global: 100% (Rain Active)
 Active Particles: 450 / 2000 | Audio Layers: BGM=0.8, Amb=0.6, SFX=1.0
 Session Metadata: Run #27 | Seed: 194820194 | Build: 0.4.2 | Schema: v1.0.0
================================================================================
```

---

## 9.B. Session Metadata & Telemetry Recording Specification (`M4.2A.0 Measurement Freeze`)

Để phục vụ cân bằng dựa trên bằng chứng dữ liệu (`Evidence-Driven Balancing`) thay vì cảm giác phỏng đoán (`Guesswork`), toàn bộ hệ thống nhật ký Telemetry cục bộ (`Local Telemetry / Session Log`) phải ghi nhận **Session Metadata Header** đi kèm với mọi sự kiện (`Money Earned, Harvest Count, Sleep Summary, Tool Used`):

### 1. Cấu Trúc Session Metadata Header (`Required Fields`)
Mỗi phiên chơi (`Session Run`) khi khởi chạy game bắt buộc tạo ra một chuỗi nhận diện độc nhất chứa 4 trường thông tin:
- **`run_id`:** Số thứ tự phiên chạy của người chơi hoặc Playtester (Ví dụ: `Run #27`).
- **`random_seed`:** Hạt giống số ngẫu nhiên của phiên (`Random Seed`, ví dụ: `194820194`). Bảo chứng tái hiện 100% xác suất thời tiết và lai tạo khi QA cần replay.
- **`build_version`:** Phiên bản build hiện tại của game (Ví dụ: `0.4.2`).
- **`schema_version`:** Phiên bản hợp đồng dữ liệu nội dung (Khóa cứng tại `1.0.0-STABLE`).

### 2. Định Dạng File Nhật Ký Telemetry (`Source/Data/Reports/session_telemetry.jsonl`)
Khi playtest, mỗi sự kiện quan trọng (`Daily Summary, Quest Complete, Economy Transaction`) được xuất dưới dạng JSON Lines (`JSONL`) chứa metadata chuẩn:
```json
{"run_id": 27, "seed": 194820194, "build": "0.4.2", "schema": "1.0.0", "event": "DAILY_SUMMARY", "day": 14, "gold_earned": 350, "flowers_harvested": 7, "avg_fps": 60.0}
{"run_id": 27, "seed": 194820194, "build": "0.4.2", "schema": "1.0.0", "event": "QUEST_COMPLETE", "quest_id": "quest_004_lavender_tea", "reward_gold": 180}
```

### 3. Workflow Tái Hiện Bug & Cân Bằng (`Deterministic Replay Workflow`)
Khi Playtester hoặc QA báo cáo một hiện tượng bất thường về kinh tế (ví dụ: *"Ngày 14 đột nhiên hết tiền không mua được hạt giống"* hoặc *"Tulip cho quá ít vàng"*), lập trình viên chỉ cần lấy thông số `Run #27` + `Seed: 194820194` nạp vào F4 Console hoặc cấu hình boot để tái hiện chính xác kịch bản 100% không sai lệch dù chỉ 1 Gold!

---

## 10. Developer Console Specification (`F4 In-Game Command Line`)

Bật/tắt bằng phím **F4**, **Developer Console** cung cấp giao diện dòng lệnh cho phép lập trình viên, QA và AI Agents giả lập các tình huống test khắc nghiệt trong vài giây:

| Câu Lệnh (`Command`) | Tham Số (`Arguments`) | Tác Dụng & Ví Dụ Thực Thi (`Execution Example`) |
| --- | --- | --- |
| `/give` | `<item_id> <qty>` | Cấp ngay lập tức vật phẩm vào Satchel: `/give item_seed_white_lily 50` |
| `/rain` | `<duration_sec>` | Kích hoạt ngay mưa rào trong số giây xác định: `/rain 180` |
| `/sun` | `None` | Ngắt mưa lập tức, trả bầu trời về trời nắng: `/sun` |
| `/time` | `<hour> <minute>` | Nhảy kim đồng hồ tới thời điểm cụ thể: `/time 20 00` (đổi sang đêm) |
| `/fastforward` | `<minutes>` | Tua nhanh thời gian sim sinh trưởng hoa: `/fastforward 120` (2 tiếng) |
| `/stage` | `<grid_x> <grid_y> <stage>`| Ép chậu hoa tại ô đất nhảy sang giai đoạn: `/stage 5 5 3` (nở ngay) |
| `/save` | `<slot_id>` | Ép lưu game thủ công xuống khe lưu xác định: `/save 1` |
| `/corruptsave` | `<slot_id>` | Giả lập phá hỏng file save để test tính năng khôi phục Checksum: `/corruptsave 1`|
| `/clear` | `None` | Xóa sạch màn hình Console F4: `/clear` |

---

## 11. AI QA Checklist (`Pre-Merge AI Verification`)

Trước khi tạo Handoff Report và merge code, mọi AI Agent (`Codex`, `Claude`, `ChatGPT`, `Antigravity`) phải thực hiện xong danh sách kiểm định QA chuyên biệt:

- [ ] **1. Null & Bounds Check:** Đã bọc kiểm tra ô đất tồn tại và item hợp lệ trước khi truy vấn thuộc tính chưa?
- [ ] **2. Polling Audit:** Đã mở Profiler xác minh không có lệnh `Check Collision Every Frame` trôi nổi chưa?
- [ ] **3. Save Dirty Audit:** Đã xác minh thay đổi trạng thái có đi qua `SaveManager.MarkDirty()` thay vì ghi đĩa trực tiếp chưa?
- [ ] **4. Memory Pool Audit:** Đã xác minh các đạn nước tưới và hạt VFX đều đi qua `Object Pool` chưa?
- [ ] **5. Golden Save Check:** Đã chạy đối chiếu với `Test Saves/late_game_500_flowers.json` không bị hỏng schema chưa?
- [ ] **6. Deterministic Seed Audit:** Đã kiểm tra không có hàm `Random()` trôi nổi khi bật `DEBUG_SEED = 123456` chưa?

---

## 12. Release Checklist (`Master Pre-Launch Gates`)

Trước khi đóng gói bản build chính thức `Release Candidate (RC)` để tung ra Milestone lớn hoặc gửi tới người chơi, toàn bộ project phải vượt qua cổng kiểm định **Master Release Checklist**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   MASTER PRE-LAUNCH RELEASE GATES                      │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [QA Test Suite Pass] ──────► 100% của 50 kịch bản test đều `Passed`.│
│                                 Zero lỗi S0 (Critical) & S1 (High).     │
├────────────────────────────────────────────────────────────────────────┤
│ 2. [48-Hour Stress Test] ─────► Chạy auto-sim 48 giờ liên tục không có │
│                                 lỗi Crash hay Memory Overflow (>400MB). │
├────────────────────────────────────────────────────────────────────────┤
│ 3. [Golden Save Compatibility]─► 100% file trong `Test Saves/` nạp     │
│                                 mượt mà và lưu lại chuẩn xác.          │
├────────────────────────────────────────────────────────────────────────┤
│ 4. [Production Cleaning] ─────► Xóa sạch folder `scratch/`, tắt lệnh   │
│                                 test nháp, đóng khóa Console F4/F3.    │
├────────────────────────────────────────────────────────────────────────┤
│ 5. [Architecture Audit] ──────► Đạt 100% Compliance Score với 10 Bibles.│
└────────────────────────────────────────────────────────────────────────┘
```

---

## 13. Exit Criteria Verification Protocol (`Milestone Sign-Off`)

Quy trình thẩm định và đóng một cột mốc (`Milestone M0 -> M6`) theo chuẩn **Exit Criteria Verification Protocol**:

```text
[AI Agent nộp code hoàn thành Milestone M1]
                   │
                   ▼
  [Chạy bộ Smoke Test & Golden Save Pipeline]
                   │
                   ▼
[Đối chiếu danh sách Exit Criteria của M1 tại `08_Prototype_Roadmap`]
 ├── ✓ Di chuyển 8 hướng mượt mà? (OK)
 ├── ✓ Trồng hoa & Tưới nước biến màu đất? (OK)
 ├── ✓ Hoa tự lớn qua Stage 1 -> 2 -> 3? (OK)
 └── ✓ 30-Minute Stability & Golden Save compatibility OK? (OK)
                   │
                   ▼
    ✅ MILESTONE M1 SIGNED-OFF & LOCKED!
    Khóa nhánh git, cho phép bước tiếp sang Milestone M2!
```

---

## 14. Known Issues Register (`Accepted Prototype Debt Table`)

Sổ đăng ký các lỗi và nợ kỹ thuật được phép tạm thời chấp nhận trong giai đoạn Prototype (`Known Issues Register`) để không gây chặn bước phát triển:

| Mã Lỗi (`ID`) | Tên Lỗi / Nợ Kỹ Thuật (`Issue Description`) | Mức Độ (`Severity`) | Lý Do Chấp Nhận Tạm Thời (`Reason for Acceptance`) | Cột Mốc Phải Fix (`Target Fix Milestone`) |
| --- | --- | :---: | --- | :---: |
| **KI-001** | Khi gõ `/fastforward 1440` lập tức, FPS bị giật ngắn xuống `45 FPS` trong `0.2s`. | 🟡 **S2** | Do `TimeTicker` tính toán gộp sinh trưởng cho 500 hoa trong 1 frame duy nhất. | **Milestone M5** (Chuyển sang xử lý chia tải `Time-slicing`). |
| **KI-002** | Bóng rèm cửa sổ nhà kính đôi khi bị đè lên sau lớp sprite nhân vật Mia nếu đứng sát mép. | 🟢 **S3** | Lỗi phân lớp Z-Order Y-sorting chưa tách nhánh riêng cho rèm cửa treo cao. | **Milestone M5** (Tinh chỉnh lại Z-Order layer chuẩn). |
| **KI-003** | Khôi phục Checksum từ file `.previous` (tầng 2) mất khoảng `1.2s` load màn hình đen ngắn.| 🟢 **S3** | Do parse tuần tự hai file JSON liên tiếp để đối chiếu hash SHA-256. | **Milestone M6** (Thêm màn hình loading tối ưu). |

---

## 15. Bug Report Template (`Authoritative Markdown Format`)

Khi lập trình viên hoặc AI Agent phát hiện lỗi trong quá trình test, buộc phải lập báo cáo lỗi theo **Biểu Mẫu Chuẩn Hóa (*Bug Report Template*)**:

```markdown
### 🐞 [BUG REPORT] BR-XXX: [Tên lỗi ngắn gọn rành mạch]
**Reported By:** [Antigravity / Codex / QA Tester]
**Date:** `2026-07-16` | **Severity:** `S0-CRITICAL` / `S1-HIGH` / `S2-MEDIUM`
**Found in Milestone / Build:** `Milestone M2 - Build 20260716`
**Affected Module:** `InventoryModule` & `SaveManager`

#### 1. Description & User Impact
- [Mô tả chính xác hành vi bị lỗi và tác động lên trải nghiệm người chơi]

#### 2. Steps to Reproduce (`Deterministic Steps with Seed`)
1. Khởi chạy game bật chế độ `DEBUG_SEED = 123456`, nạp Golden Save `day_10_growing_garden.json`.
2. Mở Satchel có chứa `Seed White Lily x99` (đầy stack).
3. Click vào ô đất `Grid(5,5)` để trồng 1 hạt giống.
4. Mở lại Satchel kiểm tra số lượng stack.

#### 3. Expected vs Actual Behavior
- **Expected:** Số lượng trong Satchel giảm xuống `98`, hoa xuất hiện trên ô `Grid(5,5)`.
- **Actual:** Số lượng trong Satchel vẫn giữ nguyên `99`, hoa vẫn xuất hiện (lỗi nhân bản item).

#### 4. Console F3/Debug Logs & Error Traces
```text
[InventoryModule] Item consumed: seed_white_lily, new_qty: 98
[SaveManager] MarkDirty triggered.
[Error Trace] InventorySlot update failed: StackOverflow guard rejected update.
```

#### 5. Proposed Root Cause & Suggested Fix
- **Root Cause:** Biến guard check trong `InventorySlot.Consume()` bị check ngược điều kiện.
- **Suggested Fix:** Đổi `if (qty <= MAX_STACK)` thành `if (qty > 0) qty--;`.
```

---

## 16. Test Case Template (`Standard Verification Scenario Format`)

Biểu mẫu chuẩn để viết kịch bản kiểm thử tự động hoặc kiểm thử thủ công (**Test Case Template**):

```markdown
### 🧪 [TEST CASE] TC-XXX: [Tên kịch bản kiểm thử]
**Test Category:** `Smoke Test` / `Integration Test` / `Regression Test`
**Target Module:** `FlowerSystem` & `WeatherModule`
**Prerequisites:** Game nạp ở `GreenhouseScene`, luống đất `Grid(10,10)` đang trồng `White Lily Stage 2` (Đất khô `Moisture = 0%`), `DEBUG_SEED = 123456`.

#### 1. Execution Steps
1. Mở Console F4 gõ lệnh `/rain 180` (kích hoạt mưa rào 3 phút).
2. Chờ 2 giây để hệ thống thời tiết phát Signal `WeatherChanged`.
3. Kiểm tra thông số `moisture_level` của `FlowerInstance #542` tại `Grid(10,10)`.

#### 2. Verification Criteria (`Pass/Fail Standard`)
- **Pass:** `FlowerInstance #542.moisture_level` tự động nhảy lên `100%`, sprite đất đổi sang màu `Wet Soil`.
- **Fail:** Độ ẩm vẫn giữ `0%` hoặc cần người chơi lấy bình tưới tay mới biến màu.

#### 3. Cleanup Routine
- Gõ lệnh Console F4 `/sun` để ngắt mưa, trả lại trạng thái thời tiết chuẩn.
```

---

## 17. Definition of Done (`The Universal Done Constitution`)

Một nhiệm vụ (`Task`), một thẻ Ticket hoặc một hệ thống chỉ được coi là **"HOÀN THÀNH CHÍNH THỨC" (*Definition of Done — DoD*)** khi và chỉ khi thỏa mãn trọn vẹn 10 bước hiến pháp sau theo chuẩn AAA Studio:

```text
┌────────────────────────────────────────────────────────────────────────┐
│             UNIVERSAL DEFINITION OF DONE (DoD) PIPELINE                │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [Code Implementation Done] ──► Code chạy chuẩn xác, tuân thủ 100%   │
│                                   `04_Coding` & `05_Event` Constitution.│
├────────────────────────────────────────────────────────────────────────┤
│ 2. [Code Review / Audit] ───────► Đã được kiểm duyệt tĩnh, không có    │
│                                   biến toàn cục hay God Sheet rác.      │
├────────────────────────────────────────────────────────────────────────┤
│ 3. [5-Minute Smoke Test Pass] ──► Vượt qua kịch bản Smoke 5 phút trong │
│                                   môi trường `DEBUG_SEED = 123456`.     │
├────────────────────────────────────────────────────────────────────────┤
│ 4. [Golden Save Regression] ────► Nạp và lưu thành công 100% file trong │
│                                   kho `Test Saves/` không hỏng schema.  │
├────────────────────────────────────────────────────────────────────────┤
│ 5. [Performance Contract OK] ───► Tuân thủ hợp đồng: `FPS >= 60`,      │
│                                   CPU `< 12ms`, RAM `< 400MB` (Zero S1).│
├────────────────────────────────────────────────────────────────────────┤
│ 6. [Persistence Verified] ──────► Đã qua `SaveManager.MarkDirty()`,    │
│                                   chạy thử reload save hoàn toàn khớp. │
├────────────────────────────────────────────────────────────────────────┤
│ 7. [Zero Console Errors] ───────► Log Console F3 hoàn toàn sạch sẽ,    │
│                                   không có cảnh báo ngầm (`Silent Fail`).│
├────────────────────────────────────────────────────────────────────────┤
│ 8. [Documentation Updated] ─────► Cập nhật `walkthrough.md`, chốt      │
│                                   IDs vào Authoritative Registry.      │
├────────────────────────────────────────────────────────────────────────┤
│ 9. [Handoff Report Submitted] ──► Đã xuất báo cáo Handoff 13 mục       │
│                                   chuẩn ADR, Risk & Rollback Strategy. │
├────────────────────────────────────────────────────────────────────────┤
│ 10. [Milestone Sign-Off Done] ──► Chốt trạng thái `Approved` bởi       │
│                                   Game Director / Lead Architect.      │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 18. Continuous Verification (`Automated Dry-Run Engine`)

Để tự động hóa việc bảo vệ chất lượng khi làm việc với Engine **GDevelop 5**, hệ thống tích hợp nguyên tắc **Kiểm Chứng Liên Tục (*Continuous Verification / Dry-Run Pipeline*)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   CONTINUOUS VERIFICATION PIPELINE                     │
├────────────────────────────────────────────────────────────────────────┤
│ [AI Agent Submits Event Sheet / JSON Schema Patch]                     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [CLI Dry-Run Engine Validation]                                        │
│ ➔ Chạy kiểm tra parse cú pháp JSON GDevelop tự động không cần mở GUI. │
│ ➔ Kiểm nghiệm tính hợp lệ của tất cả các biến toàn cục và tên Signal.  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
            ┌───────────────────────┴───────────────────────┐
            ▼ (Dry-Run PASSED OK)                           ▼ (Dry-Run FAILED!)
┌───────────────────────────────────────┐   ┌───────────────────────────────────────┐
│  ✅ PRE-FLIGHT APPROVED!              │   │  ❌ PRE-FLIGHT REJECTED!              │
│  Sẵn sàng chạy Previewer trên GUI.    │   │  Khóa ngay tức khắc. Báo lỗi dòng line│
└───────────────────────────────────────┘   └───────────────────────────────────────┘
```

---

## Appendix (`The 14 QA Commandments & Status`)

### Appendix A: The 14 QA Commandments (*14 Điều Luật Kiểm Thử Bất Biến*)
1. **Quality is built in, not bolted on.** *(Chất lượng phải nhúng vào code từ dòng đầu tiên).*
2. **Shift-left testing mandate.** *(Test ngay từ M0/M1, không chờ đến M6 mới test).*
3. **Zero silent failures.** *(Nghiêm cấm nuốt lỗi; mọi ngoại lệ phải log Console rõ ràng).*
4. **No merge / No ship on S0/S1 bugs.** *(Cấm merge và ship nếu còn tồn đọng lỗi S0 hay S1).*
5. **Performance contract is hard law.** *(Vi phạm `CPU > 12ms` hay `RAM > 400MB` là lỗi S1 cấm merge).*
6. **Deterministic seed is required.** *(Luôn bật `DEBUG_SEED = 123456` để tái hiện lỗi 100%).*
7. **Golden saves regression is sacred.** *(Luôn kiểm thử tương thích với kho `Test Saves/*.json`).*
8. **Smoke test before every handoff.** *(Luôn chạy Smoke Test 5 phút trước khi xuất báo cáo Handoff).*
9. **F3/F4 tools are mandatory.** *(Luôn duy trì F3 Debug Overlay và F4 Developer Console trơn tru).*
10. **Never self-certify blindly.** *(AI cấm tự nhận Xong nếu chưa qua AI QA Checklist).*
11. **Definition of Done is absolute.** *(Buộc phải đạt trọn vẹn 10 bước DoD mới đóng task).*
12. **Deterministic bug reports only.** *(Báo cáo lỗi phải có các bước tái hiện kèm Seed cố định).*
13. **Regression protection is inviolable.** *(Tính năng mới tuyệt đối không được làm gãy M0-M3 cũ).*
14. **AI strictly follows QA Constitution.** *(AI sinh code buộc phải tuân thủ 100% hiến pháp QA này).*

### Appendix B: Production Readiness Checklist & Status
- [x] Khóa 6 triết lý kiểm thử tối cao và chu trình `Shift-Left Quality Pipeline`.
- [x] Lập bảng `Bug Severity Matrix (S0 -> S4)` định lượng cổng hành động `Merge? / Ship?` chuẩn mực.
- [x] Khóa `Performance Contract Mandate` với điều khoản vi phạm tự động đánh lỗi S1 cấm merge.
- [x] Khóa lệnh `Deterministic Testing Mandate` (`DEBUG_SEED = 123456`, khóa thời tiết/thời gian).
- [x] Thiết lập kho `Golden Save Files Repository (Test Saves/)` và đường ống `Regression Pipeline`.
- [x] Thiết lập kịch bản 5 phút `Smoke Test Protocol` và đường ống `Integration Test`.
- [x] Khóa ma trận đối chiếu `Prototype Validation` và `Performance Budget` cứng.
- [x] Đặc tả hoàn chỉnh thông số kỹ thuật cho bảng `F3 Overlay` và dòng lệnh `F4 Console`.
- [x] Thiết lập `AI QA Checklist`, `Release Checklist` và quy trình `Exit Criteria Verification`.
- [x] Lập sổ đăng ký nợ kỹ thuật `Known Issues Register (KI-001 -> KI-003)`.
- [x] Chuẩn hóa biểu mẫu markdown cho `Bug Report Template` và `Test Case Template`.
- [x] Khóa 10 bước hiến pháp `Universal Definition of Done (DoD)` và `Continuous Verification`.

**Status: Approved**
*(Khóa hiến pháp kiểm thử và đảm bảo chất lượng toàn cục ở cấp độ hoàn hảo AAA. Sẵn sàng tiến sang Module 10: `10_Module_Architecture.md`).*
