# Event Architecture Constitution & Signal Network Standard

**Hiến pháp kiến trúc hệ thống sự kiện tối cao, mạng lưới Signal giải trừ phụ thuộc và quy chuẩn tổ chức Event Sheet cho GDevelop 5 (Event Architecture Constitution & Signal Network Standard Document).**

---

## 1. Event Philosophy

Tài liệu **Event Architecture (`05_Event_Architecture.md`)** được ban hành như **Hiến pháp Kiến trúc Sự kiện Tối cao (*Event Architecture Constitution*)** – hệ thần kinh trung ương (`The Nervous System`) của toàn bộ trò chơi **Plant Tales**, được biên soạn dưới thẩm quyền tối cao và tầm nhìn chuẩn mực của **Lead Gameplay Architect + Senior GDevelop Engineer + Event System Designer + AI Architecture Engineer**.

Trong một môi trường phát triển dựa trên engine trực quan như GDevelop 5 có sự tham gia liên tiếp của đa hệ AI Coding Agents (*Codex, Claude, ChatGPT, Gemini, Antigravity*), Event Sheet là nơi dễ xảy ra sự suy thoái kiến trúc trầm trọng nhất nếu không khóa chặt ngay từ đầu. Các AI thường có xu hướng viết ra những "bức tường sự kiện" dài hàng nghìn block, copy-paste logic va chạm khắp nơi, lồng điều kiện ngập tràn sâu hoắm và quét `For Each` liên tục mỗi frame.

Để chấm dứt triệt để thảm họa này, Hiến pháp Sự kiện của **Plant Tales** thiết lập 8 định luật triết lý cốt lõi:

```text
• Events describe gameplay      (Sự kiện mô tả luồng gameplay, không đóng vai trò kho chứa)
• Events do not own data        (Sự kiện không sở hữu dữ liệu, chỉ đọc và phát tín hiệu)
• Events react. Data decides    (Sự kiện phản ứng. Dữ liệu quyết định kết quả)
• Systems communicate by events (Các hệ thống giao tiếp qua Event Bus, không gọi chéo trực tiếp)
• UI never drives gameplay      (UI tuyệt đối không bao giờ được phép điều khiển hay đổi gameplay)
• Gameplay never waits for UI   (Gameplay không bao giờ đứng chờ hiệu ứng UI mới chạy logic)
• Event Driven Architecture     (Kiến trúc định đoạt bởi Signal/Sự kiện thay vì Polling liên tục)
• Reactive Programming mindset  (Tư duy phản ứng: Lắng nghe Signal thay vì kiểm tra mỗi frame)
```

### Giải Thích Sâu Về 8 Triết Lý Cốt Lõi
1. **Events describe gameplay:** Event Sheet của GDevelop là kịch bản diễn tiến trò chơi (`Script/Execution Flow`). Nó trả lời câu hỏi "Khi người chơi bấm nút tưới nước thì chuyện gì xảy ra?" chứ không phải là nơi định nghĩa hoa có bao nhiêu cánh hay NPC thích quà gì.
2. **Events do not own data:** Nghiêm cấm dùng các Event Variable trôi nổi hay Hardcode bên trong Event Sheet để lưu chỉ số của game. Dữ liệu tĩnh thuộc về `03_Data_Architecture.md`, dữ liệu động thuộc về `Runtime Instances`. Event chỉ làm nhiệm vụ lấy dữ liệu đó ra để tính toán.
3. **Events react. Data decides:** Khi phát hiện va chạm giữa `WateringCan` và `FlowerBox`, Event phản ứng lại (`react`) bằng cách gọi hàm tưới nước. Tuy nhiên, việc luống hoa nở hay chưa hoàn toàn do `FlowerDefinition.bloom_time_seconds` quyết định (`Data decides`), không do Event tự ý cộng điểm.
4. **Systems communicate by events (`Decoupled Signal Bus`):** Hệ thống thực vật (`FlowerSystem`) và hệ thống nhật ký (`JournalModule`) là 2 hòn đảo độc lập. Khi hoa nở, `FlowerSystem` **nghiêm cấm** gọi hàm trực tiếp `JournalUI.UnlockPage()`. Thay vào đó, nó chỉ phát một tín hiệu (`Signal Broadcast`) vào không gian: `"OnFlowerBloomed"`. Journal lắng nghe tín hiệu đó và tự cập nhật trang sách của mình.
5. **UI never drives gameplay (`Strict Layer Separation`):** Giao diện (*UI HUD, Satchel, Bloom Journal*) là tầng hiển thị thụ động. Một nút bấm UI chỉ được phép phát ra tín hiệu yêu cầu (`Request Signal` ví dụ: `RequestPlantSeed`), tuyệt đối không được phép tự ý sinh ra thực thể hoa hoặc trừ tiền người chơi bên trong Event nút bấm.
6. **Gameplay never waits for UI:** Khi hạt giống hoàn tất sinh trưởng, `FlowerInstance` lập tức chuyển sang trạng thái `Harvestable` trong bộ nhớ ngay lập tức. Nó không bao giờ phải chờ hiệu ứng rắc phấn hoa hay âm thanh chúc mừng của UI chạy xong mới cho phép người chơi thu hoạch.
7. **Event Driven Architecture (`Zero Polling Policy`):** Chấm dứt triệt để tư duy quét liên tục `Every frame -> If flower.stage == 4 then unlock journal`. Toàn bộ hệ thống vận hành dựa trên cơ chế kích hoạt theo sự kiện (`Event Triggers`).
8. **Reactive Programming mindset:** Mọi hệ thống con trong game vận hành như các thực thể phản ứng thầm lặng (`Silent Reactive Listeners`). Chúng nằm yên bất động không tiêu tốn CPU cho đến khi Event Bus phát đi tín hiệu có liên quan đến domain của chúng.

