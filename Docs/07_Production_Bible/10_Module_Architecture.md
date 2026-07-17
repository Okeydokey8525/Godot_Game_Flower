# Module Contracts Specification & Architecture Boundaries

**Đặc tả hợp đồng kiến trúc module, ranh giới dữ liệu, ma trận tín hiệu toàn cục và hướng dẫn mở rộng hệ thống (`Module Contracts Specification Document`) cho dự án Plant Tales.**

---

## 1. Module Contract Philosophy (`The Architecture Constitution`)

Tài liệu **Module Architecture (`10_Module_Architecture.md`)** được ban hành là **Bản Hợp Đồng Kiến Trúc Tối Cao (*The Software Architecture Contract*)** ràng buộc ranh giới, quyền sở hữu dữ liệu và luồng giao tiếp giữa tất cả các hệ thống trong game **Plant Tales**.

Trong một dự án game phát triển bằng **GDevelop 5** với sự tham gia song song của nhiều AI Agent (`Codex`, `Claude`, `ChatGPT`, `Antigravity`), nếu không có các hợp đồng module rõ ràng, AI sẽ dễ dàng tạo ra những sự phụ thuộc chéo hỗn loạn (*Spaghetti Interdependencies*): ví dụ `UI Satchel` trực tiếp sửa đổi biến sinh trưởng của `FlowerInstance`, hay `NPC System` tự ý ghi đĩa file `save.json`.

Để ngăn chặn triệt để tình trạng này, Hiến pháp Module áp đặt 4 quy tắc ranh giới bất khả xâm phạm:

```text
• Strict Data Ownership      (Mỗi module sở hữu độc quyền cấu trúc dữ liệu và instance của mình; các module khác chỉ được đọc qua API/Signal)
• Zero Direct Cross-Writes   (Nghiêm cấm Module A chỉnh sửa biến nội bộ của Module B; mọi yêu cầu phải đi qua Signal Bus hoặc Public API)
• Explicit Lifecycle Hooks   (Mọi module phải khởi tạo, chạy runtime và dọn dẹp theo chu kỳ Engine Boot / Scene Loop / Shutdown)
• Contract-First Extension   (Khi AI muốn mở rộng tính năng mới, phải khai báo Hợp Đồng Module trước khi sinh ra bất kỳ khối Event nào)
```

### 1.1. Chuẩn Mực Cấu Trúc Hợp Đồng 13 Mục (`Standard 13-Section Contract Structure`)
Mỗi Core Module trong hệ sinh thái Plant Tales được định nghĩa chuẩn xác theo biểu mẫu 13 mục:
1. **Purpose:** Vai trò cốt lõi và sứ mệnh của module.
2. **Responsibilities:** Danh sách trách nhiệm kỹ thuật cụ thể.
3. **Owns:** Định nghĩa dữ liệu tĩnh (`Schemas`) và đối tượng động (`Instances`) mà module độc quyền sở hữu.
4. **Reads:** Các dữ liệu của module khác được phép đọc tham chiếu (`Read-only`).
5. **Writes:** Các dữ liệu được phép ghi sửa (`Strictly self-owned only`).
6. **Publishes:** Danh sách các sự kiện (`Signals`) phát ra Global Signal Bus.
7. **Consumes:** Danh sách các sự kiện (`Signals`) lắng nghe từ Global Signal Bus.
8. **Dependencies:** Các module phụ thuộc trực tiếp theo chuỗi phân tầng.
9. **Public API:** Các hàm/sự kiện bên ngoài được phép gọi để tương tác.
10. **Forbidden:** Giới hạn đỏ nghiêm cấm xâm phạm.
11. **Performance Budget:** Ngân sách CPU/RAM riêng biệt cho module.
12. **Lifecycle:** Vòng đời khởi động, runtime và kết nối Save/Load.
13. **AI Extension Rules:** Quy chuẩn mở rộng an toàn dành cho AI Agents.

---

## 2. Core Module 01: Flower Module (`Greenhouse & Botany Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        FLOWER MODULE CONTRACT                          │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý lưới nhà kính, vòng đời thực vật và thuật toán di truyền.│
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý toàn bộ hệ sinh thái thực vật trong Nhà kính (`GreenhouseScene`), từ hạt mầm đến khi thu hoạch, bao gồm độ ẩm ô đất và lai tạo di truyền.
- **2. Responsibilities:**
  - Nạp cấu trúc tĩnh từ `flower_definition_*.json`.
  - Quản lý lưới đất trồng `GreenhouseGrid (20x20)`.
  - Tính toán tiến trình sinh trưởng dựa trên kim đồng hồ (`TimeTicker`) và độ ẩm.
  - Xử lý thuật toán lai tạo (`Cross-Pollination Engine`) khi 2 hoa liền kề nở rộ.
  - Phục vụ thu hoạch và giải phóng ô đất.
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `FlowerDefinition` schema (`flower_id`, `name`, `stages`, `base_growth_time`, `rarity`).
  - Đối tượng runtime: `FlowerInstance` (`instance_id`, `flower_ref_id`, `grid_x`, `grid_y`, `stage`, `moisture_level`, `accumulated_minutes`).
  - Lưới đất trồng: `GridSlotInstance` (`grid_x`, `grid_y`, `state: Dry/Wet/Occupied`).
- **4. Reads (`Read-only from upstream`):**
  - `TimeTicker.current_minutes`, `TimeTicker.is_paused`.
  - `WeatherModule.current_weather_profile`, `WeatherModule.is_raining`.
