# AI Coding Constitution & Studio Coding Standards

**Hiến pháp lập trình AI tối cao, bộ chuẩn mực viết code và quản trị mã nguồn cho dự án Plant Tales (AI Coding Constitution & Studio Coding Standards Document).**

---

## 1. Coding Philosophy

Tài liệu **Coding Convention (`04_Coding_Convention.md`)** được ban hành không phải như một sách giáo khoa hướng dẫn cú pháp lập trình thông thường, mà là **Hiến pháp Lập trình AI Tối cao (*AI Coding Constitution*)** của dự án **Plant Tales**, được thiết lập dưới thẩm quyền và tầm nhìn của **Senior Software Architect + Lead Gameplay Programmer + Lead Code Reviewer + AI Coding Standards Engineer**.

Mọi hệ thống AI Coding Agents (*Codex, Claude, ChatGPT, Gemini, Antigravity*) cùng lập trình viên con người khi sinh ra bất kỳ dòng code, custom behavior hay khối sự kiện GDevelop nào đều **bắt buộc phải đọc và tuân thủ tuyệt đối tài liệu này** trước khi thực thi.

Hiến pháp lập trình của **Plant Tales** xây dựng trên 8 triết lý kỹ thuật bất biến:

```text
• Readable over Clever        (Dễ đọc, minh bạch tối thượng cao hơn sự thông minh đánh đố)
• Simple over Smart           (Đơn giản, thẳng thắn cao hơn sự khôn ngoan rườm rà phức tạp)
• Consistency over Creativity (Thống nhất chuẩn mực cao hơn sự tự do sáng tạo cá nhân)
• Maintainability over Speed  (Khả năng bảo trì 5 năm cao hơn tốc độ viết code chớp nhoáng)
• Data Driven                 (Dữ liệu định đoạt logic, code chỉ làm nhiệm vụ đọc-thực thi)
• Prototype First             (Tạo hình nguyên mẫu nhanh trước, tối ưu kiến trúc core sau)
• No Magic                    (Không có con số bí ẩn hardcode, không biến toàn cục trôi nổi)
• No Hidden Logic             (Không logic ngầm, mọi hành vi phải thể hiện qua tên hàm/event)
```

### Giải Thích Sâu Về 8 Triết Lý Cốt Lõi
1. **Readable over Clever:** Một đoạn code có thể được rút gọn thành 1 dòng 10 toán tử ba ngôi (*Ternary operators*) siêu phàm, nhưng nếu 6 tháng sau lập trình viên hoặc AI khác nhìn vào mất 30 phút mới hiểu, đoạn code đó bị đánh giá là **code rác (*Garbage Code*)** và bị reject. Hãy viết code như thể người maintain tiếp theo là một kẻ cuồng nộ biết địa chỉ nhà bạn.
2. **Simple over Smart:** Luôn ưu tiên cấu trúc logic rõ ràng. Thay vì lồng ghép 5 tầng condition `If/Else nested`, hãy sử dụng kỹ thuật thoát sớm (`Early Exit / Guard Clauses`) để giữ luồng code phẳng (`Flat Control Flow`).
3. **Consistency over Creativity:** Nếu toàn bộ project đang dùng prefix `flower_` và `camelCase` cho biến cục bộ, AI không được phép tự sáng tạo dùng `Plant_` hay `snake_case` chỉ vì AI thích phong cách đó hơn. Sự thống nhất là hàng rào duy nhất chống lại sự hỗn loạn khi dùng đa AI.
4. **Maintainability over Speed:** Không bao giờ chấp nhận giải pháp "patch vội cho chạy được rồi tính sau" trong code core production. Một giải pháp tốn 2 giờ viết nhưng sạch sẽ, modular có giá trị gấp 10 lần giải pháp 15 phút nhưng để lại nợ kỹ thuật (*Technical Debt*).
5. **Data Driven:** Tuân thủ triết lý từ `03_Data_Architecture.md`: Logic tuyệt đối không hardcode thời gian lớn của hoa hay câu thoại NPC. Mọi thông số phải đọc từ Schema JSON tĩnh.
6. **Prototype First:** Phân định minh bạch giữa code làm nhanh cho Prototype (được dùng mock data) và code chuẩn Production (nghiêm cấm mọi placeholder và debug code).
7. **No Magic (`Strict Anti-Magic Number Rule`):** Cấm tuyệt đối viết hardcode như `health -= 25` hay `timer > 300`. Phải khai báo hằng số định danh rõ ràng `const BASE_HARVEST_DAMAGE = 25` hoặc `FLOWER_DEFAULT_BLOOM_TIME = 300`.
8. **No Hidden Logic:** Mọi tác động làm thay đổi trạng thái game (*State Mutation*) phải được thực hiện thông qua các hàm có tên gọi phản ánh đúng hành vi đó (ví dụ: `ConsumeWaterCapacity()`), không bao giờ âm thầm trừ tiền hay đổi biến bên trong một hàm getter như `GetFlowerName()`.