---

## 2. Event Layer Architecture (`Strict One-Way Execution Pipeline`)

Để ngăn chặn tuyệt đối tình trạng phụ thuộc vòng (`Circular Dependency`) và rối rắm luồng gọi, toàn bộ mạng lưới sự kiện trong **Plant Tales** được phân tầng thành **6 Lớp Kiến Trúc Một Chiều (*The 6-Layer One-Way Execution Hierarchy*)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│             AUTHORITATIVE ONE-WAY EVENT EXECUTION HIERARCHY            │
├────────────────────────────────────────────────────────────────────────┤
│ Layer 1: [Player Input]                                                │
│          (Chuột click, Bàn phím WASD, Gamepad controller signals)       │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát Input Signals)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 2: [Interaction & Collision Rules]                               │
│          (Kiểm tra Bounding Box sát đất, Raycast picking, Action Check)│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Gửi Validated Request)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 3: [Core Gameplay Systems]                                       │
│          (FlowerSystem, NPCSystem, WeatherSystem, TimeTicker)          │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Biến đổi Runtime Instances)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 4: [Runtime State Update & Global Signal Broadcast]              │
│          (Cập nhật FlowerInstance, InventorySlot ➔ Phát Event Bus)     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Lắng nghe & Ghi nhận thay đổi)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 5: [Save Manager & Persistence Layer]                            │
│          (Cờ Dirty Flag bọc dữ liệu gửi vào player_save.json)          │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Gửi Signal cập nhật hiển thị)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 6: [Presentation Layer: Animation ➔ Audio ➔ UI]                  │
│          (Hiển thị VFX phấn hoa, phát âm thanh vi mô, mở trang Journal)│
└────────────────────────────────────────────────────────────────────────┘
```

### 2.1. Đạo Luật Luồng Đi Một Chiều (`One-Way Downstream Law`)
- **Quy định bất di bất dịch:** Luồng thực thi sự kiện **CHỈ ĐƯỢC PHÉP ĐI XUỐNG (`DOWNSTREAM ONLY`)** từ Layer 1 đến Layer 6.
- **Nghiêm cấm gọi ngược Layer (`Strict Backwards Call Prohibition` — ❌):**
  - **Layer 6 (Presentation/UI)** không được gọi hoặc tác động ngược lên **Layer 3 (Gameplay Systems)** hoặc **Layer 5 (Save Manager)**.
  - **Layer 5 (Save Manager)** không được phát Signal điều khiển ngược lại **Layer 1 (Player Input)**.
  - *Sự vi phạm tầng:* Nếu Event Sheet của `BloomJournalUI` (Layer 6) có một block trực tiếp sửa `FlowerInstance.stage = 4` (Layer 3) hay gọi `SaveGame()` (Layer 5), Event Sheet đó lập tức bị liệt vào danh sách vi phạm hiến pháp và bị xóa bỏ.

---

## 3. Event Sheet Structure (`Modular Tree Topology`)

Kiến trúc cây Event Sheet trong project GDevelop 5 của **Plant Tales** phải được phân rã thành các mô-đun độc lập theo nguyên tắc **Một Scene = Một Cầu Nối Cốt Lõi (`One Scene = One Core Bridge Sheet`)**, kết nối ra mạng lưới `External Events`:

```text
Source/
├── Scenes/
│   ├── BootScene.json         ──► (Link duy nhất: `External_SystemBoot`)
│   ├── MainMenuScene.json     ──► (Link duy nhất: `External_MenuUI`)
│   ├── VillageScene.json      ──► (Bridge Sheet cho khu vực Làng Bách Thảo)
│   │                              ├── Link: `External_PlayerControls`
│   │                              ├── Link: `External_FlowerGrowthLogic`
│   │                              ├── Link: `External_NPCSchedules`
│   │                              ├── Link: `External_WeatherEffects`
│   │                              └── Link: `External_GlobalUI_HUD`
│   ├── HouseScene.json        ──► (Bridge Sheet cho Nhà Kính & Nội thất)
│   │                              ├── Link: `External_PlayerControls`
│   │                              ├── Link: `External_GreenhouseGrid`
│   │                              ├── Link: `External_PressedMemoryTriggers`
│   │                              └── Link: `External_GlobalUI_HUD`
│   └── FestivalScene.json     ──► (Bridge Sheet cho Lễ Hội Hoa Xuân)
│
└── Events/ (Kho External Events — Authoritative Reusable Logic)
    ├── External_PlayerControls.json
    ├── External_FlowerGrowthLogic.json
    ├── External_NPCSchedules.json
    ├── External_WeatherEffects.json
    ├── External_PressedMemoryTriggers.json
    ├── External_GlobalUI_HUD.json
    ├── External_JournalController.json
    └── External_GlobalSignalBus.json