- **5. Writes (`Strictly self-owned only`):**
  - Thuộc tính nội bộ của `FlowerInstance` và `GridSlotInstance`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `FlowerPlanted (flower_id, grid_x, grid_y)`
  - `FlowerWatered (flower_id, grid_x, grid_y, new_moisture)`
  - `FlowerStageAdvanced (flower_id, grid_x, grid_y, old_stage, new_stage)`
  - `FlowerBloomed (flower_id, grid_x, grid_y, rarity)`
  - `FlowerHarvested (flower_id, grid_x, grid_y, yield_qty, is_hybrid)`
  - `HybridMutationOccurred (parent_id_1, parent_id_2, hybrid_seed_id, grid_x, grid_y)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `TimeMinuteTicked (delta_minutes)` ➔ Kích hoạt vòng lặp trừ độ ẩm và tăng `accumulated_minutes`.
  - `WeatherChanged (new_weather)` ➔ Nếu `new_weather == Rain`, tự động gán `moisture_level = 100%` cho hoa ngoài trời.
  - `InputInteractGrid (grid_x, grid_y, equipped_item)` ➔ Xử lý trồng, tưới hoặc thu hoạch.
- **8. Dependencies:**
  - **Upstream (`Phụ thuộc vào`):** `TimeTicker Singleton`, `WeatherModule`.
  - **Downstream (`Được phụ thuộc bởi`):** `InventoryModule`, `JournalModule`, `QuestModule`.
- **9. Public API (`External Callable Functions`):**
  - `FlowerModule_GetInstanceAt(grid_x, grid_y)` ➔ trả về `FlowerInstance` DTO hoặc `null`.
  - `FlowerModule_IsGridSlotEmpty(grid_x, grid_y)` ➔ boolean.
  - `FlowerModule_PlantSeed(flower_id, grid_x, grid_y)` ➔ boolean (`SUCCESS/FAIL`).
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tự ý cộng vật phẩm trực tiếp vào Satchel khi thu hoạch (`Must emit FlowerHarvested`).
  - ❌ Cấm truy xuất trực tiếp các biến UI hay thay đổi text trên HUD.
  - ❌ Cấm mở file I/O hoặc gọi `SaveManager.Serialize()` từ bên trong hàm sinh trưởng (`Check frame`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 3.5 ms` cho toàn bộ vòng lặp kiểm tra 500 hoa (áp dụng Time-slicing).
  - **RAM Allocation:** `< 120 MB` cho 1,000 `FlowerInstance` pool.
- **12. Lifecycle:**
  - **Boot:** Nạp `flower_definition_*.json` vào bộ nhớ đệm `FlowerCatalog`.
  - **Scene Load:** Nạp mảng `FlowerInstance` từ DTO do `SaveManager` cung cấp, phân bổ lên lưới Grid.
  - **Runtime:** Lắng nghe `TimeMinuteTicked`, xử lý sinh trưởng theo batch.
  - **Save Hook:** Khi `SaveManager` gọi `OnBeforeSave`, trả về mảng `FlowerInstance DTO` sạch.
- **13. AI Extension Rules:**
  - Khi thêm giai đoạn sinh trưởng mới hoặc thông số sâu (`Pest/Sâu bệnh`), buộc phải mở rộng schema `FlowerInstance` ở `03_Data_Architecture.md` trước. Luôn phát tín hiệu mới qua Signal Bus thay vì gọi trực tiếp sang các module khác.

---

## 3. Core Module 02: Inventory Module (`Satchel Economy Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      INVENTORY MODULE CONTRACT                         │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý Satchel 20 ô, xếp chồng vật phẩm và kinh tế người chơi.│
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý kho đồ Satchel của người chơi, xử lý việc cất trữ, xếp chồng (`Stacking`), tiêu thụ vật phẩm và bảo đảm tính toàn vẹn kinh tế (`Gold balance`).
- **2. Responsibilities:**
  - Quản lý mảng 20 ô chứa (`InventorySlot Matrix`).
  - Xử lý thuật toán xếp chồng tự động (tối đa `99 item/stack`).
  - Quản lý ví tiền của người chơi (`Gold currency`).
  - Kiểm tra và xử lý chống tràn kho (`Overflow Protection`).
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `ItemDefinition` (`item_id`, `category: Seed/Flower/Tool/Key`, `max_stack`, `sell_price`).
  - Đối tượng runtime: `InventorySlot` (`slot_index: 0-19`, `item_id`, `quantity`).
  - Ví tiền: `PlayerEconomy` (`gold: Integer`).
- **4. Reads (`Read-only from upstream`):**
  - `FlowerCatalog.GetDefinition(item_id)` để lấy giá bán và tên hiển thị.
- **5. Writes (`Strictly self-owned only`):**
  - Thuộc tính `item_id` và `quantity` của mảng `InventorySlot [0..19]`.
  - Biến `PlayerEconomy.gold`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `InventoryItemAdded (item_id, added_qty, new_total_qty, slot_index)`
  - `InventoryItemConsumed (item_id, consumed_qty, remaining_qty, slot_index)`
  - `InventoryFull (item_id, rejected_qty)`
  - `GoldBalanceChanged (old_gold, new_gold, delta)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `FlowerHarvested (flower_id, yield_qty)` ➔ Tự động chuyển đổi `flower_id` thành `item_flower_*` và thêm vào Satchel.
  - `HybridMutationOccurred (hybrid_seed_id)` ➔ Thêm `hybrid_seed_id` vào Satchel.
  - `NPCGiftAccepted (gift_item_id)` ➔ Trừ 1 số lượng vật phẩm trong kho.
  - `ShopItemPurchased (item_id, cost_gold, qty)` ➔ Trừ tiền và thêm vật phẩm vào Satchel.
- **8. Dependencies:**
  - **Upstream:** `EventBus Singleton`.
  - **Downstream:** `UI Presentation (Satchel Sheet)`, `ShopModule`.
- **9. Public API (`External Callable Functions`):**
  - `InventoryModule_HasItem(item_id, required_qty)` ➔ boolean.
  - `InventoryModule_AddItem(item_id, qty)` ➔ Integer (`Number of items actually added`).
  - `InventoryModule_ConsumeItem(item_id, qty)` ➔ boolean (`SUCCESS/FAIL`).
  - `InventoryModule_GetGold()` ➔ Integer.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm truy cập trực tiếp vào `FlowerInstance` trên sân để xóa hoa khi thu hoạch.
  - ❌ Cấm tự ý sinh ra vật phẩm từ hư vô nếu không có tín hiệu hợp lệ từ `Harvest`, `Shop` hay `Quest`.
  - ❌ Cấm cho phép biến `gold` hoặc `quantity` rơi vào giá trị âm (`Negative integer protection`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 1.0 ms` cho mỗi thao tác quét và cập nhật 20 ô Satchel.
  - **RAM Allocation:** `< 10 MB` cho toàn bộ kho dữ liệu vật phẩm và cache.
