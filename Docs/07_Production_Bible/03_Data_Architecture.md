# Data Architecture & Database Constitution

**Hiến pháp dữ liệu tối cao, kiến trúc cơ sở dữ liệu và bản thiết kế cấu trúc tĩnh/động cho dự án Plant Tales (Data Architecture & Database Constitution Document).**

---

## 1. Data Philosophy

Tài liệu **Data Architecture (`03_Data_Architecture.md`)** được ban hành như **Hiến pháp Dữ liệu Tối cao (*The Data Constitution*)** của toàn bộ vũ trụ **Plant Tales**, được biên soạn dưới góc nhìn và quyền lực của **Senior Technical Architect + Lead Gameplay Programmer + Database Architect**.

Trong một dự án game phát triển theo mô hình hợp tác đa trí tuệ nhân tạo (*Codex, ChatGPT, Claude, Gemini, Antigravity*), nếu không có một đạo luật khóa chặt kiến trúc dữ liệu, các AI Agent sẽ lập tức tự sáng tạo ra hàng chục cấu trúc Schema mâu thuẫn, tự ý thêm field hoặc đổi tên object theo thói quen huấn luyện riêng. Hiến pháp này thiết lập định luật tối cao:

> **"Everything is Data (`Mọi thứ trong game đều là dữ liệu`). Gameplay reads data. UI reads data. Animation reads data. Audio reads data. Nothing owns gameplay except data."**

Không một module logic nào (từ va chạm, chuyển động đến hội thoại) được phép tự ý nắm giữ trạng thái riêng biệt ngầm định. Mọi hành vi của trò chơi phải được định đoạt hoàn toàn bởi dữ liệu thông qua 5 cột trụ kiến trúc:

- **Single Source of Truth (Nguồn chân lý duy nhất):**  
  Mọi định nghĩa thực thể (một bông hoa, một cư dân, một vật phẩm) chỉ có **đúng 1 Schema hợp lệ duy nhất** nằm trong kho dữ liệu chuẩn. Bất kỳ sự lặp lại hay biến thể không định danh nào đều là bất hợp pháp.
- **Data Driven Architecture (Kiến trúc định đoạt bởi dữ liệu):**  
  Logic GDevelop Event Sheet hoặc code chỉ đóng vai trò là "cỗ máy đọc" (*Reading Engine*). Thay vì viết hardcode `If flower == Rose then time = 300`, hệ thống đọc `FlowerDefinition.bloom_time_seconds`. Muốn cân bằng lại game, chỉ sửa dữ liệu, không bao giờ sửa code logic.
- **Immutable Definitions (Định nghĩa tĩnh bất biến):**  
  Toàn bộ các bản thiết kế gốc (*Blueprint/Definitions*) được tải vào bộ nhớ lúc khởi động game và được khóa **Read-Only (Chỉ đọc)** tuyệt đối trong suốt quá trình chạy thực tế.
- **Runtime Instances (Thực thể động thời gian thực):**  
  Khi người chơi trồng một cây hay giao tiếp với NPC, hệ thống sinh ra một **Runtime Instance (Thực thể động)** kế thừa từ Immutable Definition, chịu trách nhiệm lưu trữ các biến đổi trạng thái tức thời (lượng nước đã tưới, điểm thân thiện hiện tại).
- **Persistence Layer (Tầng lưu trữ bền vững):**  
  Tầng phân tách rạch ròi giữa những gì là tài nguyên tĩnh cố định của game (không bao giờ save vào ổ cứng) và những gì thuộc về tiến trình cá nhân của người chơi (bắt buộc phải serialize/save).

---

## 2. Static Data vs Runtime Data