```

- **Quy tắc cho Scene Bridge Sheet:** Bên trong Event Sheet của một Scene (như `VillageScene`), **chỉ được phép chứa các lệnh `Link to External Events`** và tối đa `10 blocks` định nghĩa cấu hình khởi tạo riêng (`Scene Initializer`). Cấm tuyệt đối việc viết logic gameplay trực tiếp bên trong Scene Sheet.

---

## 4. External Event Rules (`Zero God Objects & Single Responsibility`)

`External Events` là xương sống tái sử dụng mã sự kiện của GDevelop. Để tránh việc biến chúng thành bãi rác hỗn độn, mọi External Event phải tuân thủ 4 quy luật hiến pháp:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   EXTERNAL EVENT CONSTITUTIONAL RULES                  │
├───────────────────────────────────┬────────────────────────────────────┤
│ 1. Zero Meaningless Files         │ Cấm tạo các file External rỗng tuếch hoặc file chỉ chứa 1 block   │
│                                   │ lệnh đơn giản rồi link khắp nơi gây rác thư mục `Source/Events/`. │
├───────────────────────────────────┼────────────────────────────────────┤
│ 2. Zero Event God Objects         │ Cấm tạo file `External_AllGameplay.json` hay `External_MainLoop`  │
│                                   │ dài 2000 blocks ôm đồm xử lý cả hoa, NPC, thời tiết và âm thanh.  │
├───────────────────────────────────┼────────────────────────────────────┤
│ 3. Single Responsibility Mandate  │ Một External Event = Đúng Một Trách Nhiệm Domain. File mang tên   │
│                                   │ `External_FlowerGrowthLogic` CHỈ xử lý sinh trưởng thực vật.      │
├───────────────────────────────────┼────────────────────────────────────┤
│ 4. Authoritative Grouping         │ Mọi khối sự kiện bên trong External Event buộc phải được bọc trong│
│                                   │ các `Event Groups` mang tiêu đề `PascalCase` minh bạch rõ ràng.   │
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 5. Event Communication (`The Global Signal Bus`)

Để đảm bảo khả năng mở rộng hàng chục module tương lai mà không làm gãy code cũ, **Plant Tales** thiết lập kiến trúc giao tiếp bằng sự kiện **Global Signal Bus (`Decoupled Broadcast Architecture`)**.

### 5.1. Sơ Đồ Mạng Lưới Phát Tín Hiệu (`Signal Broadcast Flow`)

```text
                               ┌───────────────────────────────────┐
                               │     FLOWER SYSTEM EXECUTION       │
                               │ (Hoa Bách Hợp vừa đạt Stage Nở)    │
                               └─────────────────┬─────────────────┘
                                                 │
                                                 │ [Broadcast Signal: "FlowerBloomed"]
                                                 ▼
                               ┌───────────────────────────────────┐
                               │     GLOBAL SIGNAL BUS (EventBus)  │
                               │  (Trung tâm phát thanh sự kiện)   │
                               └─────────────────┬─────────────────┘
                                                 │
            ┌──────────────────┬─────────────────┼─────────────────┬──────────────────┐
            ▼                  ▼                 ▼                 ▼                  ▼
┌──────────────────────┐ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐ ┌──────────────────────┐
│      NPC SYSTEM      │ │ JOURNAL MODULE│ │FESTIVAL MODULE│ │ AUDIO SYSTEM  │ │   ANIMATION LAYER    │
│ (Lắng nghe Signal)   │ │(Lắng nghe Sig)│ │(Lắng nghe Sig)│ │(Lắng nghe Sig)│ │  (Lắng nghe Signal)  │
│                      │ │               │ │               │ │               │ │                      │
│ ➔ Kiểm tra sở thích  │ │ ➔ Mở khóa trang│ │ ➔ Cộng điểm   │ │ ➔ Phát âm thanh│ │ ➔ Kích hoạt Sprite   │
│    thấy hoa đẹp      │ │    tiêu bản   │ │    trưng bày  │ │    vi mô Chime│ │    nở rộ & rắc phấn  │
│ ➔ Tự vẫy tay cười    │ │    Bách Hợp   │ │    Lễ Hội     │ │    3D Spatial │ │    Micro Sparkles    │
└──────────────────────┘ └───────────────┘ └───────────────┘ └───────────────┘ └──────────────────────┘
```

### 5.2. Các Lệnh Cấm Địa Trong Giao Tiếp Sự Kiện (`Forbidden Coupling` — ❌ RED LIGHT)
❌ **Nghiêm cấm gọi chéo trực tiếp (`Strict Coupling Prohibition`):**
```text
If Flower.Stage == 4:
  Call NPC.PlayAnimation("Happy")     // ❌ SAI! Flower cấm biết sự tồn tại của NPC.
  Call JournalUI.Unlock("WhiteLily")  // ❌ SAI! Flower cấm gọi trực tiếp giao diện UI.
  Call SaveGame()                     // ❌ SAI! Flower cấm tự ý kích hoạt Save Manager.
```

✅ **Khối sự kiện chuẩn Studio (`Approved Signal Broadcast` — ✅ GREEN LIGHT):**
```text
If Flower.Stage == 4:
  // Phát tín hiệu minh bạch ra Global Signal Bus kèm thông số truyền qua Scene Variable
  Set Scene Variable `Signal_Param_FlowerID` = Flower.RefID
  Set Scene Variable `Signal_Param_GridX` = Flower.GridX
  Set Scene Variable `Signal_Param_GridY` = Flower.GridY
  Trigger External Event `Bus_BroadcastSignal` with name "FlowerBloomed"