---

## 2. Naming Convention

Quy chuẩn định danh (*Authoritative Naming Convention Registry*) áp dụng cho mọi tầng kiến trúc từ mã nguồn, Event Sheet GDevelop, Scene cho đến file JSON và Database ID:

| Danh mục đối tượng | Định dạng chuẩn (`Authoritative Style`) | Cú pháp / Quy định tiền tố (`Prefix Rules`) | Ví dụ chuẩn xác hợp lệ (`REQUIRED`) | Ví dụ sai bị cấm tuyệt đối (`FORBIDDEN`) |
| --- | --- | --- | --- | --- |
| **Database IDs / Keys** | `snake_case` | Prefix theo domain (`flower_*, npc_*, item_*`) | `flower_white_lily`<br>`npc_mayor` | `WhiteLily`<br>`mayor_01` |
| **JSON Schema Fields** | `snake_case` | Toàn chữ thường, kết nối bằng `_` | `growth_stage`<br>`bloom_time_seconds` | `growthStage`<br>`BloomTime` |
| **Variables (Local/Scene)** | `camelCase` | Danh từ hoặc cụm danh từ mô tả trạng thái | `currentGrowthDelta`<br>`isPlayerWatering` | `current_growth`<br>`Flag1`<br>`temp` |
| **Constants (Hằng số)**| `UPPER_SNAKE_CASE` | Toàn chữ hoa, chỉ định giá trị cố định | `MAX_SATCHEL_SLOTS`<br>`DEFAULT_RAIN_CHANCE` | `maxSlots`<br>`RainChance` |
| **Functions / Actions** | `PascalCase` | Động từ + Danh từ (`Verb + Noun`) | `CalculateMutationRate()`<br>`WaterTargetFlower()` | `calcMut()`<br>`water()`<br>`do_stuff()` |
| **Event Sheets / Groups**| `PascalCase` | Mô tả trách nhiệm của khối sự kiện | `FlowerGrowthLogic`<br>`NPCDailySchedule` | `events1`<br>`growth_logic`<br>`main_loop` |
| **Scenes / Layouts** | `PascalCase + Scene` | Tên khu vực + hậu tố `Scene` | `BootScene`<br>`VillageScene`<br>`HouseScene` | `Boot`<br>`village_final`<br>`Scene1` |
| **GDevelop Objects** | `PascalCase` | Định danh thực thể hoặc Prefab | `FlowerBox`<br>`NPCInstance`<br>`WateringCan` | `flower_box`<br>`npc1`<br>`obj_tool` |
| **Custom Behaviors** | `PascalCase + Behavior`| Mô tả năng lực + hậu tố `Behavior` | `FlowerGrowthBehavior`<br>`GridSnapBehavior` | `growthBehavior`<br>`snap_logic` |
| **Systems / Modules** | `PascalCase + System` | Tên Domain + hậu tố `System` | `FlowerSystem`<br>`NPCSystem`<br>`WeatherSystem` | `flower_sys`<br>`PlantManager2` |
| **Global Managers** | `PascalCase + Manager` | Đúng 4 Singletons quy định trong `01` | `GameManager`<br>`AudioManager`<br>`SaveManager` | `InventoryManager`<br>`QuestManagerNew` |
| **Files & Folders** | `PascalCase` (Folders)<br>`snake_case` (Files)| Thư mục viết hoa chữ đầu, file viết thường | `Source/Systems/flower_system.json`<br>`Assets/UI/ui_hud_base.png` | `source/systems/FlowerSystem.json`<br>`assets/ui/HUD.png` |

---

## 3. Folder Responsibility (`Strict Directory Domain`)

Mỗi thư mục con bên trong `Source/` mang **đúng một trách nhiệm duy nhất (`Single Directory Responsibility`)**. Nghiêm cấm đặt nhầm file hay viết code xuyên thư mục:

```text
Source/
├── Systems/     ➔ CHỈ chứa logic cốt lõi điều phối domain (`FlowerSystem`, `NPCSystem`). Cấm chứa UI hay Scene.
├── Managers/    ➔ CHỈ chứa đúng 4 Global Singletons (`GameManager`, `AudioManager`, `SaveManager`, `SceneManager`).
├── Scenes/      ➔ CHỈ chứa cấu hình Layout và Scene tiêu chuẩn (`BootScene`, `VillageScene`). Cấm chứa logic tính toán.
├── UI/          ➔ CHỈ chứa logic & behavior điều khiển giao diện (`JournalUI`, `SatchelUI`). Cấm sửa đổi dữ liệu gốc.
├── Objects/     ➔ CHỈ chứa định nghĩa Prefabs & Entity cơ bản (`FlowerBox`, `NPCInstance`). Cấm chứa bảng Schema JSON.
├── Data/        ➔ CHỈ chứa các file Schema JSON tĩnh (`flower_definition_*.json`). Cấm chứa file script hay code runtime.
├── Events/      ➔ CHỈ chứa các External Event Sheets dùng chung (`GlobalSignals`, `CollisionRules`). Cấm chứa data tĩnh.
└── Utilities/   ➔ CHỈ chứa hàm tiện ích toán học/chuỗi độc lập (`MathHelper`, `DeltaTimer`). Cấm lưu state gameplay.
```

❌ **Phán quyết kỹ thuật:** Bất kỳ pull request nào ném file logic giao diện vào `Source/Systems/` hay ném file JSON vào `Source/Objects/` đều bị lập tức từ chối tích hợp (`Instant Rejection`).

---

## 4. Function Rules (`Strict Method Discipline`)

Một hàm (*Function / Method / Action*) được đánh giá là đạt chuẩn studio phải tuân thủ 4 quy luật:

1. **Single Responsibility:** Hàm chỉ làm đúng 1 việc. Nếu hàm có tên `HarvestAndSaveAndPlaySound()`, đó là thiết kế tồi. Hãy tách thành 3 hàm độc lập điều phối bởi Event Sheet.
2. **Length Constraints:** Một hàm không được vượt quá `40 dòng code` (hoặc `15 blocks event` trong GDevelop). Nếu vượt quá, buộc phải tách nhỏ thành các `Sub-actions` hoặc `External Functions`.
3. **Zero Unexpected Side Effects:** Hàm mang tên `GetFlowerRarity()` chỉ được phép trả về chỉ số Rarity, **tuyệt đối không được** ngầm định thay đổi độ ẩm của đất hay trừ tiền của người chơi bên trong đó.
4. **No Mutation Outside Domain:** Hàm thuộc `NPCSystem` không bao giờ được phép trực tiếp sửa đổi chỉ số của `FlowerInstance`. Phải giao tiếp thông qua Signal/Event.

### Comparative Code Table (`GOOD vs BAD Examples`)

| Tiêu chí | Ví dụ Code / Logic XẤU bị cấm (`BAD / REJECTED` — ❌) | Ví dụ Code / Logic TỐT chuẩn Studio (`GOOD / APPROVED` — ✅) |
| --- | --- | --- |
| **Logic & Guard Clauses** | ```text
// Lồng ghép sâu nested làm rối luồng code
If (flower != null) {
  If (flower.isWatered == true) {
    If (flower.growthStage < 4) {
      flower.growthStage += 1;
    }
  }
}
``` | ```text
// Thoát sớm Guard Clauses, phẳng và minh bạch
If (flower == null) return;
If (flower.isWatered == false) return;
If (flower.growthStage >= MAX_GROWTH_STAGE) return;

flower.growthStage += 1;
``` |
| **Magic Numbers & Side Effects** | ```text
// Hardcode con số bí ẩn 25, âm thầm trừ tiền khi tưới
function WaterPlant(target) {
  target.moisture += 25;
  player.gold -= 5; // Hidden side effect trái phép!
}
``` | ```text
// Hằng số minh bạch, đơn nhiệm đúng tên gọi
const WATERING_MOISTURE_BONUS = 25;

function ApplyWaterToPlant(targetInstance) {
  If (targetInstance == null) return;
  targetInstance.AddMoisture(WATERING_MOISTURE_BONUS);
}
``` |

---

## 5. Event Rules (GDevelop Friendly)

Để tối ưu cho môi trường **GDevelop 5 Event Sheet**, nơi rất dễ biến thành một "đống mì ống khổng lồ" nếu không kiểm soát, AI và lập trình viên phải tuân thủ 6 định luật tổ chức Event:

```text
┌────────────────────────────────────────────────────────────────────────┐
│               GDEVELOP 5 EVENT SHEET ARCHITECTURAL RULES               │
├───────────────────────────────────┬────────────────────────────────────┤
│ 1. Zero 1000-Line Event Sheets    │ Cấm tạo Event Sheet dài quá 150 blocks. Phải cắt nhỏ bằng `External Events`.│
│ 2. One Responsibility per Sheet   │ `VillageScene` chỉ link `External Events`: `Group_FlowerGrowth`, `Group_NPC`.│
│ 3. External Events Grouping       │ Mọi hệ thống lớn phải nằm trong file riêng tại `Source/Events/`.             │
│ 4. Zero Duplicate Logic           │ Cấm copy-paste khối va chạm ở 5 nơi. Phải gói vào `Custom Behavior/Link`.     │
│ 5. Depth Constraints (Max 3 Deep) │ Cấm lồng Event Sub-conditions quá 3 tầng (`Depth > 3` là bất hợp pháp).    │
│ 6. Explicit Event Groups          │ Mọi cụm Event phải bọc trong `Group` có tiêu đề `PascalCase` rõ ràng.         │
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 6. Variable Rules (`Scope Least Privilege`)

Dự án áp dụng nguyên tắc **Quyền truy cập tối thiểu (`Scope Least Privilege`)** cho mọi biến số. Khai báo biến ở phạm vi nhỏ nhất có thể để tránh rò rỉ bộ nhớ và xung đột dữ liệu:

| Phạm vi biến (`Variable Scope`) | Trường hợp được phép áp dụng (`Allowed Usage` — ✅) | Các hành vi bị cấm tuyệt đối (`Strictly Prohibited` — ❌) |
| --- | --- | --- |
| **Global Variable (`GameManager`)** | Chỉ dùng cho `GlobalClock`, `CurrentWeather`, `PlayerGold`, `ActiveLanguage` và `StoryFlags` toàn cục. | ❌ Cấm lưu tọa độ luống hoa hay trạng thái NPC vào Global Variable. Cấm tạo thêm Global trôi nổi. |
| **Scene Variable (`SceneScope`)** | Chỉ dùng cho trạng thái riêng của Scene đó (ví dụ: `activeSelectedTile`, `isJournalSpreadOpen`). | ❌ Cấm dùng Scene Variable để lưu dữ liệu cần mang sang Scene khác (phải qua `SaveManager`). |
| **Object Variable (`EntityScope`)** | Dùng cho thông số cá nhân của thực thể (ví dụ `FlowerBox.currentStage`, `NPCInstance.targetX`). | ❌ Cấm Object A trực tiếp đọc/sửa Object Variable của Object B mà không qua `Behavior Method`. |
| **Local / Scratch Variable** | Dùng cho tính toán tạm thời trong 1 Event block hoặc Function (ví dụ `tempDistance`, `loopIndex`). | ❌ Cấm dùng Local Variable để lưu trữ trạng thái qua frame tiếp theo (`Tick persistence`). |

---

## 7. Data Access Rules (`Strict Domain Decoupling`)

Để giữ ranh giới kiến trúc bất khả xâm phạm (`01_Project_Architecture.md`), các module giao tiếp với nhau theo **Luật cấm xâm phạm dữ liệu chéo (`Cross-Domain Data Prohibition`)**:

```text
┌───────────────────────────────┬────────────────────────────────────────────────────────────┐
│ MODULE / LAYER                │ DATA ACCESS CONSTRAINT (`LEAST PRIVILEGE PROHIBITION`)     │
├───────────────────────────────┼────────────────────────────────────────────────────────────┤
│ Gameplay Systems              │ ❌ KHÔNG ĐƯỢC sửa đổi Static Definitions (`FlowerDefinition`).│
│ (`FlowerSystem`, `NPCSystem`) │ ✅ CHỈ được sửa đổi Runtime Instances (`FlowerInstance`).    │
├───────────────────────────────┼────────────────────────────────────────────────────────────┤
│ Presentation & UI Layer       │ ❌ KHÔNG ĐƯỢC trực tiếp gọi hàm sửa đổi Gameplay State.    │
│ (`JournalUI`, `SatchelUI`)    │ ✅ CHỈ được đọc `GetStatus()` và phát `Signal Request`.    │
├───────────────────────────────┼────────────────────────────────────────────────────────────┤
│ Animation & VFX Layer         │ ❌ KHÔNG ĐƯỢC truy cập vào Save Layer hay ghi file JSON.   │
│ (`FlowerGrowthVisuals`)       │ ✅ CHỈ lắng nghe `OnFlowerBloomed` để kích hoạt Sprite/VFX.│
├───────────────────────────────┼────────────────────────────────────────────────────────────┤
│ Audio System                  │ ❌ KHÔNG ĐƯỢC truy vấn hoặc quan tâm đến `InventoryModule`.│
│ (`SoundscapeManager`)         │ ✅ CHỈ đọc tọa độ Player và mật độ hoa để trộn 7 tầng.     │
└───────────────────────────────┴────────────────────────────────────────────────────────────┘
```

---

## 8. Comment Standard (`Explain WHY, Not WHAT`)

Khẳng định triết lý comment đẳng cấp kỹ sư trưởng: **"Code sạch đã tự giải thích nó làm cái gì (`WHAT`). Comment chỉ sinh ra để giải thích tại sao lại chọn giải pháp đó (`WHY`), bối cảnh thiết kế hoặc cảnh báo ràng buộc kỹ thuật."**

❌ **Comment rác bị cấm (`Rejected Redundant Comments`):**
```text
// Tăng stage thêm 1
flower.growthStage += 1;