Để ngăn chặn triệt để thảm họa phình to file save hoặc rò rỉ bộ nhớ, **Plant Tales** phân chia toàn bộ dữ liệu thành hai bán cầu tách biệt tuyệt đối: **Static Data (Dữ liệu tĩnh)** và **Runtime Data (Dữ liệu động)**.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        THE DATA BIPARTITION                            │
├───────────────────────────────────┬────────────────────────────────────┘
│      STATIC DATA (ReadOnly)       │      RUNTIME DATA (Read/Write)     │
├───────────────────────────────────┼────────────────────────────────────┤
│ • FlowerDefinition                │ • FlowerInstance                   │
│ • NPCData                         │ • NPCState                         │
│ • FestivalDefinition              │ • Inventory                        │
│ • ItemDefinition                  │ • Relationship                     │
│ • QuestDefinition                 │ • PlayerData                       │
│ • AchievementDefinition           │ • WeatherState                     │
│ • LanguageOfFlowersDefinition     │ • QuestProgress                    │
└───────────────────────────────────┴────────────────────────────────────┘
```

### 2.1. Static Data (`Immutable Read-Only Schemas`)
- **Đặc tính kỹ thuật:** Được parse từ các tệp JSON tĩnh trong thư mục `Source/Data/` vào bộ nhớ đệm `Memory Cache` duy nhất một lần ngay tại **Boot Scene (`01_Project_Architecture.md`)**.
- **Quy định bất biến:**  
  - **KHÔNG BAO GIỜ THAY ĐỔI (`NEVER MUTATED`)** trong lúc runtime.
  - Các module `Gameplay`, `UI`, `Audio` chỉ được phép gọi hàm `GetDefinitionByID(id)` để đọc thông số. Nghiêm cấm mọi thao tác gán trị (`Assignment / Write`).

### 2.2. Runtime Data (`Mutable State Instances`)
- **Đặc tính kỹ thuật:** Là các thực thể sống trong bộ nhớ RAM, đại diện cho thực trạng thế giới và hành động của người chơi trong phiên chơi hiện tại (*Session*).
- **Quy định quản trị:**  
  - Sinh ra, biến đổi liên tục (`Write/Update`) trong quá trình chơi thông qua các hệ thống Core.
  - Đây chính là tập hợp dữ liệu duy nhất được quyền chuyển giao cho `SaveManager` để đóng gói vào Save File khi người chơi đi ngủ hoặc lưu game.

---

## 3. Authoritative Objects Table

Bảng hiến pháp phân định chủ quyền tối cao cho toàn bộ các thực thể dữ liệu trong trò chơi (*Authoritative Object Registry*). Mọi AI Agent buộc phải tham chiếu bảng này trước khi thiết lập bất kỳ biến số hay sự kiện nào:

| Tên Object (`Schema Class`) | Chủ quản hệ thống (`Owner Database/System`) | Quyền chỉnh sửa Runtime (`Editable`) | Quyền lưu Save File (`Persistent`) | Ví dụ định danh / Thực thể mẫu (`Example`) |
| --- | --- | --- | --- | --- |
| `FlowerDefinition` | `Flower Database` | `No` (Read-Only) | `No` (Exclusion) | `flower_white_lily` *(Thông số gốc hoa Bách hợp)* |
| `FlowerInstance` | `Flower System` | `Yes` (Read/Write)| `Yes` (Saved) | `Flower #542` *(Luống hoa thứ 542 tại tọa độ X:120, Y:340)* |
| `NPCData` | `NPC Database` | `No` (Read-Only) | `No` (Exclusion) | `npc_florist` *(Tiểu sử, sở thích của bán hoa)* |
| `NPCState` | `NPC System` | `Yes` (Read/Write)| `Yes` (Saved) | `Florist_State` *(Đang đứng ở Quảng trường lúc 10:00 AM)* |
| `Relationship` | `NPC System` | `Yes` (Read/Write)| `Yes` (Saved) | `npc_florist_hearts` *(Độ thân thiện: 4/5 trái tim)* |
| `ItemDefinition` | `Item Database` | `No` (Read-Only) | `No` (Exclusion) | `item_seed_white_lily` *(Thông số hạt giống)* |
| `InventorySlot` | `Inventory Module` | `Yes` (Read/Write)| `Yes` (Saved) | `Slot #03` *(Chứa 15x hạt giống Bách hợp)* |
| `PressedMemory` | `Memory Database` | `No` (Read-Only) | `No` (Exclusion) | `memory_grandfather_greenhouse` *(Ký ức nhà kính)* |
| `JournalEntry` | `Journal Module` | `Yes` (Read/Write)| `Yes` (Saved) | `Journal_WhiteLily_Unlocked` *(Trạng thái: Đã khám phá)* |
| `QuestDefinition` | `Quest Database` | `No` (Read-Only) | `No` (Exclusion) | `quest_first_harvest` *(Nhiệm vụ thu hoạch đầu tay)* |
| `QuestProgress` | `Quest System` | `Yes` (Read/Write)| `Yes` (Saved) | `Quest_FirstHarvest_Count` *(Tiến độ: 3/5 bông)* |
| `FestivalDefinition`| `Festival Database` | `No` (Read-Only) | `No` (Exclusion) | `festival_bloom_day` *(Cấu hình Lễ hội Hoa Xuân)* |
| `FestivalState` | `Festival System` | `Yes` (Read/Write)| `Yes` (Saved) | `Festival_BloomDay_Score` *(Điểm trưng bày: 450 pts)* |
| `WeatherState` | `Weather System` | `Yes` (Read/Write)| `Yes` (Saved) | `Current_Weather` *(Trạng thái: Mưa rào nhẹ trên kính)* |
| `PlayerData` | `GameManager` | `Yes` (Read/Write)| `Yes` (Saved) | `Player_Profile` *(Tên Mia, Tiền, Ngày thứ 14 Mùa Xuân)* |
| `AudioConfig` | `Audio Database` | `No` (Read-Only) | `No` (Exclusion) | `audio_layer_profile_forest` *(Cấu hình 7 tầng forest)* |
| `UIConfig` | `UI Database` | `No` (Read-Only) | `No` (Exclusion) | `ui_palette_parchment` *(Cấu hình màu nhám sồi)* |