- **12. Lifecycle:**
  - **Boot:** Nạp `item_catalog_*.json` vào bộ nhớ đọc tĩnh.
  - **Scene Load:** Khôi phục mảng `20 InventorySlot` và biến `gold` từ Save DTO.
  - **Save Hook:** Xuất mảng 20 ô gọn gàng (`bỏ qua ô trống rỗng`) cho `SaveManager`.
- **13. AI Extension Rules:**
  - Khi thêm kho đồ rương chứa (`Storage Chest 50 ô`), AI phải tạo class kế thừa hoặc instance mới của `InventoryContainer`, cấm can thiệp làm hỏng logic mảng 20 ô cơ bản của `Satchel`.

---

## 4. Core Module 03: NPC Module (`Townsfolk & Dialogue Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                         NPC MODULE CONTRACT                            │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý cư dân thị trấn, hội thoại, lịch trình và độ thân thiện.│
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý trí tuệ, lịch trình di chuyển theo giờ (`AI Schedules`), hệ thống hội thoại và điểm thân thiện (`Heart Points`) cho các cư dân trong thị trấn.
- **2. Responsibilities:**
  - Nạp thông tin tĩnh và cây hội thoại từ `npc_definition_*.json` và `dialogue_trees.json`.
  - Điều khiển di chuyển theo đường đi (`Pathfinding Routine`) dựa trên kim đồng hồ `TimeTicker`.
  - Xử lý hệ thống tặng quà (`Gift Giving Mechanics`) và tính toán sở thích (`Loved/Liked/Hated`).
  - Quản lý trạng thái quan hệ người chơi (`Heart Points [0..1000]`).
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `NPCDefinition` (`npc_id`, `name`, `loved_items`, `hated_items`, `schedule_profile`).
  - Đối tượng runtime: `NPCInstance` (`npc_id`, `current_scene`, `pos_x`, `pos_y`, `current_action`, `heart_points`, `talked_today: boolean`, `gifted_today: boolean`).
- **4. Reads (`Read-only from upstream`):**
  - `TimeTicker.current_hour`, `TimeTicker.current_minute`, `TimeTicker.current_day`.
  - `WeatherModule.current_weather` (để NPC đổi lịch trình trú mưa).
  - `InventoryModule_HasItem(item_id)` (kiểm tra quà tặng).
- **5. Writes (`Strictly self-owned only`):**
  - Thuộc tính tọa độ `pos_x`, `pos_y`, trạng thái di chuyển, `heart_points` và cờ `talked_today/gifted_today` của `NPCInstance`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `NPCTalked (npc_id, dialogue_node_id)`
  - `NPCGiftReceived (npc_id, item_id, reaction_type: Loved/Liked/Hated, heart_points_delta)`
  - `NPCHeartLevelUp (npc_id, old_level, new_level)`
  - `NPCScheduleStateChanged (npc_id, old_state, new_state, destination_scene)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `TimeMinuteTicked (delta)` ➔ Kiểm tra lịch trình, nếu tới giờ chuyển địa điểm thì kích hoạt `Pathfinding`.
  - `DayAdvanced (new_day)` ➔ Reset cờ `talked_today = false` và `gifted_today = false` cho toàn bộ NPC.
  - `InputInteractNPC (npc_id, action_type, parameter)` ➔ Kích hoạt hội thoại hoặc nhận quà.
- **8. Dependencies:**
  - **Upstream:** `TimeTicker Singleton`, `WeatherModule`.
  - **Downstream:** `QuestModule`, `UI Presentation (Dialogue Box HUD)`.
- **9. Public API (`External Callable Functions`):**
  - `NPCModule_GetHeartPoints(npc_id)` ➔ Integer.
  - `NPCModule_GetNPCLocation(npc_id)` ➔ Object (`scene_name, x, y`).
  - `NPCModule_TriggerDialogue(npc_id, dialogue_node_id)` ➔ boolean.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tự ý trực tiếp mở khung giao diện `DialogueBoxUI` từ code của NPC (`Must emit NPCTalked`).
  - ❌ Cấm sửa đổi trực tiếp Satchel khi nhận quà (`Must emit NPCGiftReceived and let Inventory consume`).
  - ❌ Cấm tính toán logic Pathfinding nặng nề trong Event `Every Frame` (`Must use time-sliced path updates`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 2.5 ms` cho toàn bộ quá trình duyệt pathfinding và AI của 10 NPC đồng thời.
  - **RAM Allocation:** `< 45 MB` cho dữ liệu sprite, animation states và bảng hội thoại.
- **12. Lifecycle:**
  - **Boot:** Nạp `npc_definition_*.json`.
  - **Scene Load:** Khôi phục `heart_points` và cờ hàng ngày từ Save DTO. Đặt NPC vào đúng tọa độ theo lịch trình hiện tại của `TimeTicker`.
  - **Save Hook:** Xuất `heart_points`, `talked_today`, `gifted_today` của từng `npc_id`.
- **13. AI Extension Rules:**
  - Khi thêm NPC mới (ví dụ `Bee Keeper`), chỉ cần tạo file `npc_definition_beekeeper.json` và đăng ký lịch trình mới vào `schedule_profile`. Cấm sửa đổi cốt lõi engine di chuyển chung `NPCScheduleManager`.

---

## 5. Core Module 04: Quest Module (`Botanical Errands & Progression Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        QUEST MODULE CONTRACT                           │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý nhiệm vụ, tiến độ câu chuyện và phần thưởng thị trấn. │
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý toàn bộ tuyến nhiệm vụ cốt truyện (`Main Quests`) và yêu cầu hàng ngày từ cư dân (`Daily Botanist Errands`), theo dõi tiến độ và cấp phát phần thưởng.
- **2. Responsibilities:**
  - Nạp danh sách nhiệm vụ từ `quest_definition_*.json`.
  - Lắng nghe các tín hiệu thu hoạch, giao thoại và thu thập để tự động cập nhật tiến độ (`Progress Tracking`).
  - Kiểm tra điều kiện hoàn thành (`Completion Validation`).
  - Phát tín hiệu trao thưởng khi người chơi nộp nhiệm vụ.
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `QuestDefinition` (`quest_id`, `title`, `objectives: []`, `rewards: []`, `prerequisite_quest_id`).
  - Đối tượng runtime: `QuestInstance` (`quest_id`, `status: Locked/Active/Completed`, `objective_progress: {obj_id: current_value}`).
