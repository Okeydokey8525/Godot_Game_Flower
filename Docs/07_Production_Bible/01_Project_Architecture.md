# Project Architecture & Technical Blueprint

**Tài liệu kiến trúc kỹ thuật tổng thể, quy tắc phân lớp và bản thiết kế hệ thống phần mềm cấp studio cho dự án Plant Tales (Project Architecture Blueprint Document).**

---

## 1. Project Architecture Philosophy

Tài liệu **Project Architecture (`01_Project_Architecture.md`)** đóng vai trò là hiến pháp kiến trúc kỹ thuật (*Technical Constitution*) của **Plant Tales**, được biên soạn từ góc nhìn tối cao của **Technical Director + Lead Programmer**. 

Mọi dòng mã nguồn, mọi cấu trúc Event Sheet trong GDevelop và mọi module được xây dựng bởi **Codex, Antigravity hoặc lập trình viên con người** bắt buộc phải trả lời trọn vẹn câu hỏi: **"Chúng ta có thể lập tức xây dựng hệ thống mà không cần phải phỏng đoán bất kỳ chi tiết kiến trúc nào không?"**

Kiến trúc phần mềm của **Plant Tales** tuân thủ tuyệt đối 6 triết lý cốt lõi:

```text
• Modular Design          (Thiết kế dạng mô-đun độc lập, không dính chùm)
• Single Responsibility   (Đơn nhiệm: mỗi class/behavior chỉ làm đúng 1 nhiệm vụ)
• Data Driven             (Dữ liệu định đoạt hành vi, logic chỉ đọc dữ liệu)
• Event Driven            (Giao tiếp qua sự kiện, không gọi hàm vòng chéo)
• AI Friendly             (Minh bạch, chuẩn hóa tuyệt đối để AI đọc-hiểu 100%)
• Scalable                (Dễ dàng mở rộng hàng trăm tính năng mà không đập đi làm lại)
```

### Các Định Luật Kỹ Thuật Bất Biến (*Immutable Technical Laws*)
1. **Every gameplay feature must exist as an independent module.** *(Mọi tính năng gameplay phải tồn tại dưới dạng một mô-đun độc lập, có ranh giới rõ ràng).*
2. **No gameplay logic should depend directly on asset folders or texture names.** *(Không một dòng logic gameplay nào được phép phụ thuộc trực tiếp vào đường dẫn thư mục hay tên file hình ảnh).*
3. **Assets are replaceable. Data is authoritative. Logic reads data.** *(Tài nguyên hình ảnh/âm thanh có thể thay thế bất cứ lúc nào. Dữ liệu tĩnh JSON/Schema là chân lý tối cao. Logic gameplay chỉ có vai trò đọc và thực thi theo dữ liệu).*
4. **UI never owns gameplay.** *(Giao diện người dùng tuyệt đối không nắm giữ logic hoặc trạng thái gameplay. UI chỉ phản ánh trạng thái từ hệ thống core và phát đi yêu cầu người dùng).*

---

## 2. Layer Architecture

Hệ thống mã nguồn và thực thi runtime của **Plant Tales** được tổ chức theo mô hình phân tầng một chiều nghiêm ngặt (*Strict One-way Execution Layer Hierarchy*). Luồng điều khiển và phụ thuộc kỹ thuật bắt buộc phải tuân theo trật tự từ trên xuống dưới:

```text
┌────────────────────────────────────────────────────────┐
│  1. Player Input Layer (Bàn phím, Chuột, Controller)   │
└───────────────────────────┬────────────────────────────┘
                            │ (Tín hiệu điều khiển raw)
                            ▼
┌────────────────────────────────────────────────────────┐
│  2. Interaction Layer (Raycast, Bounding Box, Trigger) │
└───────────────────────────┬────────────────────────────┘
                            │ (Thao tác đã xác thực: e.g., WaterPlant)
                            ▼
┌────────────────────────────────────────────────────────┐
│  3. Gameplay System Layer (Flower System, NPC System)  │
└───────────────────────────┬────────────────────────────┘
                            │ (Đọc cấu hình / Tham chiếu chỉ số)
                            ▼
┌────────────────────────────────────────────────────────┐
│  4. Database Layer (JSON Schemas, FlowerDefinition)    │
└───────────────────────────┬────────────────────────────┘
                            │ (Ghi nhận thay đổi trạng thái bền vững)
                            ▼
┌────────────────────────────────────────────────────────┐
│  5. Save Layer (SaveManager, State Serialization)      │
└───────────────────────────┬────────────────────────────┘
                            │ (Phát Event thông báo cập nhật giao diện)
                            ▼
┌────────────────────────────────────────────────────────┐
│  6. Presentation & UI Layer (HUD, Journal, Audio, VFX) │
└────────────────────────────────────────────────────────┘
```

### Nghiêm Cấm Vi Phạm Phân Tầng (`Prohibited Layer Violations`)
❌ **Tuyệt đối nghiêm cấm kiến trúc đảo ngược hoặc gọi chéo bất hợp pháp như sau:**
```text
Player Input ➔ UI Button ➔ Gameplay State Mutation ➔ Save System
```
*Lý do cấm:* Nếu cho phép UI (Layer 6) trực tiếp sửa đổi trạng thái cây trồng hay gọi Save System, khi chúng ta thay đổi giao diện Bloom Journal hoặc làm lại menu, toàn bộ logic gameplay và dữ liệu save file sẽ bị gãy đổ lập tức. UI chỉ được phép gửi **Event Request** lên Gameplay System Layer.

---

## 3. Module Architecture

Toàn bộ logic trò chơi được chia cắt gọn gàng thành 8 module chức năng độc lập (*Independent Domain Modules*). Mỗi module đóng gói trọn vẹn dữ liệu, hành vi (*Custom Behaviors*) và sự kiện riêng biệt:

| Tên Module | Phạm vi trách nhiệm cốt lõi (*Domain Responsibility*) | Cấu trúc dữ liệu chủ quản (`Single Source of Truth`) |
| --- | --- | --- |
| **Flower Module** | Quản lý vòng đời thực vật: gieo hạt, đếm thời gian phát triển, tính toán lai tạo di truyền và thu hoạch | `FlowerDefinition`, `FlowerInstance` |
| **NPC Module** | Quản lý cư dân: chu kỳ di chuyển theo lịch trình, máy trạng thái (*State machine*), hội thoại và độ thân thiện | `NPCData`, `ScheduleManager`, `RelationshipData` |
| **Inventory Module** | Quản lý túi đồ (*Satchel*): lưu trữ hạt giống, nông cụ, hoa đã thu hoạch, tính toán giới hạn ô chứa | `InventorySlot`, `ItemDefinition` |
| **Quest Module** | Quản lý nhiệm vụ và yêu cầu từ cư dân: theo dõi điều kiện hoàn thành, trao phần thưởng tiến trình | `QuestData`, `QuestCondition` |
| **Festival Module** | Quản lý sự kiện Lễ hội Hoa: tính giờ đếm ngược, chấm điểm chậu hoa trưng bày và kích hoạt nghi lễ | `FestivalConfig`, `ContestSubmission` |
| **Weather Module** | Quản lý thời tiết toàn cục (*Global Weather System*): mưa, nắng, gió bão và chuyển giao mùa vụ | `WeatherState`, `SeasonalTimer` |
| **Journal Module** | Quản lý sổ tay **Bloom Journal**: mở khóa trang bách thảo, lưu trữ **Pressed Memories** và bưu thiếp | `JournalPage`, `PressedMemory` |
| **Audio Module** | Quản lý hệ sinh thái thính giác: hòa âm 7 tầng, ducking BGM và âm thanh vi mô dàn nhạc thực vật | `AudioLayerConfig`, `SoundscapeManager` |

---

## 4. Dependency Rules