---

## 4. Database Structure

Cây cấu trúc kiến trúc kho dữ liệu tĩnh (*Master Static Database Hierarchy*). Đây là cấu trúc phân bổ logic trong RAM sau khi `Boot Scene` hoàn tất việc nạp dữ liệu từ thư mục `Source/Data/`:

```text
GlobalDatabaseMaster (Single Source of Truth Repository)
│
├── FlowerDatabase
│   ├── [flower_white_lily] ───────► (Definition Schema: Rosa / Common / 300s / Chime SFX)
│   ├── [flower_blue_lavender] ────► (Definition Schema: Lavender / Calm / 450s / Breeze SFX)
│   └── [flower_golden_sunflower] ─► (Definition Schema: Sunflower / Rare / 600s / Harmonic)
│
├── NPCDatabase
│   ├── [npc_florist] ─────────────► (Data Schema: Schedule / Gift Preferences / Dialogue ID)
│   ├── [npc_mayor] ───────────────► (Data Schema: Schedule / Festival Duties / Dialogue ID)
│   └── [npc_librarian] ───────────► (Data Schema: Schedule / Botanical Books / Dialogue ID)
│
├── ItemDatabase
│   ├── [item_seed_white_lily] ────► (Definition Schema: Seed Type / Target Flower ID / Icon)
│   ├── [item_tool_watering_can] ──► (Definition Schema: Tool Type / Water Capacity / SFX)
│   └── [item_harvest_white_lily] ─► (Definition Schema: Flower Item / Base Value / Palette)
│
├── QuestDatabase
│   ├── [quest_first_harvest] ─────► (Definition Schema: Target ID / Target Count / Reward)
│   └── [quest_village_revival] ───► (Definition Schema: Multi-stage conditions / Memory Unlock)
│
├── FestivalDatabase
│   └── [festival_bloom_day] ──────► (Definition Schema: Season Day / Contest Rules / BGM Track)
│
├── MemoryDatabase
│   ├── [memory_grandfather_greenhouse] ► (Definition Schema: Trigger Condition / ASMR Audio List)
│   └── [memory_first_rain_drop] ───────► (Definition Schema: Trigger Condition / Sketch Texture)
│
├── LanguageOfFlowersDatabase
│   └── [lof_white_lily_meaning] ──► (Definition Schema: Meaning Text / Emotional Resonance Bonus)
│
├── AchievementDatabase
│   └── [achievement_first_bloom] ─► (Definition Schema: Condition Type / Badge Icon / Reward)
│
├── WeatherDatabase
│   └── [weather_profile_spring_rain] ► (Definition Schema: Rain VFX Cap / Glasshouse Audio Loop)
│
├── AudioDatabase
│   └── [audio_profile_village_day] ──► (Definition Schema: BGM Track / Ambient Layers / Ducking)
│
└── UIDatabase
    └── [ui_profile_journal_spread] ──► (Definition Schema: Parchment Texture / Wood Frame / Font)
```

---

## 5. Runtime Objects Flow

Minh họa chuỗi chuyển hóa dữ liệu động theo thời gian thực (*Authoritative Runtime State Transformation Chain*), từ lúc hạt giống nằm trong bộ nhớ tĩnh cho đến khi trở thành một ký ức vĩnh cửu trong Save File:

```text
┌────────────────────────────────────────────────────────────────────────┐
│ 1. [FlowerDefinition] (Static Read-Only Database)                      │
│    ID: `flower_white_lily` | Base Growth Time: `300s` | Rarity: `Common`│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Player gieo hạt xuống đất)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 2. [FlowerInstance] (Runtime Scene Entity)                             │
│    InstanceID: `542` | RefID: `flower_white_lily` | CurrentStage: `1/4`│
│    IsWatered: `true` | ElapsedTime: `120s` | SoilGridX: `12` | Y: `34` │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Đạt 300s ➔ Nở hoàn hảo ➔ Thu hoạch)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. [Harvest & Mutation Calculation] (Flower System Execution)          │
│    Tính toán di truyền `Bloom Resonance` ➔ Sinh ra Item thực thể       │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Thêm vào Satchel)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 4. [InventoryItem / InventorySlot] (Runtime Inventory State)           │
│    SlotID: `03` | ItemRefID: `item_harvest_white_lily` | StackCount:`1`│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát Signal `FlowerBloomed`)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 5. [JournalEntry] (Runtime Bloom Journal State)                        │
│    PageID: `flower_white_lily` | Status: `Unlocked` | DiscoveryDate:D14│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Chu kỳ tự động lặp lại / Đêm ngủ)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 6. [Save File (`player_save.json`)] (Persistent Storage Layer)         │
│    Serialize toàn bộ: `FlowerInstances`, `InventorySlots`, `Journal`   │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 6. ID Convention

Khóa định dạng định danh cho toàn bộ khóa chính (`Primary Keys / IDs`) trong mọi database và schema. ID là định danh duy nhất giúp các module giao tiếp với nhau qua sự kiện mà không bị nhầm lẫn.

### 6.1. Quy Định Định Danh Bất Biến (`Strict ID Constraints`)
1. **ID là bất biến (`Immutable IDs`):** Một khi ID đã được chốt và đưa vào production, **nghiêm cấm mọi hành vi sửa đổi, đổi tên hay rút gọn** vì sẽ làm đứt gãy toàn bộ quan hệ khóa ngoại (`Foreign Keys`) trong save file và event sheet.
2. **Nghiêm cấm trùng lặp (`Absolute Uniqueness`):** Không được phép có 2 object khác domain mang cùng ID (ví dụ cấm hoa và vật phẩm cùng đặt là `white_lily`).
3. **Nghiêm cấm khoảng trắng (`No Whitespace`):** Luôn kết nối bằng dấu gạch dưới `_`.
4. **Nghiêm cấm tiếng Việt có dấu / Ký tự phi ASCII (`Strict ASCII Lowercase`):** Chỉ chấp nhận `[a-z0-9_]`.

### 6.2. Bảng Tiêu Chuẩn Prefix ID Định Danh (`Authoritative Prefix Table`)

| Domain / Nhóm Dữ Liệu | Chuẩn Prefix Bắt Buộc | Ví dụ Định Danh Hợp Lệ (`REQUIRED`) | Ví dụ Định Danh Bị Cấm (`FORBIDDEN`) |
| --- | --- | --- | --- |
| **Loài Hoa (`FlowerDefinition`)** | `flower_` | `flower_white_lily`<br>`flower_blue_lavender` | `WhiteLily`<br>`lily_01`<br>`hoa_bach_hop` |
| **Cư Dân (`NPCData`)** | `npc_` | `npc_mayor`<br>`npc_florist` | `Mayor`<br>`character_florist`<br>`truong_thon` |
| **Sự Kiện Lễ Hội (`Festival`)** | `festival_` | `festival_bloom_day`<br>`festival_harvest_moon` | `BloomDay`<br>`le_hoi_hoa`<br>`event_spring` |
| **Vật Phẩm (`ItemDefinition`)** | `item_` | `item_seed_white_lily`<br>`item_tool_watering_can` | `SeedWhiteLily`<br>`watering_can`<br>`vat_pham_1` |
| **Ký Ức (`PressedMemory`)** | `memory_` | `memory_grandfather_greenhouse`<br>`memory_first_rain_drop` | `GrandpaGreenhouse`<br>`ky_uc_ong`<br>`journal_mem_1` |
| **Thành Tựu (`Achievement`)** | `achievement_` | `achievement_first_bloom`<br>`achievement_legendary_garden` | `FirstBloom`<br>`trophy_01`<br>`thanh_tuu_1` |
| **Ngôn Ngữ Hoa (`LanguageOfFlowers`)**| `lof_` | `lof_white_lily_meaning`<br>`lof_rose_devotion` | `LilyMeaning`<br>`ngon_ngu_hoa`<br>`flower_text_1` |
| **Thời Tiết (`WeatherProfile`)** | `weather_` | `weather_profile_spring_rain`<br>`weather_profile_clear_sun` | `SpringRain`<br>`thoi_tiet_mua`<br>`rain_01` |

---

## 7. Field Naming Convention

Quy chuẩn đặt tên cho từng trường dữ liệu (*Field/Property*), biến cục bộ và cấu trúc đối tượng trong toàn bộ hệ thống code GDevelop và file JSON. Phân tách nhiệm vụ cho 3 định dạng chuẩn:

```text
┌───────────────────────────────┬───────────────────────────────┬───────────────────────────────┐
│     snake_case                │          camelCase            │         PascalCase            │
├───────────────────────────────┼───────────────────────────────┼───────────────────────────────┤
│ • JSON Schema Properties      │ • Runtime Local Variables     │ • Class / Schema Definitions  │
│ • Database Field Names        │ • Function Parameters         │ • Database System Names       │
│ • Authoritative IDs           │ • Temporary Counter Loop      │ • Global Manager Names        │
│ • Serialization Keys          │ • Event Sheet Local Scratch   │ • Behavior System Names       │
└───────────────────────────────┴───────────────────────────────┴───────────────────────────────┘
```

### 7.1. Bảng Chi Tiết Quy Nhận Định Dạng Field (`Field Style Guide`)

| Trường hợp áp dụng | Định dạng chuẩn | Giải thích lý do kỹ thuật | Ví dụ tiêu chuẩn mẫu (`REQUIRED`) |
| --- | --- | --- | --- |
| **JSON Properties & DB Fields** | `snake_case` | Đồng bộ hóa hoàn hảo với cấu trúc dữ liệu thô, dễ đọc khi debug JSON save file. | `flower_id`, `display_name`, `rarity`, `growth_stage`, `language_of_flowers`, `preferred_weather`, `bloom_time_seconds` |
| **Runtime Local Variables** | `camelCase` | Phân biệt rõ biến cục bộ trong Event Sheet/Code với trường dữ liệu tĩnh từ DB. | `currentGrowthDelta`, `targetFlowerInstance`, `playerCurrentGold`, `elapsedBloomTimer` |
| **Object Schemas & Classes** | `PascalCase` | Định danh các cấu trúc đối tượng cấp cao, các module và quản lý toàn cục. | `FlowerDefinition`, `FlowerInstance`, `NPCData`, `ScheduleManager`, `PressedMemory` |

---

## 8. Object Relationships Diagram

Sơ đồ mạng lưới quan hệ thực thể (*Entity-Relationship Network Map*), minh họa cách một cấu trúc dữ liệu gốc (`FlowerDefinition`) liên kết và chi phối toàn bộ 8 module hệ thống trong **Plant Tales**:

```text
                               ┌──────────────────────────┐
                               │     FlowerDefinition     │
                               │ (Static Read-Only Schema)│
                               └────────────┬─────────────┘
                                            │
                                            │ [Spawns via Seed Item]
                                            ▼
                               ┌──────────────────────────┐
                               │      FlowerInstance      │
                               │  (Runtime Scene Entity)  │
                               └────────────┬─────────────┘
                                            │
           ┌────────────────────────────────┼────────────────────────────────┐
           │ [Harvest Action]               │ [Discovery Signal]             │ [Check Requirements]
           ▼                                ▼                                ▼