```

---

## 6. Trigger Rules (`Precision Execution Timing`)

Phân bổ và định nghĩa cách sử dụng các điều kiện kích hoạt sự kiện (*Event Triggers*) bên trong GDevelop 5 để ngăn chặn lãng phí hiệu năng CPU:

| Bảng Cơ Chế Trigger (`GDevelop Trigger Type`) | Định nghĩa & Trường hợp bắt buộc áp dụng (`REQUIRED` — ✅) | Các tình huống bị cấm tuyệt đối (`PROHIBITED` — ❌) |
| --- | --- | --- |
| **`Trigger Once while true`** | Bắt buộc phải gắn vào mọi Event kiểm tra trạng thái boolean hoặc kiểm tra va chạm (`Collision Check`) để lệnh chỉ chạy đúng 1 lần tại frame xảy ra sự kiện. | ❌ Cấm để Event kiểm tra va chạm chạy tự do không có `Trigger Once` vì sẽ gọi hàm 60 lần/giây! |
| **`Cooldown / Timer`** | Dùng cho các sự kiện định kỳ như tính toán sinh trưởng thực vật (`Check every 1.0 second`) hoặc hệ thống kiểm tra thời tiết rào (`Check every 5.0 seconds`). | ❌ Cấm set Timer dưới `0.1s` (100ms) cho các tác vụ nặng vì sẽ gây sụt giảm FPS nghiêm trọng. |
| **`Delayed Event`** | Dùng khi cần tạo khoảng dừng nghệ thuật (`Artistic Pause` ví dụ: Đợi `0.5s` sau khi thu hoạch hoa mới hiện thông báo nhật ký bách thảo). | ❌ Cấm dùng Delayed Event để xử lý tuần tự logic core vì dễ gãy khi người chơi chuyển Scene nhanh. |
| **`State Machine Event`** | Dùng cho chuyển đổi trạng thái thực thể rõ ràng (`Check Object Variable State == "Harvestable"`). | ❌ Cấm dùng biến cờ boolean trôi nổi rối rắm thay cho State Machine chuẩn. |
| **`Polling (Every Frame)`** | CHỈ được phép dùng duy nhất cho việc cập nhật vị trí Camera di chuyển mềm mại (`Smooth Camera Follow`) và hiệu ứng VFX bay theo gió. | ❌ CẤM TUYỆT ĐỐI Polling mỗi frame để quét cơ sở dữ liệu, quét NPC hay quét kho túi đồ Satchel! |

---

## 7. State Management (`Strict Entity State Machines`)

Khẳng định nguyên tắc quản lý trạng thái: **"Một thực thể sống trong thế giới Plant Tales chỉ tồn tại trong đúng 1 Trạng Thái Độc Lập (`Single Discrete State`) tại một thời điểm thông qua `State Machine`. Nghiêm cấm sử dụng các biến cờ boolean hỗn loạn."**

### 7.1. Sơ Đồ State Machine Chuẩn Cho Thực Vật (`FlowerInstance State Machine`)

```text
       [Gieo hạt]
           │
           ▼
     ┌───────────┐         Tưới nước & Đạt Timer         ┌───────────┐
     │   IDLE    │ ────────────────────────────────────► │  GROWING  │
     │ (Hạt giống)│ ◄──────────────────────────────────── │ (Mọc mầm) │
     └─────┬─────┘          Mất nước / Thiếu nắng        └─────┬─────┘
           │                                                   │
           │                                                   │ Đạt đủ 100% Growth Time
           │ Bị hạn hán / Rời đi quá 14 ngày                    ▼
           │                                             ┌───────────┐
           │                                             │   BLOOM   │
           │                                             │ (Nở rực rỡ)│
           │                                             └─────┬─────┘
           ▼                                                   │
     ┌───────────┐         Thu hoạch bằng tay            ┌─────┴─────┐
     │  WILTED   │ ◄──────────────────────────────────── │HARVESTABLE│
     │ (Héo úa)  │                                       │ (Sẵn sàng)│
     └───────────┘                                       └─────┬─────┘
           ▲                                                   │
           │                                                   │ Người chơi bấm bấm thu hoạch
           │                                                   ▼
           │                                             ┌───────────┐
           └──────────────────────────────────────────── │ HARVESTED │
                          Để trống quá 3 ngày            │(Đã thu lấy)│
                                                         └───────────┘