Để ngăn chặn thảm họa "mì ống" (*Spaghetti dependencies*) nơi các hệ thống gọi vòng tròn lẫn nhau dẫn đến treo game hoặc rò rỉ bộ nhớ, **Plant Tales** thiết lập quy tắc đồ thị phụ thuộc một chiều (*Strict Directed Acyclic Graph — DAG*):

```text
Flower Database (Nguồi dữ liệu gốc authoritative)
       │
       ▼
Flower Instance (Thực thể hoa trên đất)
       │
       ├─────────────────────────────────┐
       ▼                                 ▼
Inventory Module                  Journal Module
       │                                 │
       ▼                                 ▼
Quest Module                      Pressed Memories
```

### Các Quy Tắc Chi Phối Phụ Thuộc (`Strict Dependency Constraints`)
- **Flower luôn là Source Authoritative:** `Flower Module` không bao giờ biết đến sự tồn tại của `Inventory Module`, `Journal Module` hay `Quest Module`. Nó chỉ làm nhiệm vụ phát triển cây và ném ra sự kiện `OnFlowerBloomed` hoặc `OnFlowerHarvested`.
- **Journal không được phép sửa đổi Flower:** `Journal Module` có quyền **đọc** dữ liệu từ `FlowerInstance` và `FlowerDefinition` để hiển thị trạng thái đã khám phá, nhưng **nghiêm cấm tuyệt đối** việc `Journal Module` gọi hàm hay sửa đổi bất kỳ chỉ số sinh trưởng nào của luống hoa.
- **Quy tắc trôi xuôi (`Downstream Only`):** Các module tầng dưới (`Quest`, `Journal`) lắng nghe và phản ứng với các sự kiện từ module tầng trên (`Flower`, `NPC`), tuyệt đối không có chiều ngược lại.

---

## 5. Data Flow Architecture

Minh họa chuẩn xác luồng dữ liệu độc quyền và duy nhất cho một hành động gameplay tiêu biểu — **Người chơi tiến hành tưới nước cho một luống hoa (`Watering a Plant`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│ 1. [Player] Nhấn phím thao tác (Action Key / Click) tại ô đất          │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 2. [Interaction Layer] Kiểm tra Bounding Box, xác thực Player đang cầm  │
│    Bình tưới nước (`WateringCan`) và ô đất có `FlowerInstance` hợp lệ  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Giao tiếp qua Function call)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. [Flower System Layer] Gọi `FlowerInstance.Water()`:                 │
│    - Kiểm tra `IsWatered == false`                                     │
│    - Cập nhật trạng thái: `IsWatered = true`, `GrowthMultiplier = 1.5` │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 4. [Save Layer] `SaveManager` ghi nhận dirty state cho `FlowerInstance`│
│    vào bộ đệm bộ nhớ tạm (`Memory Cache`) chờ chu kỳ Serialize         │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát Event: `OnFlowerWatered`)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 5. [Animation & VFX Layer] Lắng nghe Event `OnFlowerWatered`:          │
│    - Đổi Sprite đất sang màu ẩm ướt (`wet_soil.png`)                   │
│    - Kích hoạt VFX hạt nước li ti `vfx_water_drops`                    │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát Audio Hook)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 6. [Audio Layer] Phát SFX `sfx_tool_watering_can_pour_loop.wav`        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Scene Architecture

Hệ thống Scene trong GDevelop 5 được quy hoạch cực kỳ kỳ luật. Nghiêm cấm tuyệt đối tình trạng tạo rác scene nháp tràn lan trong project thực tế như `Village1`, `Village2`, `VillageTest`, `VillageFinal`, `VillageFinal2_Copy`.

Toàn bộ vòng đời trò chơi chỉ luân chuyển qua **7 Scene tiêu chuẩn chính thức**:

```text
[Boot] ➔ [Main Menu] ➔ [Loading] ➔ [Village] ◄─ (Chuyển tiếp) ─► [House / Glasshouse]
                                      │
                                      ▼
                             [Festival / Event] ➔ [Credits]
```