┌──────────────────────────┐   ┌──────────────────────────┐   ┌──────────────────────────┐
│     InventoryModule      │   │       BloomJournal       │   │       QuestModule        │
│ (Satchel Grid: ItemDef)  │   │  (PageEntry: Unlocked)   │   │  (QuestProgress: +1 Hit) │
└──────────┬───────────────┘   └────────────┬─────────────┘   └──────────────────────────┘
           │                                │
           │ [Gift to NPC]                  │ [Trigger Milestone]
           ▼                                ▼
┌──────────────────────────┐   ┌──────────────────────────┐
│        NPCModule         │   │     PressedMemories      │
│ (Relationship: +Hearts)  │   │  (MemoryDef: Unlocked)   │
└──────────┬───────────────┘   └──────────────────────────┘
           │
           │ [Invite to Festival]
           ▼
┌──────────────────────────┐   ┌──────────────────────────┐
│      FestivalModule      │◄──┤  AchievementDatabase     │
│ (ContestScore: +Display) │   │ (AchievementDef: Badge)  │
└──────────────────────────┘   └──────────────────────────┘
```

---

## 9. Save Architecture

Kiến trúc lưu game (*Persistence Architecture*) của **Plant Tales** tuân thủ nguyên tắc **"Tối giản tuyệt đối — Chỉ lưu trạng thái thay đổi (`Minimal State Serialization`)"**.

### 9.1. Phân Định Chân Lý Save File (`What To Save vs What Not To Save`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   PERSISTENCE LAYER EXCLUSION POLICY                   │
├───────────────────────────────────┬────────────────────────────────────┤
│   EXCLUDED FROM SAVE FILE         │       MANDATORY IN SAVE FILE       │
│  (CẤM LƯU VÀO SAVE FILE JSON)     │       (BẮT BUỘC PHẢI SERIALIZE)    │
├───────────────────────────────────┼────────────────────────────────────┤
│ ❌ FlowerDefinition               │ ✅ PlayerData (Tên, Tiền, Ngày giờ)│
│ ❌ NPCData                        │ ✅ FlowerInstances (Tọa độ, Stage) │
│ ❌ QuestDefinition                │ ✅ NPCState (Vị trí, Lịch trình)   │
│ ❌ FestivalDefinition             │ ✅ Relationships (Số trái tim NPC) │
│ ❌ ItemDefinition                 │ ✅ Inventory (Danh sách ô Satchel) │
│ ❌ AudioConfig / UIConfig         │ ✅ QuestProgress (Tiến độ nhiệm vụ)│
│ ❌ WeatherProfile                 │ ✅ WeatherState (Thời tiết hiện tại)│
│ ❌ AchievementDefinition          │ ✅ Unlocked Journal Pages          │
└───────────────────────────────────┴────────────────────────────────────┘
```