// Nếu cây đã tưới nước
If (flower.isWatered == true)
```

✅ **Comment chuẩn Studio (`Approved Technical Comments`):**
```text
// WHY: Sử dụng hệ số 1.5x thay vì 2.0x theo quy chuẩn cân bằng lại tại 02_Design_Bible
// để đảm bảo người chơi không thể thu hoạch hoa Rare trong cùng 1 chu kỳ ngày ban đầu.
flower.growthStage += (BASE_GROWTH_RATE * WATERED_MULTIPLIER);
```

### Bảng Chuẩn Tiền Tố Thẻ Comment (`Comment Tag Registry`)

| Thẻ tiền tố (`Tag`) | Ý nghĩa & Phạm vi áp dụng | Quy tắc bắt buộc kèm theo |
| --- | --- | --- |
| `// TODO:` | Đánh dấu tính năng/bước xử lý chưa hoàn thiện trong lúc Prototype. | Bắt buộc kèm tên người/AI chịu trách nhiệm và deadline (e.g., `// TODO(Codex): Connect to MemoryDB in Alpha phase`). |
| `// FIXME:` | Đánh dấu logic có bug tiềm ẩn hoặc xử lý tạm thời sai kiến trúc cần sửa gấp. | Bắt buộc phải ưu tiên xử lý trước khi merge vào nhánh production chính. |
| `// NOTE:` | Giải thích non-obvious rationale, quyết định thiết kế từ Game Design Bible. | Chỉ dùng cho các logic đặc thù dễ bị người khác refactor nhầm. |
| `// WARNING:` | Cảnh báo khu vực code nhạy cảm có liên kết sâu tới Save System hoặc C++ Engine core.| Bất kỳ ai sửa đổi khu vực này buộc phải chạy toàn bộ `09_Testing_Debugging.md`. |

---

## 9. Error Handling (`Zero Crash & Graceful Fallback`)