| Tên Scene | Định nghĩa & Nhiệm vụ độc quyền | Danh sách External Layouts / Layers đi kèm |
| --- | --- | --- |
| **Boot** | Scene khởi động nhấp nháy 0.5s: Khởi tạo Singleton Managers, load `GlobalConfig`, parse JSON Schemas và chuyển sang Main Menu | `None` (Zero visual assets) |
| **Main Menu** | Màn hình tiêu đề: Xử lý New Game, Continue, Options, và hiển thị hoạt hình gió thổi qua thảm cỏ | `UI_TitleLayer`, `BackgroundLayer` |
| **Loading** | Scene đệm chuyển tiếp: Hiển thị thanh tải trang Bloom Journal, giải phóng bộ nhớ cũ và nạp tài nguyên scene mới | `UI_LoadingLayer` |
| **Village** | **Main Overworld Scene:** Toàn bộ thị trấn, vườn hoa ngoài trời, quảng trường, rừng thạch tùng và mạng lưới NPC | `Ground`, `Foliage`, `Objects`, `Roof`, `Collision`, `UI_HUD` |
| **House / Glasshouse** | **Interior Scene:** Bên trong nhà Mia, Nhà kính kính mờ, Thư viện và Quán trà thảo mộc (Load qua External Layout) | `Interior_Base`, `Interior_Objects`, `UI_HUD` |
| **Festival** | Scene đặc biệt đêm Lễ hội Hoa: Quảng trường được trang hoàng ruy-băng, luống hoa trưng bày và đám đông NPC | `Festival_Ground`, `Festival_Lights`, `UI_Contest` |
| **Credits** | Màn hình tri ân và danh sách phát triển sau khi hoàn thành cốt truyện lớn | `UI_CreditsScroll` |

---

## 7. Singleton & Global Manager Policy

Để chống lại căn bệnh trầm kha của lập trình AI — **"Sự bùng nổ Manager" (*Manager Proliferation*)** nơi AI tự ý sinh ra hàng tá class quản lý thừa thãi như `FlowerManager2`, `InventoryManagerFinal`, `QuestManagerNew`, **Plant Tales** thiết lập luật sắt:

> **Chỉ được phép tồn tại đúng 4 Global Singleton Managers toàn cục trong suốt vòng đời dự án.**

```text
┌──────────────────────────────────────────────────────────────┐
│                  GLOBAL AUTHORITATIVE MANAGERS               │
├─────────────────┬─────────────────┬───────────────┬──────────┤
│ 1. GameManager  │ 2. AudioManager │ 3. SaveManager│4. Scene  │
│                 │                 │               │  Manager │
└─────────────────┴─────────────────┴───────────────┴──────────┘
```

1. **`GameManager` (Global State Hub):** Quản lý chu kỳ thời gian trong ngày (`Day/Night clock`), thời tiết hiện tại (`Global Weather`), và cờ sự kiện cốt truyện (`Story Flags`).
2. **`AudioManager` (Soundscape Hub):** Quản lý bộ trộn 7 tầng âm thanh, theo dõi vị trí nhân vật để tự động Ducking BGM và kích hoạt dàn nhạc thực vật.
3. **`SaveManager` (Serialization Hub):** Duy nhất có quyền đọc/ghi dữ liệu vào Local Storage hoặc file JSON, quản lý bộ nhớ tạm và checksum tự động save mỗi đêm ngủ.
4. **`SceneManager` (Transition Hub):** Điều phối việc chuyển đổi giữa `Village ◄─► House`, quản lý hiệu ứng fade-in/fade-out màn hình và truyền tải dữ liệu giữa các scene.

❌ **Nghiêm cấm tạo thêm Global Singleton mới:** Mọi logic quản lý hoa hay NPC phải nằm bên trong `Flower Module` hay `NPC Module` dưới dạng **Scene-scoped System/Behaviors**, tuyệt đối không biến chúng thành Global Singleton lơ lửng ngoài scene.

---

## 8. Event-Driven Architecture