- **4. Reads (`Read-only from upstream`):**
  - `InventoryModule_HasItem()` để xác minh điều kiện nộp vật phẩm.
  - `NPCModule_GetHeartPoints()` để kiểm tra điều kiện mở khóa nhiệm vụ thân thiện.
- **5. Writes (`Strictly self-owned only`):**
  - Trạng thái `status` và `objective_progress` của các `QuestInstance`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `QuestUnlocked (quest_id)`
  - `QuestAccepted (quest_id)`
  - `QuestProgressUpdated (quest_id, objective_id, current_val, target_val)`
  - `QuestCompleted (quest_id, rewards_list)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `FlowerHarvested (flower_id, qty)` ➔ Cập nhật objective nếu quest yêu cầu thu hoạch loại hoa tương ứng.
  - `InventoryItemAdded (item_id, qty)` ➔ Cập nhật objective nếu quest yêu cầu sở hữu item.
  - `NPCTalked (npc_id, dialogue_node_id)` ➔ Cập nhật objective giao tiếp hoặc trả nhiệm vụ.
  - `JournalEntryUnlocked (flower_id)` ➔ Cập nhật objective khám phá thực vật.
- **8. Dependencies:**
  - **Upstream:** `EventBus Singleton`, `InventoryModule`, `NPCModule`, `JournalModule`.
  - **Downstream:** `UI Presentation (Quest Tracker HUD / Journal Tracker)`.
- **9. Public API (`External Callable Functions`):**
  - `QuestModule_GetStatus(quest_id)` ➔ String (`Locked/Active/Completed`).
  - `QuestModule_IsObjectiveDone(quest_id, objective_id)` ➔ boolean.
  - `QuestModule_AcceptQuest(quest_id)` ➔ boolean.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tự ý gọi `SaveManager.Serialize()` mỗi khi tăng 1 đơn vị tiến độ nhiệm vụ (`Must only mark dirty`).
  - ❌ Cấm trực tiếp cộng tiền hay vật phẩm vào Satchel từ hàm hoàn thành nhiệm vụ (`Must emit QuestCompleted and let Inventory handle rewards`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 1.0 ms` (chỉ kích hoạt kiểm tra khi nhận được Signal từ EventBus, hoàn toàn zero frame-polling).
  - **RAM Allocation:** `< 15 MB`.
- **12. Lifecycle:**
  - **Boot:** Nạp `quest_definition_*.json`.
  - **Scene Load:** Khôi phục trạng thái nhiệm vụ từ Save DTO.
  - **Save Hook:** Xuất mảng các `QuestInstance` đang `Active` và `Completed`.
- **13. AI Extension Rules:**
  - Khi tạo nhiệm vụ mới, AI chỉ thêm chuỗi JSON vào `quest_definition_*.json`. Nếu objective thuộc loại hoàn toàn mới (ví dụ `PhotographFlower`), phải thêm bộ lắng nghe tín hiệu mới vào `QuestModule`, cấm viết code hard-code riêng lẻ cho từng ID nhiệm vụ.

---

## 6. Core Module 05: Journal Module (`Pressed Memory & Botanist Compendium`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                       JOURNAL MODULE CONTRACT                          │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý tiêu bản thực vật, thẻ ký ức ép hoa và bách khoa thư.  │
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý bách khoa toàn thư thực vật học (`Botanist Compendium`), lưu giữ các trang tiêu bản hoa đã khám phá và hệ thống thẻ ký ức ép hoa của ông nội (`Pressed Memory Cards`).
- **2. Responsibilities:**
  - Theo dõi trạng thái mở khóa của toàn bộ các loài hoa (`Silhouette -> Colored Compendium`).
  - Quản lý danh mục thẻ ký ức (`Memory Cards`) và kích hoạt cutscene ép hoa (`Epiphany Cutscene`).
  - Thống kê tổng số lượng hoa đã trồng và thu hoạch trong suốt lịch sử chơi.
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `CompendiumDefinition` (`flower_ref_id`, `lore_text`, `botanical_note`, `rarity_stars`).
  - Đối tượng runtime: `JournalEntryInstance` (`flower_ref_id`, `unlocked: boolean`, `first_discovered_day: Integer`, `total_harvested_count: Integer`).
  - Đối tượng ký ức: `MemoryCardInstance` (`memory_id`, `unlocked: boolean`, `unlocked_day: Integer`).
- **4. Reads (`Read-only from upstream`):**
  - `FlowerCatalog.GetDefinition(flower_ref_id)` để lấy thông tin hiển thị.
  - `TimeTicker.current_day` để ghi nhận ngày phát hiện.
- **5. Writes (`Strictly self-owned only`):**
  - Trạng thái `unlocked`, `first_discovered_day` và `total_harvested_count` của `JournalEntryInstance`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `JournalEntryUnlocked (flower_ref_id, rarity_stars)`
  - `JournalCountUpdated (flower_ref_id, new_total_count)`
  - `MemoryCardUnlocked (memory_id, title)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `FlowerHarvested (flower_id, qty, is_hybrid)` ➔ Nếu `JournalEntry.unlocked == false`, kích hoạt mở khóa tiêu bản mới (`JournalEntryUnlocked`). Tăng `total_harvested_count += qty`.
  - `MemoryEpiphanyTriggered (memory_id)` ➔ Mở khóa thẻ ký ức tương ứng.
- **8. Dependencies:**
  - **Upstream:** `EventBus Singleton`, `FlowerModule`.
  - **Downstream:** `UI Presentation (Journal Book UI / Epiphany Alert Overlay)`.
- **9. Public API (`External Callable Functions`):**
  - `JournalModule_IsUnlocked(flower_ref_id)` ➔ boolean.
  - `JournalModule_GetDiscoveredCount()` ➔ Integer (`Total unique blooms discovered`).
  - `JournalModule_GetTotalHarvested(flower_ref_id)` ➔ Integer.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tự ý can thiệp hay thay đổi thông số sinh trưởng của hoa từ bên trong sách Nhật ký.
  - ❌ Cấm render giao diện sách 3D nặng nề ngay khi boot game (`Must lazy-load Journal UI only when opened`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 0.5 ms` runtime (chỉ xử lý khi có tín hiệu `FlowerHarvested`).
  - **RAM Allocation:** `< 25 MB` (bao gồm texture tiêu bản độ phân giải cao nạp dạng Lazy).