- **Tại sao cấm lưu Static Definitions vào Save File?**  
  Nếu lưu toàn bộ thông số `FlowerDefinition` vào file save (`player_save.json`), khi chúng ta phát hành bản vá (*Patch update*) để cân bằng lại thời gian nở hoa từ `300s` sang `250s`, file save cũ của người chơi sẽ đè thông số `300s` cũ lên game mới, làm gãy toàn bộ bản update! Save File **chỉ được phép lưu con trỏ ID (`flower_id: flower_white_lily`)** và trạng thái runtime (`current_stage: 2`). Khi load game, hệ thống tự động ghép ID đó với `FlowerDefinition` mới nhất trong bộ nhớ.

---

## 10. AI Collaboration Rules (`GREEN vs RED`)

Bộ điều luật hiến pháp bắt buộc dành cho mọi AI Agent (Codex, Antigravity, Claude, ChatGPT) thao tác với cấu trúc dữ liệu và viết logic xử lý data cho dự án:

### 10.1. Đèn Xanh (`Authorized AI Actions` — ✅ GREEN LIGHT)
- ✅ **Được thêm dữ liệu mới đúng Schema:** Được phép tạo thêm file JSON định nghĩa hoa mới (`flower_definition_orchid.json`), NPC mới hay Item mới **nếu và chỉ nếu** tuân thủ 100% cấu trúc thuộc tính (*Property Keys*) đã khóa của Schema gốc.
- ✅ **Được thêm bản ghi vào Database:** Được phép bổ sung các dòng định nghĩa nhiệm vụ mới vào `QuestDatabase` hoặc thêm thành tựu mới vào `AchievementDatabase`.
- ✅ **Được đọc dữ liệu từ bất kỳ module nào:** Các logic behavior được tự do gọi hàm đọc thông số `GetDefinitionByID()` để phục vụ hiển thị VFX hay âm thanh.

### 10.2. Đèn Đỏ (`Strictly Forbidden AI Actions` — ❌ RED LIGHT)
- ❌ **Không được đổi Schema (`No Schema Mutation`):** Cấm tự ý sửa đổi kiểu dữ liệu (*Data Type*), cấm xóa field hay đổi tên thuộc tính có sẵn của `FlowerDefinition`, `NPCData`, `PressedMemory`.
- ❌ **Không được đổi ID (`No ID Renaming`):** Cấm sửa đổi ID `flower_white_lily` thành `flower_lily_01` trong bất kỳ ngữ cảnh nào.
- ❌ **Không được tự thêm field (`No Arbitrary Field Creation`):** Cấm tự ý chèn thêm các trường ngoài luồng như `ui_title`, `internal_code`, `custom_tag` vào Schema chuẩn.
- ❌ **Không được rename object (`No Object Renaming`):** Cấm gọi `FlowerInstance` là `PlantEntity` hay `ScheduleManager` là `RoutineSystem`.
- ❌ **Không được duplicate database (`No Database Duplication`):** Cấm tự ý sinh ra `FlowerDatabase2` hay `PlantCatalogTemp` để code tạm cho nhanh.

---

## 11. Future Expansion Strategy