Trong một tựa game cozy ưu tiên sự bình yên thư thái, **mỗi cú crash game hay màn hình đen vì lỗi code là một tội ác tước đoạt sự thư giãn của người chơi**. AI và lập trình viên bắt buộc phải xử lý mọi ngoại lệ theo đạo luật **Zero Crash & Graceful Fallback**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      GRACEFUL ERROR RECOVERY MATRIX                    │
├───────────────────┬────────────────────────────────────────────────────┤
│ TÌNH HUỐNG LỖI    │ QUY TRÌNH XỬ LÝ & RECOVERY BẮT BUỘC (`REQUIRED`)   │
├───────────────────┼────────────────────────────────────────────────────┤
│ Missing Definition│ Nếu `GetDefinitionByID("flower_invalid")` trả null:│
│ (`Invalid ID`)    │ ➔ Log Warning ra Console: `[DataError] ID missing` │
│                   │ ➔ Tự động fallback về `flower_rose_common` để game │
│                   │    vẫn hiển thị được hoa mà không crash!           │
├───────────────────┼────────────────────────────────────────────────────┤
│ Missing Asset     │ Nếu Sprite `flower_rare_idle.png` chưa kịp import: │
│ (`Texture Error`) │ ➔ Tự động gán Sprite placeholder mặc định `error_32`│
│                   │ ➔ Ngăn game bị văng ra desktop.                    │
├───────────────────┼────────────────────────────────────────────────────┤
│ Corrupted Save    │ Nếu parse file `player_save.json` bị lỗi cú pháp:  │
│ (`JSON Error`)    │ ➔ Log Error: `[SaveSystem] Corrupted file detected`│
│                   │ ➔ Tự động đổi tên file lỗi thành `player_save.bak` │
│                   │ ➔ Nạp lại Default Initial State để cứu phiên chơi. │
└───────────────────┴────────────────────────────────────────────────────┘
```

❌ **Nghiêm cấm Silent Failures:** Không được bọc `try/catch` trống rỗng rồi âm thầm nuốt lỗi (`swallowing errors`) mà không ghi log, vì sẽ khiến Technical Director không thể tìm ra nguyên nhân khi test QA.

---

## 10. AI Coding Rules (`GREEN vs RED LIGHT`)

Bảng hiến pháp phân định ranh giới hành vi cho các AI Coding Agents (`Codex`, `Antigravity`, `Claude`, `ChatGPT`) khi trực tiếp viết mã nguồn, tạo Event Sheet hoặc chỉnh sửa cấu hình GDevelop project:

### 10.1. Đèn Xanh (`Authorized AI Coding Actions` — ✅ GREEN LIGHT)
- ✅ **Thêm Function / Sub-action mới:** Được tạo các hàm tiện ích hoặc khối xử lý mới bên trong đúng hệ thống chủ quản (`Source/Systems/flower_system.json`) nếu tuân thủ tuyệt đối giới hạn 40 dòng và `snake_case/camelCase/PascalCase`.
- ✅ **Thêm External Event Sheets:** Được tạo file nhóm sự kiện mới tại `Source/Events/` để kết nối vào `VillageScene` theo chuẩn `PascalCase`.
- ✅ **Thêm Objects / Prefabs mới:** Được định nghĩa thực thể GDevelop mới bên trong `Source/Objects/` nếu có cấu hình Pivot và Bounding box sát đất (`02_Folder_Convention.md`).
- ✅ **Refactor code tối ưu hiệu năng:** Được phép viết lại các khối logic cồng kềnh thành Guard Clauses hoặc Event Bus Signal để giảm tải CPU.

### 10.2. Đèn Đỏ (`Strictly Forbidden AI Coding Actions` — ❌ RED LIGHT)
- ❌ **Cấm rename Class / Behavior (`No Class Renaming`):** Không bao giờ được đổi tên `FlowerInstance` thành `PlantEntity` hay `ScheduleManager` thành `RoutineController`.
- ❌ **Cấm sửa đổi Schema / JSON (`No Schema Mutation`):** Cấm xóa field hay tự ý chèn thêm các thuộc tính rác vào `flower_definition_*.json` (`03_Data_Architecture.md`).
- ❌ **Cấm đổi ID hoặc Rename Data (`No ID Mutation`):** Cấm sửa `flower_white_lily` thành `flower_lily_01`.
- ❌ **Cấm tạo mới Folder hay di dời Asset (`No Folder Violation`):** Cấm tự ý sinh ra `Source/Scripts/` hay di chuyển Sprite ra ngoài `Assets/`.
- ❌ **Cấm duplicate logic (`No Copy-Paste Paste Engineering`):** Cấm copy 20 blocks event va chạm ở `VillageScene` sang `HouseScene`. Buộc phải đóng gói thành `External Event` dùng chung.
- ❌ **Cấm hardcode Magic Numbers (`No Magic Numbers`):** Cấm chèn trực tiếp các con số chỉ số sinh trưởng hay tọa độ cứng vào giữa khối sự kiện.

---

## 11. Performance Rules (`60 FPS Runtime Discipline`)

Để duy trì tốc độ khung hình chuẩn `60 FPS` mượt mà, AI và lập trình viên buộc phải tuân thủ 6 định luật tối ưu hiệu năng mã nguồn:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   RUNTIME OPTIMIZATION & PERFORMANCE RULES             │
├───────────────────────────────────┬────────────────────────────────────┤
│ 1. No Per-Frame Database Loops    │ Cấm dùng vòng lặp `For Each` quét toàn bộ DB mỗi frame (`Tick`).│
│                                   │ Buộc dùng `DeltaTimer` và `Screen Culling` để kiểm tra.    │
├───────────────────────────────────┼────────────────────────────────────┤
│ 2. Mandatory Object Pooling       │ Cấm `Create/Destroy` đối tượng liên tục lúc mưa rào hay thu│
│                                   │ hoạch. Phải dùng `Object Pool` (`Pool_WaterDrops`) tái sử dụng.│
├───────────────────────────────────┼────────────────────────────────────┤
│ 3. Lazy Loading & Caching         │ Cache các truy vấn nặng. Không query `InventoryModule` 60  │
│                                   │ lần/giây. Chỉ cập nhật lại khi nhận Signal `InventoryDirty`.│
├───────────────────────────────────┼────────────────────────────────────┤
│ 4. Event Driven over Polling      │ Ưu tiên kiến trúc phát Signal (`OnFlowerBloomed`) thay vì  │
│                                   │ viết điều kiện liên tục `If flower.stage == 4` ở mọi nơi.  │
├───────────────────────────────────┼────────────────────────────────────┤
│ 5. No Per-Frame UI Updates        │ UI HUD chỉ cập nhật text số tiền hoặc thời gian khi có sự  │
│                                   │ thay đổi thực tế (`Cache-on-Dirty`), cấm set text mỗi frame.│
├───────────────────────────────────┼────────────────────────────────────┤
│ 6. No Redundant Preloading        │ Chỉ preload các Sprite sheet thuộc Scene hiện tại bên trong│
│                                   │ `LoadingScene`. Giải phóng tài nguyên khi chuyển map lớn.  │
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 12. Prototype Rules (`Fast Iteration vs Production Standard`)

Để đảm bảo tốc độ phát triển thần tốc cho giai đoạn **Prototype** (`01_Project_Architecture.md`) mà không làm ô nhiễm bộ code sản xuất sau này, hiến pháp phân định 2 chế độ viết code minh bạch:

```text
┌───────────────────────────────────┬────────────────────────────────────┐
│      PROTOTYPE MODE (`Sandbox`)   │     PRODUCTION MODE (`Authoritative`)│
├───────────────────────────────────┼────────────────────────────────────┤
│ ✅ Được viết nhanh, ưu tiên luồng.│ ❌ Cấm viết code tạm/debug trôi nổi.│
│ ✅ Được dùng Mock Data tĩnh tạm.   │ ❌ Cấm hoàn toàn Mock Data/Placeholder.│
│ ✅ Được dùng Sprite hình vuông màu│ ❌ Cấm temporary asset chưa duyệt art.│
│    phác thảo làm placeholder.     │                                    │
│ ✅ Đặt toàn bộ trong `Prototype/`.│ ✅ BẮT BUỘC tuân thủ 100% 15 chương│
│                                   │    trong `04_Coding_Convention.md`.│
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 13. Pull Request Checklist (`Pre-Merge Quality Gate`)