- **12. Lifecycle:**
  - **Boot:** Khởi tạo danh mục `JournalEntryInstance` tĩnh với trạng thái `unlocked = false`.
  - **Scene Load:** Khôi phục trạng thái mở khóa từ Save DTO.
  - **Save Hook:** Xuất danh sách các ID hoa và thẻ ký ức đã mở khóa.
- **13. AI Extension Rules:**
  - Khi thêm trang nhật ký cho loài hoa mới, AI chỉ cần bổ sung vào `compendium_definition_*.json`. Hệ thống tự động tạo mục mới, cấm viết thêm code Event riêng cho loài hoa mới.

---

## 7. Core Module 06: Weather Module (`Atmosphere & Spring Rain Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                       WEATHER MODULE CONTRACT                          │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý chu kỳ thời tiết, tự động làm ẩm đất và môi trường sim.│
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý hệ thống thời tiết động (`Dynamic Weather`), thay đổi khí hậu theo mùa, tự động tác động đến độ ẩm của khu vườn và điều phối bầu không khí nghe nhìn.
- **2. Responsibilities:**
  - Lập lịch thời tiết mỗi buổi sáng ngày mới (`Sunny`, `Spring Rain`, `Morning Fog`).
  - Phát tín hiệu thời tiết để `FlowerModule` tự động tưới đất (`Moisture -> 100%`) khi có mưa rào.
  - Điều phối chuyển màu môi trường (`Color Tint`) và cường độ hạt mưa (`VFX Rain Particles`).
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `WeatherProfile` (`weather_id`, `name`, `moisture_modifier`, `light_tint_color`, `bgm_ambience_id`).
  - Đối tượng runtime: `WeatherState` (`current_weather_id`, `duration_remaining_minutes`, `is_raining: boolean`).
- **4. Reads (`Read-only from upstream`):**
  - `TimeTicker.current_day`, `TimeTicker.current_season`.
- **5. Writes (`Strictly self-owned only`):**
  - Trạng thái `current_weather_id` và biến thời gian của `WeatherState`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `WeatherChanged (old_weather_id, new_weather_id, is_raining)`
  - `AtmosphereTintUpdateRequired (target_color_hex, transition_duration_sec)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `DayAdvanced (new_day)` ➔ Kích hoạt thuật toán gieo xúc xắc chọn hồ sơ thời tiết mới cho ngày hôm đó (`dựa trên DEBUG_SEED`).
  - `ConsoleCommandWeather (forced_weather_id)` ➔ Thay đổi thời tiết ngay lập tức phục vụ Debug F4.
- **8. Dependencies:**
  - **Upstream:** `TimeTicker Singleton`.
  - **Downstream:** `FlowerModule`, `NPCModule`, `AudioModule`, `UI Presentation (Atmosphere Overlay)`.
- **9. Public API (`External Callable Functions`):**
  - `WeatherModule_IsRaining()` ➔ boolean.
  - `WeatherModule_GetCurrentProfile()` ➔ `WeatherProfile` DTO.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm trực tiếp lặp qua mảng `FlowerInstance` để đổi biến `moisture_level` từ bên trong `WeatherModule` (`Must emit WeatherChanged and let FlowerModule handle its own plants`).
  - ❌ Cấm trực tiếp chỉnh sửa âm lượng loa (`Must emit WeatherChanged to AudioModule`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 0.5 ms` runtime.
  - **RAM Allocation:** `< 15 MB`.
- **12. Lifecycle:**
  - **Boot:** Nạp `weather_profiles.json`.
  - **Scene Load:** Khôi phục `current_weather_id` từ Save DTO, phát ngay tín hiệu `WeatherChanged` để đồng bộ toàn scene.
  - **Save Hook:** Xuất `current_weather_id` và thời gian còn lại.
- **13. AI Extension Rules:**
  - Khi thêm thời tiết mới (`Thunderstorm / Bão`), AI tạo profile mới trong JSON và định nghĩa thuộc tính `is_raining`. Cấm can thiệp trực tiếp vào logic sinh trưởng của `FlowerModule`.

---

## 8. Core Module 07: Audio Module (`Living Soundscape Engine`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        AUDIO MODULE CONTRACT                           │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý 3 lớp thanh âm (BGM, Ambience, SFX) và âm thanh sống. │
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Thực thi triết lý **Living Soundscape Philosophy (`08_Audio.md`)**, điều phối 3 lớp âm thanh song song (`Layered Audio Engine`) nhằm tạo cảm giác bình yên sâu sắc và hỗ trợ phản hồi nhịp điệu gameplay.
- **2. Responsibilities:**
  - Quản lý 3 kênh độc lập: `Base BGM Channel`, `Ambience Layer Channel (Gió/Mưa/Chim)` và `SFX Pool Channel`.
  - Thực hiện kỹ thuật giảm âm lượng mượt mà (`Audio Ducking`) cho BGM khi mở màn hình Nhật Ký hoặc có thoại NPC quan trọng.
  - Chuyển tiếp chéo (`Cross-fade`) âm nhạc và môi trường khi qua lại giữa `GreenhouseScene` và `VillageScene`.
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `AudioProfile` (`audio_id`, `layer_type: BGM/AMB/SFX`, `volume_base`, `loop: boolean`).
  - Đối tượng runtime: `AudioState` (`current_bgm_id`, `current_amb_id`, `master_volume`, `bgm_volume`, `sfx_volume`, `is_ducking: boolean`).