```

❌ **Các biến cờ boolean bị cấm tuyệt đối (`Forbidden Chaotic Booleans`):**
```text
flower.isGrowing = true   |   flower.isBloom = true   |   flower.isHarvest = false   |   flower.isReady = true
```
*Lý do cấm:* Khi có 4 biến boolean song song, hệ thống sẽ sinh ra $2^4 = 16$ trạng thái ngẫu nhiên phi lý (ví dụ: vừa `isGrowing = true` lại vừa `isBloom = true`). Buộc phải khóa vào 1 trường duy nhất: `FlowerInstance.State = "Growing" | "Bloom" | "Harvestable"`.

---

## 8. Dependency Rules (`The Inter-Module Communication Boundary`)

Ma trận phân định quyền hạn nói chuyện giữa các module sự kiện (`Module Inter-Dependency Boundary Matrix`), bảo vệ nguyên tắc phân tách trách nhiệm tối đa:

```text
┌────────────────────────────────────────────────────────────────────────┐
│               AUTHORITATIVE MODULE DEPENDENCY FLOW CHART               │
├────────────────────────────────────────────────────────────────────────┤
│ [FlowerSystem] ──► [InventoryModule] ──► [JournalModule] ──► [SaveSys] │
│       │                   │                     │                      │
│       ├───────────────────┼─────────────────────┴──► [Achievements]    │
│       │                   │                                            │
│       ▼                   ▼                                            │
│ [FestivalModule] ◄────────┴────────────────────────────────────────────┘
│       ▲
│       │ (Lắng nghe & Đọc trạng thái tĩnh từ DB)
│ [NPCSystem]
├────────────────────────────────────────────────────────────────────────┤
│ • UI Module:        CHỈ ĐƯỢC PHÉP ĐỌC (`ReadOnly`) trạng thái từ tất cả các module trên.
│ • Audio System:     CHỈ ĐƯỢC PHÉP LẮNG NGHE (`Listen Only`) Signal Bus để phát SFX/BGM.
│ • Animation Layer:  CHỈ ĐƯỢC PHÉP LẮNG NGHE (`Listen Only`) Signal Bus để chạy Sprite Aseprite.
└────────────────────────────────────────────────────────────────────────┘
```

---

## 9. Performance Rules (`Anti-Polling & Spatial Optimization`)

Để bảo đảm tốc độ khung hình chuẩn mực `60 FPS` tuyệt đối trên engine GDevelop 5 ngay cả khi khu vườn có tới 500 thực thể hoa nở rộ cùng lúc, mọi Event Sheet phải tuân thủ 6 định luật tối ưu hiệu năng:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                 EVENT SHEET 60 FPS PERFORMANCE CONSTITUTION            │
├───────────────────────────────────┬────────────────────────────────────┤
│ 1. No "For Each" Every Frame      │ CẤM TUYỆT ĐỐI viết vòng lặp `For Each Object` chạy mỗi frame.  │
│                                   │ Bắt buộc phải gắn `Trigger Once` hoặc sử dụng `Timer (> 0.5s)`. │
├───────────────────────────────────┼────────────────────────────────────┤
│ 2. Mandatory Spatial Culling      │ CẤM tính toán sinh trưởng hay va chạm cho các cây nằm ngoài màn │
│                                   │ hình. Buộc phải thêm điều kiện `Object is on screen` culling. │
├───────────────────────────────────┼────────────────────────────────────┤
│ 3. Object Picking over Scanning   │ Thay vì quét 500 cây để tìm cây có ID `#542`, buộc phải dùng   │
│                                   │ điều kiện lọc của GDevelop `Pick flower where ID = 542` lập tức.│
├───────────────────────────────────┼────────────────────────────────────┤
│ 4. Dirty Flag Caching             │ Kho Satchel không được tính lại tổng giá trị tiền của hạt giống│
│                                   │ 60 lần/giây. Chỉ tính lại khi biến cờ `SatchelDirty == true`.  │
├───────────────────────────────────┼────────────────────────────────────┤
│ 5. Trigger Once on Collision      │ Mọi khối sự kiện va chạm (`Player is in collision with NPC`)   │
│                                   │ bắt buộc phải có sub-condition `Trigger once while true`.      │
├───────────────────────────────────┼────────────────────────────────────┤
│ 6. Batch Event Processing         │ Khi phát Signal `NewDayArrival`, thay vì update 500 cây cùng   │
│                                   │ 1 frame gây giật lag, chia nhỏ update qua `Async Timer Tickers`.│
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 10. Prototype Event Rules (`Sandbox Iteration Boundaries`)

Thiết lập ranh giới phân định minh bạch giữa cách viết Event cho giai đoạn thử nghiệm ban đầu (**Prototype Sandbox**) và giai đoạn sản xuất chính thức (**Production Core**):

| Tiêu chí kỹ thuật | Chế độ Prototype Sandbox (`Prototype/` — ✅ ALLOWED) | Chế độ Production Core (`Source/` — ❌ PROHIBITED) |
| --- | --- | --- |
| **Mock Events & Signals**| ✅ Được phép phát giả lập tín hiệu `Mock_FlowerBloomed` bằng một phím tắt debug để test UI nhanh. | ❌ Cấm hoàn toàn mọi sự kiện giả lập hay phím tắt debug trôi nổi bên trong `Source/Events/`. |
| **Placeholder Blocks** | ✅ Được dùng các block comment tạm thời hoặc sự kiện thay đổi màu sắc hình vuông thô. | ❌ Cấm mọi placeholder block chưa hoàn thiện hay chưa gán Sprite/Audio thật. |
| **Event Sheet Topology**| ✅ Được phép để logic tạm thời ngay bên trong `VillageScene_Prototype.json` để test va chạm nháp. | ❌ Bắt buộc phải rẽ nhánh tuyệt đối sang `External Events` theo đúng chuẩn Chương 3. |

---

## 11. AI Event Rules (`GREEN vs RED LIGHT`)

Bảng hiến pháp quy định các quyền hạn được phép thực thi và các lệnh cấm địa dành riêng cho AI Coding Agents (`Codex`, `Antigravity`, `Claude`, `ChatGPT`) khi thao tác với hệ thống sự kiện GDevelop:

### 11.1. Đèn Xanh (`Authorized AI Event Actions` — ✅ GREEN LIGHT)
- ✅ **Thêm External Event mới:** Được tạo file nhóm sự kiện mới tại `Source/Events/` để kết nối vào Scene nếu tuân thủ 100% nguyên tắc Single Responsibility.
- ✅ **Thêm Signal & Listeners:** Được phép thêm các tín hiệu mới vào `External_GlobalSignalBus.json` và gắn các khối lắng nghe thụ động vào module tương ứng.
- ✅ **Tạo Custom Functions / Behaviors:** Được định nghĩa các `Custom Behaviors` mới cho GDevelop Object (`GridSnapBehavior`, `SwayInWindBehavior`) để tái sử dụng logic.
- ✅ **Tối ưu hóa khối sự kiện:** Được phép refactor một khối sự kiện lồng 4 tầng condition thành các khối ngang phẳng bằng Guard Clauses hoặc Pickers.

### 11.2. Đèn Đỏ (`Strictly Forbidden AI Event Actions` — ❌ RED LIGHT)
- ❌ **Cấm tạo Event God Sheet (`No God Sheets`):** Cấm tạo file Event Sheet dài quá `150 blocks` ôm đồm đa trách nhiệm.
- ❌ **Cấm duplicate blocks (`No Copy-Paste Logic`):** Cấm copy-paste một cụm 15 block event xử lý va chạm ở 3 file khác nhau.
- ❌ **Cấm gọi ngược Layer (`No Backwards Layer Calls`):** Cấm viết Event từ `UI Module` (Layer 6) gọi sửa đổi trực tiếp dữ liệu của `FlowerSystem` (Layer 3) hay `SaveManager` (Layer 5).
- ❌ **Cấm hardcode con số trong Event (`No Hardcoded Event Numbers`):** Cấm chèn trực tiếp các chỉ số sinh trưởng, thời gian hay điểm thân thiện trực tiếp vào giữa khối điều kiện GDevelop.
- ❌ **Cấm bypass Save Layer (`No Persistence Bypass`):** Cấm tự ý viết logic lưu file JSON trực tiếp từ `FlowerSystem` mà không đi qua cờ `Dirty Flag` của `SaveManager`.

---

## 12. Event Naming Convention (`PascalCase & Past-Tense Signals`)

Toàn bộ tên gọi cho các sự kiện, tín hiệu broadcast và nhóm sự kiện bên trong GDevelop phải tuân thủ chuẩn định dạng `PascalCase` với quy tắc ngữ pháp thời gian minh bạch:

### 12.1. Quy Tắc Đặt Tên Tín Hiệu (`Signal Naming Grammar`)
- **Tín hiệu thông báo sự kiện đã xảy ra (`Broadcast Signals`):** Buộc phải bắt đầu bằng danh từ + Động từ ở thể quá khứ (`Past Tense Suffix`). Phản ánh sự thật đã xảy ra (`Events react`).
- **Tín hiệu yêu cầu thực thi hành động (`Request Signals`):** Buộc phải bắt đầu bằng tiền tố `Request + [Verb + Noun]`.

| Loại sự kiện / Tín hiệu | Cú pháp chuẩn mực (`Naming Formula`) | Ví dụ chuẩn xác hợp lệ (`REQUIRED` — ✅) | Ví dụ sai bị cấm (`FORBIDDEN` — ❌) |
| --- | --- | --- | --- |
| **Broadcast Signals** | `[Domain] + [VerbPastTense]` | `FlowerBloomed`<br>`FlowerHarvested`<br>`InventoryChanged`<br>`WeatherChanged`<br>`FestivalStarted`<br>`FestivalEnded`<br>`MemoryUnlocked`<br>`JournalUpdated`<br>`NPCRelationshipChanged` | `flower_bloom`<br>`OnHarvest`<br>`change_inv`<br>`weather_update`<br>`start_festival` |
| **Request Signals** | `Request + [Verb + Noun]` | `RequestPlantSeed`<br>`RequestWaterTarget`<br>`RequestJournalOpen`<br>`RequestSaveGame` | `plant_now`<br>`do_water`<br>`open_ui`<br>`save_click` |
| **Event Groups / Sheets**| `PascalCase + Logic/System` | `FlowerGrowthLogic`<br>`NPCDailySchedule`<br>`WeatherEffectsController` | `group_1`<br>`flower_stuff`<br>`main_events` |

---

## 13. Future Scalability (`Zero Event Breakage Expansion`)