Trước khi bất kỳ Pull Request hoặc thay đổi mã nguồn nào được cho phép merge vào nhánh `Source/` chính thức, **Lead Code Reviewer / Game Director** và AI phải xác minh qua 7 cổng kiểm soát chất lượng:

- [ ] **1. Naming Check:** Biến, hàm, Event Sheet và ID có tuân thủ đúng chuẩn `snake_case / camelCase / PascalCase` theo quy định tại Chương 2?
- [ ] **2. Single Responsibility Check:** Hàm/Event có bị phình to trên 40 dòng hay làm quá nhiều việc trái quyền hạn không?
- [ ] **3. No Duplicate & No Hardcode Check:** Đã loại bỏ hoàn toàn các con số bí ẩn (`Magic Numbers`) và không có khối logic nào bị copy-paste trùng lặp?
- [ ] **4. Schema & ID Safety Check:** Không có bất kỳ thay đổi trái phép nào lên cấu trúc `FlowerDefinition` hay `NPCData`?
- [ ] **5. Folder Integrity Check:** File mới tạo có nằm đúng vị trí độc tôn trong `Source/Systems/`, `Source/Events/` hay `Source/Data/`?
- [ ] **6. Comment WHY Check:** Các comment có giải thích đúng lý do `WHY` kèm các thẻ `// TODO:`, `// FIXME:`, `// NOTE:` chuẩn chỉnh?
- [ ] **7. Zero Crash Error Handling Check:** Đã có cơ chế Graceful Fallback khi gặp lỗi thiếu ID hay thiếu texture chưa?

---

## 14. AI Self Review Checklist (`AI Pre-Delivery Mandate`)