Để đảm bảo khả năng mở rộng tối đa, hệ thống sử dụng kiến trúc điều phối hoàn toàn qua sự kiện đứt đoạn (*Decoupled Event propagation*). Khi một sự kiện gameplay quan trọng xảy ra, module gốc chỉ việc phát đi một **Signal / Global Event**, và các module quan tâm sẽ tự động lắng nghe để phản ứng:

```text
                               ┌─► [NPC Module]: Cư dân kinh ngạc, gửi lời chúc mừng
                               │
                               ├─► [Journal Module]: Mở khóa trang `flower_rose_perfect`
                               │
[Flower Module]                ├─► [Pressed Memories]: Kiểm tra điều kiện mở khóa ký ức ông
Phát Signal: `FlowerBloomed` ──┤
                               ├─► [Quest Module]: Cập nhật tiến trình nhiệm vụ `grew_5_roses`
                               │
                               ├─► [Festival Module]: Cộng +50 điểm vào quỹ điểm trưng bày
                               │
                               └─► [Audio Module]: Phát vi âm `sfx_flower_bloom_perfect_chime`
```

### Lợi Ích Cực Đại Cho Codex / AI
Khi Codex viết thêm một tính năng mới (ví dụ: `Museum Module`), Codex **không cần mở code của `Flower Module` ra để sửa hoặc chèn hàm gọi viện bảo tàng vào**. Codex chỉ cần cho `Museum Module` lắng nghe Signal `FlowerBloomed` và tự động cập nhật mẫu vật. Zero xung đột mã nguồn!

---

## 9. Performance & Optimization Rules

Bộ quy tắc tối ưu hiệu năng bắt buộc nhằm đảm bảo game chạy mượt mà ở `60 FPS` trên mọi cấu hình máy tính và thiết bị di động:

- **No Full-Array Scanning Every Frame (`Strict Tick Prohibition`):**
  - Nghiêm cấm tuyệt đối việc sử dụng vòng lặp `For each flower in scene` bên trong khối sự kiện `Always / Every Frame (Tick)`.
  - *Giải pháp chuẩn:* Các luống hoa sử dụng cơ chế **Delta-time Timer / Timestamp comparison**. Chỉ tính toán sinh trưởng khi người chơi bước vào tầm nhìn (`Screen Culling / Camera Bounds`) hoặc cập nhật 1 lần mỗi `1.0 giây` thực tế.
- **No Unthrottled Particle Spawning (`VFX Cap Rules`):**
  - Tuân thủ `Quiet Effects Philosophy (`07_Animation.md`)`: Giới hạn tối đa `50 particles` đồng thời cho toàn bộ màn hình. Nghiêm cấm spawn particle vô tận trong vòng lặp va chạm mà không có cờ `Trigger Once`.
- **No Runtime Texture Loading (`Preload Strategy`):**
  - Toàn bộ Sprite sheet của luống hoa và NPC trong khu vực phải được nạp sẵn vào bộ nhớ GPU ngay trong `Loading Scene`. Nghiêm cấm đọc file từ ổ cứng trong lúc người chơi đang di chuyển.
- **No Frequent Inventory Polling (`Cache-on-Dirty`):**
  - Giao diện túi đồ không được query danh sách item 60 lần/giây. Chỉ cập nhật lại UI khi `Inventory Module` phát sự kiện `OnInventoryMutated`.

---

## 10. AI Collaboration Rules

Bộ hiến pháp hành vi dành riêng cho AI Coding Agents (Codex, Antigravity) khi tham gia thao tác trực tiếp vào cấu trúc project GDevelop và mã nguồn:

### 10.1. Quyền Hạn Được Phép (`Authorized Actions` — ✅ GREEN LIGHT)
- ✅ **Thêm Function / Custom Behavior mới:** Bên trong phạm vi của một module hiện hữu (ví dụ: thêm behavior `CalculateGeneticMutation()` vào `Flower Module`).
- ✅ **Thêm Scene mới / External Layout mới:** Tuân thủ danh sách Scene tiêu chuẩn hoặc bổ sung phòng nội thất mới vào `House Scene`.
- ✅ **Thêm UI Components & Layouts:** Tạo thêm các bảng thông báo hoặc trang mới trong Bloom Journal đúng quy chuẩn `Botanical UI`.