Kiến trúc sự kiện (`05_Event_Architecture.md`) được thiết kế với độ mở rộng tối đa cho studio, bảo đảm khả năng tích hợp mượt mà 9 hệ thống gameplay tương lai vào `Global Signal Bus` mà **không bao giờ phải sửa đổi hay làm gãy dù chỉ một block trong các Event Sheet cốt lõi hiện có (`Zero Core Event Breakage`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│ FUTURE EXPANSION  │ EVENT ARCHITECTURAL INTEGRATION STRATEGY           │
├───────────────────┼────────────────────────────────────────────────────┤
│ Cooking Module    │ Lắng nghe Signal `RequestOpenCooking`. Đọc nguyên  │
│                   │ liệu từ `InventoryModule` qua hàm `GetCount()`.    │
│                   │ Khi nấu xong, phát Signal `InventoryChanged`.      │
├───────────────────┼────────────────────────────────────────────────────┤
│ Fishing Module    │ Lắng nghe Signal `PlayerInputCastRod`. Khi câu được│
│                   │ cá, phát Signal `FishCaught` ➔ `JournalModule` tự  │
│                   │ động catch signal và mở khóa trang cá.             │
├───────────────────┼────────────────────────────────────────────────────┤
│ Bee Keeping       │ External Event `External_BeeKeeping.json` tự động  │
│                   │ lắng nghe Signal `FlowerBloomed` bên trong bán kính│
│                   │ `OnScreen` để tăng sản lượng mật (`HoneyRate`).    │
├───────────────────┼────────────────────────────────────────────────────┤
│ Museum / Gallery  │ Lắng nghe Signal `FlowerHarvested` / `MemoryUnlocked`│
│                   │ để tự động hiển thị gợi ý hiến tặng tại quầy tiếp tân.│
├───────────────────┼────────────────────────────────────────────────────┤
│ Pets Module       │ Lắng nghe Signal `WeatherChanged` (mưa rào) để tự  │
│                   │ động kích hoạt State Machine chạy vào hiên nhà trốn.│
├───────────────────┼────────────────────────────────────────────────────┤
│ Modding Support   │ Hệ thống Event Bus tự động phát tiếp sức (`Relay`) │
│                   │ toàn bộ Signal ra một kênh ngoại vi cho Mod Scripts. │
└───────────────────┴────────────────────────────────────────────────────┘
```

---

## 14. Master Event Flow Diagram

Sơ đồ ASCII tổng thể luồng thực thi sự kiện toàn cầu cấp studio AAA (*Studio-grade Master Event Architecture Backbone*), minh họa trọn vẹn hành trình 6 lớp (`The 6-Layer Pipeline`) từ cái nhấp chuột của người chơi thấu qua mạng lưới Signal Bus cho tới khi dữ liệu được đóng gói vào Save File và phát âm thanh vi mô ra màn hình:

```text
================================================================================
                        MASTER EVENT ARCHITECTURE BACKBONE
================================================================================

[LAYER 1: PLAYER INPUT]
    │
    ├─► Click / Key Press (WASD / Mouse / Gamepad)
    │
    ▼
[LAYER 2: INTERACTION & COLLISION RULES]
    │
    ├─► Raycast Picking & Bounding Box Check (`Pick flower where ID = #542`)
    ├─► Validate State: `FlowerInstance.State == "Harvestable"`
    │
    ▼
[LAYER 3: CORE GAMEPLAY SYSTEMS EXECUTION]
    │
    ├─► [FlowerSystem] ──(Mutate Instance)──► Set `FlowerInstance.State = "Harvested"`
    │                                          Calculate Mutation & Rarity Bonus
    │
    ▼
[LAYER 4: STATE UPDATE & GLOBAL SIGNAL BROADCAST]
    │
    ├─► Add Item to [InventoryModule] ───────► Set `SatchelDirty = true`
    │
    ├─► BROADCAST TO GLOBAL SIGNAL BUS ──────► Signal: `FlowerHarvested (ID: white_lily)`
    │                                          Signal: `InventoryChanged`
    │                                          Signal: `JournalUpdated`
    │
    ▼
[LAYER 5: SAVE MANAGER & PERSISTENCE LAYER]
    │
    ├─► Catch Signal `InventoryChanged` ─────► Set `SaveDirtyFlag = true`
    ├─► (Async Ticker bóc tách dữ liệu gửi vào `player_save.json`)
    │
    ▼
[LAYER 6: PRESENTATION LAYER (`Silent Reactive Listeners`)]
    │
    ├─► [Animation Layer]  ──(Listen: FlowerHarvested)──► Play Aseprite Sparkle & Sway VFX
    ├─► [Audio System]     ──(Listen: FlowerHarvested)──► Play Micro Chime `sfx_harvest_perfect`
    └─► [UI Presentation]  ──(Listen: InventoryChanged)─► Refresh Satchel HUD Text (`Cache-on-Dirty`)
```

---

## 15. Immutable Event Laws (`The 18 Supreme Commandments`)

Tổng hợp 18 điều luật hiến pháp sự kiện bất di bất dịch của **Plant Tales**. Bất kỳ ai (Con người hay AI Agent) vi phạm 1 trong 18 điều luật này bên trong GDevelop Event Sheet, khối sự kiện sẽ lập tức bị xóa bỏ:

1. **Events never own data.** *(Sự kiện không bao giờ sở hữu dữ liệu tĩnh; chỉ đọc từ Schema và phát tín hiệu).*
2. **Gameplay never updates UI directly.** *(Gameplay cấm gọi sửa đổi UI trực tiếp; chỉ phát Signal vào Event Bus).*
3. **UI only reacts.** *(UI là tầng hiển thị thụ động lắng nghe tín hiệu, tuyệt đối không điều khiển gameplay).*
4. **Broadcast, don't call.** *(Các hệ thống giao tiếp bằng Broadcast Signal, nghiêm cấm gọi chéo trực tiếp).*
5. **One Event Sheet, one responsibility.** *(Một External Event Sheet mang đúng 1 trách nhiệm domain).*
6. **No duplicated Events.** *(Cấm copy-paste logic sự kiện; buộc phải gói thành `External Event/Behavior`).*
7. **No Event God Objects.** *(Cấm tạo Event Sheet dài trên `150 blocks` ôm đồm xử lý toàn game).*
8. **No infinite polling.** *(Cấm quét vòng lặp `For Each` mỗi frame; bắt buộc dùng `Trigger Once/Timer`).*
9. **No hidden state.** *(Khách quan minh bạch: Không cờ boolean trôi nổi, tuân thủ `State Machine`).*
10. **Prototype before optimization.** *(Viết luồng chạy chuẩn trước, tối ưu culling sau; cấm tối ưu sớm mù quáng).*
11. **Strict 6-Layer one-way execution.** *(Luồng Event chỉ đi xuống từ Input tới Presentation; cấm gọi ngược).*
12. **Mandatory Trigger Once on collision.** *(Mọi va chạm và boolean check phải gắn `Trigger once while true`).*
13. **Spatial Culling mandate.** *(Cấm xử lý sự kiện cho thực thể ngoài màn hình; dùng `Object is on screen`).*
14. **Object picking over scanning.** *(Dùng bộ lọc `Pick where ID` lập tức, cấm quét duyệt toàn bộ danh sách).*
15. **PascalCase for Event Sheets & Groups.** *(Tên Sheet và Group bắt buộc PascalCase minh bạch).*
16. **Past-tense grammar for broadcast signals.** *(Tín hiệu broadcast phản ánh quá khứ: `FlowerBloomed`).*
17. **Save Layer isolation.** *(Gameplay cấm tự ghi file JSON; phải kích hoạt `Dirty Flag` cho `SaveManager`).*
18. **AI never invents architecture.** *(AI sinh event tuân thủ 100% tài liệu này, nghiêm cấm tự chế kiến trúc).*

---

## Appendix A: Event Architecture Summary

- **Execution Topology:** `Player Input ➔ Interaction ➔ Gameplay Systems ➔ State Update ➔ Save Layer ➔ Presentation`.
- **Signal Bus Grammar:** `[Domain] + [VerbPastTense]` (`FlowerBloomed`, `InventoryChanged`, `WeatherChanged`).
- **Performance Threshold:** Zero per-frame polling, mandatory `Trigger Once`, `Spatial Culling`, and `Cache-on-Dirty`.

---

## Appendix B: AI Event Checklist

Trước khi tích hợp bất kỳ khối sự kiện GDevelop hay Custom Behavior nào vào project, AI Coding Agents (`Codex`, `Antigravity`) phải tự kiểm chứng qua 7 bước:

- [ ] **1. One-Way Flow Check:** Event block có tuân thủ luồng một chiều từ Layer 1 đến Layer 6 và không gọi ngược tầng không?
- [ ] **2. Single Responsibility Check:** Event Sheet có dưới `150 blocks` và chỉ làm đúng 1 nhiệm vụ domain không?
- [ ] **3. Decoupled Signal Check:** Có sử dụng Global Signal Bus để giao tiếp thay vì gọi trực tiếp `UI.Unlock()` không?
- [ ] **4. Anti-Polling Check:** Đã gắn `Trigger once while true` cho các lệnh va chạm và kiểm tra boolean chưa?
- [ ] **5. State Machine Check:** Đã sử dụng đúng chuỗi trạng thái (`Idle -> Growing -> Bloom`) thay cho biến boolean hỗn loạn chưa?
- [ ] **6. Naming Grammar Check:** Tên tín hiệu broadcast có tuân thủ đúng thì quá khứ (`FlowerBloomed`) theo chuẩn PascalCase chưa?
- [ ] **7. Zero Hardcode Check:** Đã loại bỏ hoàn toàn con số bí ẩn và không có khối logic nào bị copy-paste chưa?

---

## Appendix C: Production Readiness Checklist & Status

- [x] Khóa 8 triết lý sự kiện tối cao (`Events describe gameplay, Systems communicate by events...`).
- [x] Thiết lập 6 lớp kiến trúc luồng thực thi một chiều (`One-Way Execution Pipeline`).
- [x] Chuẩn hóa cây cấu trúc Event Sheet mô-đun hóa (`One Scene = One Core Bridge Sheet`).
- [x] Khóa 4 hiến pháp External Event chống bãi rác và cấm `Event God Objects`.
- [x] Thiết kế trung tâm phát thanh sự kiện `Global Signal Bus` và cấm gọi chéo trực tiếp.
- [x] Bảng cơ chế Trigger (`Trigger Once, Cooldown, State Machine`) chống lãng phí CPU.
- [x] Sơ đồ State Machine 6 trạng thái chuẩn cho thực thể thực vật và cấm boolean hỗn loạn.
- [x] Ma trận phân định ranh giới nói chuyện giữa các module và cấm xâm phạm dữ liệu.
- [x] 6 định luật tối ưu hiệu năng `60 FPS` (`Spatial Culling, Object Picking, Dirty Flag`).
- [x] Bảng phân định Prototype Sandbox vs Production Core, quy ước đặt tên `Past-Tense Signals`.
- [x] Chiến lược mở rộng tương lai 9 hệ thống và sơ đồ ASCII Master Event Flow toàn cục.
- [x] Khóa 18 điều luật hiến pháp bất khả xâm phạm (`The 18 Supreme Commandments`).

**Status: Approved**
*(Khóa hiến pháp kiến trúc sự kiện GDevelop toàn cục. Sẵn sàng tiến sang Module 06: `06_Save_Load_System.md`).*