**Lệnh thực thi tối cao dành cho AI Coding Agents (Codex, Antigravity, Claude, ChatGPT):** Ngay sau khi sinh ra một đoạn code hoặc Event block mới, trước khi trả kết quả hiển thị cho Game Director, AI **buộc phải tự chạy checklist nội bộ 5 câu hỏi sau (`Self-Review Loop`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      AI SELF-REVIEW MANDATORY LOOP                     │
├────────────────────────────────────────────────────────────────────────┤
│ [ ] 1. Tôi có đang sử dụng đúng ID chuẩn prefix (`flower_*, npc_*`) không?│
│ [ ] 2. Tôi có vô tình thay đổi Schema tĩnh hoặc đổi tên class không?   │
│ [ ] 3. Tôi có tự ý tạo ra thư mục rác ngoài `Source/` hay `Assets/` không?│
│ [ ] 4. Tôi có viết hardcode con số bí ẩn hoặc để lại side effect không?│
│ [ ] 5. Tôi có làm gãy kiến trúc phân tầng Layer (`UI -> Gameplay`) không?│
├────────────────────────────────────────────────────────────────────────┤
│ ➔ NẾU CÓ BẤT KỲ CÂU TRẢ LỜI "CÓ" (VI PHẠM): LẬP TỨC TỰ SỬA LẠI CODE  │
│   TRƯỚC KHI XUẤT RA CHO GAME DIRECTOR!                                 │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 15. Immutable Coding Laws (`The 16 Supreme Commandments`)

Tổng hợp 16 điều luật hiến pháp bất di bất dịch của **Plant Tales**. Bất kỳ ai (Con người hay AI) vi phạm 1 trong 16 điều luật này, pull request sẽ lập tức bị từ chối:

1. **UI never owns gameplay.** *(UI không bao giờ nắm giữ hoặc sửa đổi logic gameplay).*
2. **Definition is immutable.** *(Schema tĩnh tải ban đầu là Read-Only bất biến tuyệt đối).*
3. **One responsibility per module.** *(Mỗi module, mỗi hàm chỉ làm đúng 1 nhiệm vụ).*
4. **No duplicate logic.** *(Không copy-paste khối sự kiện; dùng Custom Behavior hoặc External Event).*
5. **No arbitrary fields.** *(Cấm tự ý chèn thêm thuộc tính vào Schema tĩnh hay JSON save file).*
6. **No arbitrary IDs.** *(Khóa chính ID phải tuân thủ prefix `flower_*, npc_*` toàn chữ thường).*
7. **No magic numbers.** *(Mọi chỉ số hardcode phải biến thành hằng số `UPPER_SNAKE_CASE`).*
8. **No hidden logic.** *(Không sửa đổi trạng thái game ngầm bên trong một hàm Getter).*
9. **No unexpected side effects.** *(Hàm làm đúng tên gọi, không gây ảnh hưởng chéo ngoài domain).*
10. **Folders are immutable.** *(Tên 6 thư mục gốc và cấu trúc `Source/` là bất khả xâm phạm).*
11. **Git manages versions.** *(Không rác hậu tố `_final.png`. Git là công cụ quản lý version duy nhất).*
12. **Prototype first.** *(Phân định minh bạch code Prototype sandbox và code Production sạch).*
13. **Readable over clever.** *(Code minh bạch dẽ đọc cao hơn các thủ thuật code ngắn đố vui).*
14. **Zero crash tolerance.** *(Buộc phải có Graceful Fallback và Error Logging khi thiếu dữ liệu).*
15. **Event driven over polling.** *(Giao tiếp qua Signal/Event, cấm quét vòng lặp DB mỗi frame).*
16. **AI never invents architecture.** *(AI chỉ thực thi trên nền tảng Production Bible, nghiêm cấm AI tự sáng tạo kiến trúc mới).*

---

## Appendix A: Coding Laws Summary

- **Architecture Boundary:** `Player Input ➔ Interaction ➔ Gameplay System ➔ Database ➔ Save ➔ UI`.
- **Naming Standard:** `snake_case` (Data/Files), `camelCase` (Variables/Params), `PascalCase` (Classes/Functions/Events/Folders), `UPPER_SNAKE_CASE` (Constants).
- **AI Action Limit:** Allowed to add internal domain logic, forbidden to mutate Schema, ID, Folder, or Class names.

---

## Appendix B: AI Review Checklist

- [x] Đã khóa 8 triết lý lập trình tối cao (`Readable over Clever, Simple over Smart...`).
- [x] Đã lập bảng định danh `Authoritative Style` cho 12 nhóm thực thể từ biến đến GDevelop Object.
- [x] Đã định nghĩa trách nhiệm độc tôn của 8 thư mục con bên trong `Source/`.
- [x] Đã thiết lập luật hàm 40 dòng, Guard Clauses và bảng đối chứng `GOOD vs BAD Examples`.
- [x] Đã chuẩn hóa 6 quy tắc Event Sheet GDevelop 5 (`Zero 1000-line sheets, Max depth 3`).
- [x] Đã phân định ranh giới Least Privilege cho 4 phạm vi biến và cấm xâm phạm dữ liệu chéo (`Data Decoupling`).
- [x] Đã quy định comment `WHY` kèm thẻ `// TODO:`, `// FIXME:`, `// NOTE:`, `// WARNING:`.
- [x] Đã thiết lập ma trận Graceful Error Recovery chống crash game và Silent fail.
- [x] Đã ban hành bảng `GREEN vs RED LIGHT` cho AI, 6 luật hiệu năng `60 FPS` và phân định Prototype vs Production.
- [x] Đã khóa 7 bước `Pull Request Checklist`, vòng lặp tự kiểm 5 câu hỏi `AI Self Review` và 16 luật bất di bất dịch `Immutable Coding Laws`.

---

## Appendix C: Production Readiness Checklist & Status

**Status: Approved**
*(Khóa hiến pháp lập trình AI toàn cục. Sẵn sàng tiến sang Module 05: `05_Event_Architecture.md` theo đúng lộ trình tinh chỉnh).*