Kiến trúc dữ liệu (`03_Data_Architecture.md`) được thiết kế với tầm nhìn mở rộng 5 năm cho studio, đảm bảo sẵn sàng tiếp nhận thêm 10 hệ thống gameplay tương lai mà **không bao giờ phải sửa đổi hay làm gãy Schema hiện có (`Zero Core Schema Breakage`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│ FUTURE MODULE     │ DATA ARCHITECTURAL INTEGRATION STRATEGY            │
├───────────────────┼────────────────────────────────────────────────────┤
│ Bee Keeping       │ Kế thừa `ItemDefinition` cho Mật ong (`item_honey`).│
│                   │ Đọc `FlowerInstance` xung quanh qua Signal mà không│
│                   │ cần chèn thêm thuộc tính vào `FlowerDefinition`.   │
├───────────────────┼────────────────────────────────────────────────────┤
│ Fishing Module    │ Kế thừa `ItemDefinition` cho Cá (`item_fish_salmon`)│
│                   │ Tự động nạp vào `JournalModule` qua External Page. │
├───────────────────┼────────────────────────────────────────────────────┤
│ Cooking Module    │ Kế thừa `ItemDefinition` cho Món ăn (`item_tea`).   │
│                   │ Đọc danh sách nguyên liệu từ `InventorySlot`.      │
├───────────────────┼────────────────────────────────────────────────────┤
│ Museum / Gallery  │ Lắng nghe Signal `OnFlowerBloomed` / `OnFishCaught`│
│                   │ Lưu trạng thái hiến tặng độc lập trong Save File.  │
├───────────────────┼────────────────────────────────────────────────────┤
│ Greenhouse Upgrade│ Lưu cấp độ nhà kính trong `PlayerData.greenhouse_lvl`│
│                   │ Mở rộng hệ số `GrowthMultiplier` toàn cục lúc runtime│
├───────────────────┼────────────────────────────────────────────────────┤
│ Mod Support       │ Hệ thống nạp External JSON Schemas từ thư mục Mod, │
│                   │ tự động validate ID theo đúng chuẩn `flower_mod_*`.│
└───────────────────┴────────────────────────────────────────────────────┘
```

---

## 12. Master Architecture Diagram

Sơ đồ ASCII tổng thể kiến trúc dữ liệu toàn cục cấp studio (*Studio-grade Master Data Architecture Backbone*), minh họa mạng lưới kết nối thẩm thấu từ bàn phím người chơi qua hệ thống thực vật, túi đồ, nhật ký cho đến khi đóng gói vào Save File và phát âm thanh/hiệu ứng ra màn hình:

```text
                               ┌──────────────────────────┐
                               │   PLAYER INPUT & ACTION  │
                               │  (Click Grid / Use Tool) │
                               └────────────┬─────────────┘
                                            │
                                            ▼
                               ┌──────────────────────────┐
                               │  INTERACTION & GAMEPLAY  │
                               │  (Validate & Call System)│
                               └────────────┬─────────────┘
                                            │
                    ┌───────────────────────┴───────────────────────┐
                    ▼                                               ▼
┌───────────────────────────────────────┐       ┌───────────────────────────────────────┐
│        FLOWER SYSTEM EXECUTION        │       │          NPC SYSTEM EXECUTION         │
│  (Read Database ➔ Mutate Instance)    │       │   (Read Schedule ➔ Update Dialogue)   │
└───────────────────┬───────────────────┘       └───────────────────┬───────────────────┘
                    │                                               │
        ┌───────────┴───────────┐                       ┌───────────┴───────────┐
        ▼                       ▼                       ▼                       ▼
┌───────────────┐       ┌───────────────┐       ┌───────────────┐       ┌───────────────┐
│FLOWER DATABASE│       │FLOWER INSTANCE│       │  NPC DATABASE │       │   NPC STATE   │
│(Static ReadOnly)      │(Runtime Mutate)│      │(Static ReadOnly)      │(Runtime Mutate)│
└───────────────┘       └───────┬───────┘       └───────────────┘       └───────┬───────┘
                                │                                               │
                                ├──────────────────────────┬────────────────────┘
                                ▼                          ▼
                        ┌───────────────┐          ┌───────────────┐
                        │INVENTORY GRID │          │ RELATIONSHIPS │
                        │ (Satchel Slot)│          │ (+Heart Points)│
                        └───────┬───────┘          └───────┬───────┘
                                │                          │
                                ▼                          ▼
                        ┌──────────────────────────────────────────┐
                        │              BLOOM JOURNAL               │
                        │    (Discovery Pages & Pressed Memories)  │
                        └───────────────────┬──────────────────────┘
                                            │
                      ┌─────────────────────┼─────────────────────┐
                      ▼                     ▼                     ▼
              ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
              │FESTIVAL MODULE│     │ AUDIO SYSTEM  │     │ PRESENTATION  │
              │(Contest Score)│     │(Micro Chimes) │     │  (Botanical UI)│
              └───────────────┘     └───────────────┘     └───────────────┘
                                            │
                                            ▼
                        ┌──────────────────────────────────────────┐
                        │        PERSISTENCE SAVE LAYER            │
                        │    (player_save.json Minimal Serialization)│
                        └──────────────────────────────────────────┘
```

---

## Appendix A: Immutable Rules Summary

1. **Rule 01 (No Schema Mutation):** Không một thuộc tính hay trường dữ liệu nào trong các Schema tĩnh (`FlowerDefinition`, `NPCData`, `PressedMemory`) được phép bị thay đổi hoặc xóa bỏ sau khi đã khóa `Approved`.
2. **Rule 02 (ID Authoritative Uniqueness):** Khóa chính ID là bất biến, duy nhất và phải bắt đầu bằng prefix chuẩn `flower_`, `npc_`, `item_`, `memory_`, `quest_`, `festival_`.
3. **Rule 03 (Zero Static Persistence):** Tuyệt đối không lưu các tệp tin cấu hình tĩnh (`FlowerDefinition`, `NPCData`) vào bên trong Save File `player_save.json`. Chỉ lưu con trỏ ID và trạng thái runtime.
4. **Rule 04 (Single Source of Truth):** Không tồn tại cấu trúc dữ liệu trùng lặp. Mọi logic đọc thông số hoa phải truy xuất qua `FlowerDatabase`.
5. **Rule 05 (Data Decoupling):** Logic GDevelop và code tuyệt đối không viết hardcode các chỉ số sinh trưởng. Toàn bộ thông số phải đọc từ Schema JSON.

---

## Appendix B: AI Checklist

Trước khi hoàn tất bất kỳ Pull Request hoặc thay đổi mã nguồn nào, AI Coding Agents (`Codex`, `Antigravity`) phải thực hiện kiểm chứng toàn bộ 6 mục kiểm tra sau:

- [ ] **1. Schema Validation:** Đã xác minh rằng không tự ý chèn trường mới (`No Arbitrary Fields`) vào `FlowerDefinition` hay `NPCData`?
- [ ] **2. ID Convention Check:** Đã đảm bảo ID mới tạo tuân thủ chính xác prefix chuẩn (`flower_*, npc_*, item_*`) toàn chữ thường `snake_case` không khoảng trắng?
- [ ] **3. Field Style Check:** Đã sử dụng `snake_case` cho thuộc tính JSON/DB, `camelCase` cho biến runtime cục bộ và `PascalCase` cho tên Class/Schema?
- [ ] **4. Read-Only Enforcement:** Đã kiểm tra logic mới không thực hiện lệnh gán (`Write/Assignment`) lên các object thuộc Static Database (`FlowerDefinition`)?
- [ ] **5. Persistence Safety:** Đã đảm bảo Save System chỉ bóc tách Runtime Data (`FlowerInstance`, `InventorySlot`) mà bỏ qua toàn bộ Static Definitions?
- [ ] **6. No Hallucinated Classes:** Đã kiểm chứng rằng không tự sinh ra class rác bị trùng (`FlowerData`, `PlantSystem`, `MemoryBlueprint`) nằm ngoài tài liệu này?

---

## Appendix C: Production Checklist & Status

- [x] Thiết lập triết lý dữ liệu tối cao (`Everything is Data`, `Single Source of Truth`).
- [x] Phân chia rạch ròi dữ liệu tĩnh `Static Read-Only` và dữ liệu động `Runtime Mutable`.
- [x] Lập bảng hiến pháp chủ quyền cho toàn bộ thực thể `Authoritative Objects Table`.
- [x] Thiết kế cây kiến trúc 11 kho dữ liệu tĩnh `Master Static Database Structure`.
- [x] Chuỗi chuyển hóa dữ liệu thời gian thực `Runtime Objects Transformation Flow`.
- [x] Chuẩn hóa ID prefix bất biến (`flower_*, npc_*, memory_*`) và quy ước đặt tên `snake_case / camelCase / PascalCase`.
- [x] Sơ đồ mạng lưới quan hệ thực thể và chính sách loại trừ Save File (`Exclusion Policy`).
- [x] Thiết lập bảng điều luật hợp tác AI `GREEN vs RED LIGHT` và chiến lược mở rộng tương lai 5 năm.
- [x] Sơ đồ ASCII Master Architecture Backbone toàn cục nối liền Player đến Save File.

**Status: Approved**