### 10.2. Cấm Địa Kỹ Thuật (`Strictly Forbidden Actions` — ❌ RED LIGHT)
- ❌ **Không đổi Schema / JSON Structure:** Cấm tự ý sửa đổi, đổi tên hay xóa các thuộc tính trong `FlowerDefinition`, `NPCData`, `PressedMemory`.
- ❌ **Không đổi Class / Behavior Names:** Cấm đổi tên `FlowerInstance` thành `PlantObject` hay `ScheduleManager` thành `RoutineController`.
- ❌ **Không đổi cấu trúc Folder (`02_Folder_Convention.md`):** Cấm tự ý di dời thư mục `Assets/Flowers/` sang chỗ khác hay tạo thêm thư mục rác `Scripts_Temp/`.
- ❌ **Không Rename Data ID:** Cấm sửa đổi `flower_rose_common` thành `rose_01` trong bất kỳ tình huống nào.

---

## 11. Prototype First Architecture

Kiến trúc của **Plant Tales** được quy hoạch theo lộ trình triển khai thực tế của studio: **Prototype ➔ Vertical Slice ➔ Alpha ➔ Beta ➔ Release**. 

Để hướng dẫn chính xác cho AI biết **cái gì được phép xây dựng ngay trong Prototype** và **cái gì tuyệt đối chưa được chạm vào**, mỗi module trong dự án được gắn thẻ trạng thái phát triển (*Development Lifecycle Status Tag*):

```text
┌────────────────────────────────────────────────────────────────────────┐
│ MODULE NAME       │ LIFECYCLE STATUS   │ PROTOTYPE EXECUTION MANDATE   │
├───────────────────┼────────────────────┼───────────────────────────────┤
│ Flower Module     │ [Status: Prototype]│ Core priority: Gieo, tưới, nở │
│ Inventory Module  │ [Status: Prototype]│ Core priority: Lưới Satchel   │
│ NPC Module        │ [Status: Prototype]│ Core priority: 1 NPC, 1 di chuyển│
│ Journal Module    │ [Status: Prototype]│ Core priority: TAB Home Screen│
│ Audio Module      │ [Status: Prototype]│ Core priority: BGM + SFX nền  │
│ Weather Module    │ [Status: Planned]  │ Locked: Chờ Vertical Slice    │
│ Festival Module   │ [Status: Planned]  │ Locked: Chờ Vertical Slice    │
│ Quest Module      │ [Status: Planned]  │ Locked: Chờ Alpha Phase       │
│ Fishing Module    │ [Status: Future]   │ Strictly Locked (No Code yet) │
│ Cooking Module    │ [Status: Future]   │ Strictly Locked (No Code yet) │
│ Bee Keeping Module│ [Status: Future]   │ Strictly Locked (No Code yet) │
└───────────────────┴────────────────────┴───────────────────────────────┘
```

### Chỉ Lệnh Thực Thi Cho AI Copilot (`Prototype Mandate`)
Khi thực hiện giai đoạn **Prototype**, AI **chỉ được phép viết code và event cho 5 module thuộc nhóm `[Status: Prototype]`**. Mọi nỗ lực viết code cho `Fishing`, `Cooking` hay `Festival` lúc này sẽ bị coi là vi phạm phạm vi dự án (*Scope creep violation*) và bị từ chối pull request.

---

## 12. Future Expansion Strategy

Kiến trúc **Project Architecture (`01`)** được thiết kế để mở rộng vô hạn mà không bao giờ phá vỡ nền tảng hiện có. Khi dự án bước sang giai đoạn mở rộng tương lai (*Future Expansion*), các module mới như **Fishing (Câu cá), Cooking (Nấu trà/bánh), Bee Keeping (Nuôi ong) hay Museum (Bảo tàng)** sẽ được tích hợp theo nguyên tắc:

- **Zero Modification to Core Modules (`No Core Touch Rule`):**
  - Khi xây dựng `Bee Keeping Module`, module này sẽ tự động lắng nghe sự kiện `OnFlowerBloomed` để tính toán sản lượng mật ong xung quanh luống hoa.
  - Lập trình viên **không bao giờ phải mở `Flower Module` ra để sửa bất kỳ dòng code nào**.
- **Kế thừa hệ thống Inventory & Journal có sẵn:**
  - Cá câu được (`FishItem`), Mật ong thu hoạch (`HoneyItem`) hay món ăn (`CookedDish`) chỉ việc kế thừa chuẩn `ItemDefinition` để chui gọn gàng vào `Inventory Module`.
  - Thông tin sinh học của cá và ong tự động thêm trang vào `Journal Module` thông qua cơ chế `External Page Provider`.

---

## 13. Architecture Diagram (ASCII)

Sơ đồ xương sống kiến trúc kỹ thuật toàn cục (*Master Technical Backbone Flowchart*) của **Plant Tales**, minh họa dòng chảy từ Player Input đến các Hệ thống Core, Quản lý toàn cục, Sổ tay Bloom Journal và Lễ hội:

```text
                               ┌────────────────────────┐
                               │   PLAYER INPUT LAYER   │
                               │  (Keyboard / Mouse /   │
                               │      Controller)       │
                               └───────────┬────────────┘
                                           │
                                           ▼
                               ┌────────────────────────┐
                               │   INTERACTION LAYER    │
                               │  (Raycast & Bounding   │
                               │     Box Validation)    │
                               └───────────┬────────────┘
                                           │
                    ┌──────────────────────┴──────────────────────┐
                    ▼                                             ▼
       ┌────────────────────────┐                    ┌────────────────────────┐
       │     FLOWER SYSTEM      │                    │    INVENTORY MODULE    │
       │    (Core Authoritative │                    │     (Satchel Grid &    │
       │       Growth & Bloom)  │                    │     Tool Selection)    │
       └───────────┬────────────┘                    └───────────┬────────────┘
                   │                                             │
                   ▼                                             │
       ┌────────────────────────┐                                │
       │     FLOWER DATABASE    │◄───────────────────────────────┘
       │  (JSON Schemas & Raw   │
       │     Authoritative)     │
       └───────────┬────────────┘
                   │
                   ▼
       ┌────────────────────────┐
       │    FLOWER INSTANCE     │
       │  (Scene Runtime Entity │
       │    Growth Mutator)     │
       └───────────┬────────────┘
                   │
                   ├─────────────────────────────────────────────────┐
                   ▼                                                 ▼
       ┌────────────────────────┐                       ┌────────────────────────┐
       │     BLOOM JOURNAL      │                       │       NPC MODULE       │
       │    (Core Home Screen   │                       │  (Daily Schedule Loop  │
       │    Central Data Hub)   │                       │   & Dialogue State)    │
       └───────────┬────────────┘                       └───────────┬────────────┘
                   │                                                │
                   ├────────────────────────┬───────────────────────┘
                   ▼                        ▼
       ┌────────────────────────┐  ┌────────────────────────┐
       │    PRESSED MEMORIES    │  │    QUEST & STORY HUB   │
       │  (Narrative Flashbacks │  │  (Milestone Tracking & │
       │  & Grandpa Heritage)   │  │    Village Memory)     │
       └───────────┬────────────┘  └───────────┬────────────┘
                   │                           │
                   └───────────┬───────────────┘
                               ▼
                   ┌────────────────────────┐
                   │    FESTIVAL MODULE     │
                   │  (Global Contest Hub & │
                   │    Bloom Resonance)    │
                   └───────────┬────────────┘
                               │
                               ▼
                   ┌────────────────────────┐
                   │ PRESENTATION & UI LAYER│
                   │ (Botanical UI, Audio   │
                   │   7-Layers, Quiet VFX) │
                   └────────────────────────┘
```