- **4. Reads (`Read-only from upstream`):**
  - `SaveManager.settings.volume_config` (khôi phục cài đặt âm lượng từ menu Option).
- **5. Writes (`Strictly self-owned only`):**
  - Trạng thái các kênh âm thanh và biến `volume` của `AudioState`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `AudioBGMCrossfadeStarted (from_id, to_id)`
  - `AudioSFXPlayed (sfx_id)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `SceneTransitionStarted (target_scene)` ➔ Cross-fade BGM phù hợp với scene mới.
  - `WeatherChanged (new_weather, is_raining)` ➔ Chuyển đổi Ambience Layer sang tiếng mưa rách róc hoặc gió nhẹ trời nắng.
  - `NPCTalked / JournalOpened` ➔ Kích hoạt `Audio Ducking` (giảm BGM xuống 50%).
  - `NPCGiftReceived / DialogueClosed / JournalClosed` ➔ Trả BGM về 100% âm lượng (`Unduck`).
  - Tất cả các sự kiện hành động (`FlowerWatered`, `FlowerHarvested`, `UIHover`) ➔ Phát `SFX Pool Channel`.
- **8. Dependencies:**
  - **Upstream:** `EventBus Singleton`, `WeatherModule`, `SaveManager`.
  - **Downstream:** `Hardware Sound Engine`.
- **9. Public API (`External Callable Functions`):**
  - `AudioModule_PlaySFX(sfx_id, pitch_variance)` ➔ void.
  - `AudioModule_SetMasterVolume(level_0_to_1)` ➔ void.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tạo thêm các đối tượng Audio/Music trôi nổi bên trong các Event Sheet gameplay (`All audio must route through AudioModule API or Signal Bus`).
  - ❌ Cấm load đồng thời quá 10 file nhạc BGM vào RAM cùng lúc (`Must stream or load on-demand`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 1.0 ms`.
  - **RAM Allocation:** `< 60 MB` cho toàn bộ đệm âm thanh tải sẵn (`Preloaded Audio Pool`).
- **12. Lifecycle:**
  - **Boot:** Nạp `AudioCatalog`, khởi tạo 3 kênh Audio của GDevelop.
  - **Scene Load:** Điều chỉnh BGM theo scene hiện tại.
  - **Save Hook:** Lưu cài đặt âm lượng `master/bgm/sfx` vào `settings.json` riêng.
- **13. AI Extension Rules:**
  - Khi thêm âm thanh mới, AI bổ sung vào `audio_profiles.json` và gọi phát thông qua `AudioModule_PlaySFX()` hoặc Signal, cấm dùng lệnh `Play Sound` trực tiếp trong GDevelop Event cơ bản.

---

## 9. Core Module 08: Festival Module (`Spring Bloom Celebration Core`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                       FESTIVAL MODULE CONTRACT                         │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: Quản lý sự kiện Lễ Hội Hoa Xuân Day 28, bàn trưng bày và chấm điểm.│
└────────────────────────────────────────────────────────────────────────┘
```
- **1. Purpose:** Quản lý sự kiện cao trào của chu kỳ mùa (`Season Climax`): **Lễ Hội Hoa Xuân (`Spring Bloom Festival — Day 28`)**, điều phối việc trưng bày hoa, chấm điểm thẩm mỹ theo độ hiếm và trao danh hiệu thị trấn.
- **2. Responsibilities:**
  - Theo dõi kim đồng hồ để tự động ngắt chu kỳ thường nhật và nạp trạng thái Lễ Hội khi bước vào `Day 28 (08:00 AM)`.
  - Quản lý Bàn Trưng Bày Hoa (`Festival Display Table Slots [0..2]`).
  - Chạy thuật toán chấm điểm Lễ Hội (`Festival Scoring Engine`) dựa trên sao độ hiếm, độ hoàn hảo của giai đoạn sinh trưởng và sở thích thị trấn.
  - Trao cúp và phần thưởng đặc biệt (`Festival Trophy & Rare Seeds`).
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `FestivalDefinition` (`festival_id: spring_bloom`, `target_day: 28`, `scoring_weights`, `reward_tiers`).
  - Đối tượng runtime: `FestivalState` (`is_active: boolean`, `display_slots: [FlowerInstance, FlowerInstance, FlowerInstance]`, `current_score: Integer`, `award_tier: Bronze/Silver/Gold`).
- **4. Reads (`Read-only from upstream`):**
  - `TimeTicker.current_day`, `TimeTicker.current_hour`.
  - `InventoryModule_HasItem()` để xác minh hoa người chơi mang ra bàn trưng bày.
- **5. Writes (`Strictly self-owned only`):**
  - Trạng thái `is_active`, `display_slots` và điểm số của `FestivalState`.
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `FestivalStarted (festival_id, day)`
  - `FestivalFlowerSubmitted (slot_index, flower_ref_id, added_score)`
  - `FestivalConcluded (festival_id, final_score, award_tier, rewards)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `DayAdvanced (new_day)` ➔ Nếu `new_day == 28`, kích hoạt `FestivalStarted`.
  - `InputInteractFestivalTable (slot_index, flower_item_id)` ➔ Nhận hoa từ Satchel đặt lên bàn trưng bày.
- **8. Dependencies:**
  - **Upstream:** `TimeTicker Singleton`, `InventoryModule`, `FlowerModule`.
  - **Downstream:** `AudioModule` (chuyển nhạc lễ hội), `NPCModule` (tập trung NPC ra quảng trường), `UI Presentation (Festival Scoreboard HUD)`.
- **9. Public API (`External Callable Functions`):**
  - `FestivalModule_IsActive()` ➔ boolean.
  - `FestivalModule_SubmitFlower(slot_index, flower_item_id)` ➔ boolean.
  - `FestivalModule_EvaluateScore()` ➔ Integer (`Total points`).
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ Cấm tự ý thay đổi tọa độ của NPC hoặc xóa hoa trong nhà kính trong ngày Lễ Hội (`Must emit FestivalStarted and let NPC/Flower modules handle their own responses`).
  - ❌ Cấm can thiệp trực tiếp vào file save để ghi thành tích Cúp (`Must emit FestivalConcluded and let SaveManager collect DTO`).
- **11. Performance Budget:**
  - **CPU Frame Time:** `< 1.5 ms` runtime khi sự kiện hoạt động.
  - **RAM Allocation:** `< 20 MB` cho cờ pháo hoa VFX và dữ liệu lễ hội.
- **12. Lifecycle:**
  - **Boot:** Nạp `festival_definition_*.json`.
  - **Scene Load:** Kiểm tra `TimeTicker.current_day == 28` để chuyển đổi `VillageScene` sang trang trí Lễ Hội.
  - **Save Hook:** Xuất cờ lịch sử `festivals_won: []` và điểm số cao nhất từng đạt được.
- **13. AI Extension Rules:**
  - Khi thêm Lễ Hội mới (`Autumn Harvest Day 56`), AI thêm profile vào `festival_definition_*.json`. Cấm sửa đổi core scoring engine cơ bản nếu không qua review kiến trúc.

---

## 10. Master Dependency Matrix (`Module Hierarchy Law`)

Bảng ma trận quy định phân tầng phụ thuộc kiến trúc (`Who can depend on whom`). Một module chỉ được phép gọi API hoặc phụ thuộc vào module nằm ở tầng dưới hoặc ngang hàng hợp lệ. **Nghiêm cấm mọi đường phụ thuộc ngược từ dưới lên trên!**

| Module (`Downstream \ Upstream`) | 01. Flower | 02. Inventory | 03. NPC | 04. Quest | 05. Journal | 06. Weather | 07. Audio | 08. Festival |
| --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **01. Flower** | — | ❌ | ❌ | ❌ | ❌ | 🟢 *(Reads)* | ❌ | ❌ |
| **02. Inventory** | 🟢 *(Reads Catalog)*| — | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **03. NPC** | ❌ | 🟢 *(Reads API)*| — | ❌ | ❌ | 🟢 *(Reads)* | ❌ | ❌ |
| **04. Quest** | 🟢 *(Reads)* | 🟢 *(Reads API)*| 🟢 *(Reads API)*| — | 🟢 *(Reads)*| ❌ | ❌ | ❌ |
| **05. Journal** | 🟢 *(Reads Catalog)*| ❌ | ❌ | ❌ | — | ❌ | ❌ | ❌ |
| **06. Weather** | ❌ | ❌ | ❌ | ❌ | ❌ | — | ❌ | ❌ |
| **07. Audio** | ❌ | ❌ | ❌ | ❌ | ❌ | 🟢 *(Reads)* | — | ❌ |
| **08. Festival** | 🟢 *(Reads API)*| 🟢 *(Reads API)*| ❌ | ❌ | ❌ | ❌ | ❌ | — |

*(🟢 `Allowed Read/API` | ❌ `Forbidden Dependency` | — `Self` | **Tất cả giao tiếp chéo khác phải đi qua Global Signal Bus!**)*

---

## 11. Master Ownership Matrix (`Data Boundary Law`)

Bảng ma trận xác định chủ sở hữu độc quyền (`Authoritative Owner`) cho từng trường dữ liệu tĩnh và đối tượng Runtime:

| Cấu Trúc Dữ Liệu / Runtime Instance (`Data Entity`) | Chủ Sở Hữu Độc Quyền (`Authoritative Owner`) | Các Module Được Phép Đọc (`Read Access`) | Các Module Được Phép Ghi (`Write Access`) |
| --- | --- | --- | --- |
| `FlowerDefinition` & `FlowerCatalog` | **01. Flower Module** | `Inventory`, `Journal`, `Quest`, `Festival` | **01. Flower Module ONLY** |
| `FlowerInstance` & `GreenhouseGrid` | **01. Flower Module** | `SaveManager`, `Festival` (`via API`) | **01. Flower Module ONLY** |
| `ItemDefinition` & `InventorySlot [0..19]` | **02. Inventory Module** | `Quest`, `NPC`, `Festival`, `SaveManager` | **02. Inventory Module ONLY** |
| `PlayerEconomy.gold` | **02. Inventory Module** | `Shop`, `Quest`, `SaveManager` | **02. Inventory Module ONLY** |
| `NPCDefinition` & `NPCInstance` (`pos, hearts`) | **03. NPC Module** | `Quest`, `SaveManager`, `UI` | **03. NPC Module ONLY** |
| `QuestDefinition` & `QuestInstance` | **04. Quest Module** | `SaveManager`, `UI` | **04. Quest Module ONLY** |
| `JournalEntryInstance` & `MemoryCardInstance` | **05. Journal Module** | `SaveManager`, `UI` | **05. Journal Module ONLY** |
| `WeatherProfile` & `WeatherState` | **06. Weather Module** | `Flower`, `NPC`, `Audio`, `SaveManager`| **06. Weather Module ONLY** |
| `AudioProfile` & `AudioState` (`volume`) | **07. Audio Module** | `SaveManager` (`Settings`) | **07. Audio Module ONLY** |
| `FestivalState` (`display_slots, score`) | **08. Festival Module** | `SaveManager`, `UI` | **08. Festival Module ONLY** |

---

## 12. Master Signal Matrix (`Global Communication Map`)

Bảng ma trận bản đồ tín hiệu Global Signal Bus nối liền 8 Core Modules:

| Tên Sự Kiện Signal (`Event Name`) | Module Phát Ra (`Publisher`) | Module Lắng Nghe (`Consumers`) | Mục Đích Giao Tiếp (`Purpose`) |
| --- | --- | --- | --- |
| `FlowerHarvested (id, qty, is_hybrid)`| **01. Flower Module** | `Inventory`, `Journal`, `Quest`, `Audio`| Cất hoa vào Satchel, mở khóa tiêu bản Nhật ký, cập nhật Quest, phát SFX thu hoạch. |
| `FlowerWatered / StageAdvanced` | **01. Flower Module** | `Audio`, `UI Presentation` | Phát âm thanh tưới nước róc rách, cập nhật hiển thị sprite mầm cây. |
| `HybridMutationOccurred (hybrid_id)` | **01. Flower Module** | `Inventory`, `Journal`, `Audio` | Nạp hạt giống lai vào Satchel, chúc mừng phát hiện mới. |
| `InventoryItemAdded / Consumed` | **02. Inventory Module** | `Quest`, `UI Presentation` | Cập nhật tiến độ nhiệm vụ thu thập, cập nhật icon trên HUD Satchel. |
| `NPCTalked (npc_id, dialogue_id)` | **03. NPC Module** | `Quest`, `Audio` | Cập nhật nhiệm vụ giao tiếp, giảm âm lượng BGM xuống `50% (Ducking)`. |
| `NPCGiftReceived (npc_id, item_id)` | **03. NPC Module** | `Inventory`, `Audio` | Trừ vật phẩm quà tặng khỏi Satchel, phát âm thanh phản ứng. |
| `QuestCompleted (quest_id, rewards)`| **04. Quest Module** | `Inventory`, `Audio`, `UI` | Nạp thưởng vào Satchel, phát sfx hoàn thành nhiệm vụ lung linh. |
| `JournalEntryUnlocked (flower_ref_id)`| **05. Journal Module** | `Quest`, `Audio`, `UI` | Cập nhật Quest nghiên cứu thực vật, hiển thị banner chúc mừng lấp lánh. |
| `WeatherChanged (weather_id, raining)`| **06. Weather Module** | `Flower`, `NPC`, `Audio`, `UI` | Tự làm ẩm 100% đất trồng, đổi lịch trình NPC trú mưa, chuyển tầng Ambience audio. |
| `FestivalStarted / Concluded` | **08. Festival Module** | `NPC`, `Audio`, `SaveManager` | Tập trung cư dân ra quảng trường, đổi nhạc lễ hội, ghi nhận cúp thắng cuộc vào Save. |

---

## 13. Extension Guide (`Step-by-Step Protocol for Adding New Modules`)

Khi dự án bước sang giai đoạn mở rộng tính năng mới (ví dụ: thêm **Module Nuôi Ong — `BeeKeeping Module`** hoặc **Module Nấu Trà — `TeaBrewing Module`**), AI Agent hoặc lập trình viên mới **BUỘC PHẢI TUÂN THỦ NGHIÊM NGẶT QUY TRÌNH 6 BƯỚC** sau để không làm gãy đổ kiến trúc hiện có:

```text
================================================================================
          AUTHORITATIVE EXTENSION PROTOCOL (ADDING A NEW MODULE)
================================================================================

[Bước 1: Khai báo Module Contract Spec trước khi code (`Spec-First`)]
   ➔ Tạo mục đặc tả mới theo đúng 13 phần (Purpose, Owns, Reads, Writes, Publishes, Consumes...) và trình Director phê duyệt.

[Bước 2: Xác định vị trí trong Master Dependency Matrix]
   ➔ Đặt module mới vào đúng tầng. Ví dụ `BeeKeeping` nằm ngang hàng `FlowerModule` và bên trên `InventoryModule`. Cấm tạo phụ thuộc vòng tròn (`Circular Dependency`).

[Bước 3: Khai báo Schema và ID tĩnh tại `03_Data_Architecture.md`]
   ➔ Thêm cấu trúc `BeeHiveDefinition` và `BeeInstance` vào Data Constitution. Tuân thủ chuẩn đặt tên `snake_case`.

[Bước 4: Đăng ký Signal mới vào Global Signal Bus (`05_Event_Architecture.md`)]
   ➔ Khai báo tín hiệu mới: `BeeHoneyHarvested (honey_id, qty)`. Không bao giờ gọi hàm trực tiếp `InventorySlot.Add()` từ trong Bee Module!

[Bước 5: Tạo Thư Mục và Khối Event độc lập tại `Source/Systems/`]
   ➔ Tạo `Source/Systems/beekeeping_system.json` theo `02_Folder_Convention.md`. Bọc kiểm tra `Performance Contract` (< 1.5ms/frame).

[Bước 6: Kết nối Lifecycle Hooks vào 4 Singletons chính]
   ➔ Kết nối hàm boot nạp `beehives.json`, kết nối `SaveManager` vào `OnBeforeSave` và `OnLoad` theo chuẩn `06_Save_Load_System.md`.

================================================================================
➔ HOÀN TẤT MỞ RỘNG AN TOÀN 100%! HỆ THỐNG CŨ KHÔNG HỀ BỊ ANH HƯỞNG!
================================================================================
```

---

## Appendix: Production Readiness Checklist & Status

- [x] Khóa triết lý hợp đồng module `Module Contract Philosophy` và 4 nguyên tắc ranh giới bất khả xâm phạm.
- [x] Đặc tả chi tiết 13 phần hợp đồng cho trọn vẹn **8 Core Modules** (`Flower`, `Inventory`, `NPC`, `Quest`, `Journal`, `Weather`, `Audio`, `Festival`).
- [x] Khóa bảng **Master Dependency Matrix** định nghĩa phân tầng phụ thuộc kiến trúc hợp lệ (`Downstream / Upstream`).
- [x] Khóa bảng **Master Ownership Matrix** phân chia độc quyền sở hữu từng cấu trúc tĩnh và instance runtime.
- [x] Khóa bản đồ **Master Signal Matrix** nối liền luồng giao tiếp toàn cục giữa 8 module qua Global Signal Bus.
- [x] Khóa hướng dẫn **Extension Guide** 6 bước bắt buộc khi AI muốn thêm module mới mà không phá vỡ kiến trúc cũ.

**Status: Approved**
*(Khóa trọn vẹn bản hợp đồng kiến trúc phần mềm tối cao giữa 8 core modules. Hoàn tất tài liệu thứ 10/10 của bộ Production Bible AAA Studio. Sẵn sàng tiến tới khai sinh `Docs/09_Architecture_Decisions/` (`ADR Repository`) và `Plant Tales/AI_BOOTSTRAP.md`)*!
