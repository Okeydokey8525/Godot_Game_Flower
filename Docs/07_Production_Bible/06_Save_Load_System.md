# Save & Load System Constitution & Persistence Layer Standard

**Hiến pháp của tầng lưu trữ bền vững, quy chuẩn kiến trúc Serialize/Deserialize dữ liệu, giao thức Save Transaction nguyên tử và chính sách quản lý Save File cho dự án Plant Tales (Save & Load System Constitution & Persistence Layer Standard Document).**

---

## 1. Persistence Philosophy

Tài liệu **Save & Load System (`06_Save_Load_System.md`)** được ban hành không chỉ là một hướng dẫn ghi tệp tin JSON đơn thuần, mà là **Hiến pháp Tối cao của Tầng Lưu trữ Bền vững (*The Constitution of the Persistence Layer*)** cho vũ trụ **Plant Tales**, được biên soạn dưới thẩm quyền và tầm nhìn chuẩn mực của **Lead Persistence Architect + Senior Software Architect + Save System Engineer + AI Architecture Engineer**.

Trong một dự án hợp tác đa AI (`Codex`, `Claude`, `ChatGPT`, `Gemini`, `Antigravity`), nếu không khóa chặt kiến trúc lưu trữ, các AI thường xuyên phạm phải những lỗi chết người: lưu toàn bộ cơ sở dữ liệu tĩnh (`FlowerDefinition`) vào file save, ghi đè liên tục mỗi giây lên ổ cứng SSD, hoặc gây crash game khi người chơi tải bản save cũ sau một bản cập nhật vá lỗi.

Để bảo vệ sự toàn vẹn tuyệt đối cho dữ liệu người chơi, Hiến pháp Persistence thiết lập 6 triết lý cốt lõi:

```text
• Save stores only player progress (Save CHỈ lưu tiến trình, thành tựu và trạng thái của người chơi)
• Save never stores immutable data (Save KHÔNG BAO GIỜ bọc các bản thiết kế tĩnh của game)
• Definitions belong to databases  (Bản thiết kế thuộc về Database, read-only từ bộ nhớ)
• Instances belong to save files   (Thực thể runtime thay đổi thuộc về Save File)
• Save is replaceable              (Save có thể bị xóa/thay thế mà không làm hỏng logic core)
• Database is authoritative        (Database tĩnh luôn là nguồn chân lý tối cao quyết định thông số)
```

### 1.1. Sự Phân Tách Tuyệt Đối Giữa Gameplay Và Save System (`Decoupled Persistence Hierarchy`)
Gameplay không được phép biết quá trình Save/Load diễn ra dưới ổ cứng như thế nào. Trách nhiệm giữa các tầng được phân định minh bạch như sau:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      DECOUPLED PERSISTENCE PIPELINE                    │
├────────────────────────────────────────────────────────────────────────┤
│ [Gameplay System Layer]                                                │
│ (Hoa nở ➔ `FlowerInstance.Stage = 4` ➔ Trạng thái Runtime thay đổi)     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát tín hiệu thông báo: `MarkDirty`)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Save Manager Layer (`Global Singleton`)]                              │
│ (Ghi nhận biến cờ `SaveDirtyFlag = true` ➔ Đợi thời điểm thích hợp)     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Thực hiện Serialize phi đồng bộ qua Snapshot DTO)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Persistence Storage Layer]                                            │
│ (Ghi xuống file ổ cứng `save_slot_01.json` theo giao thức Atomic Write)│
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Save Ownership & Access Matrix (`Authoritative Persistence Boundary`)

Để tránh mọi sự nhầm lẫn giữa các hệ thống, kiến trúc thiết lập cả **Bảng Chủ Quyền Thực Thể (`Ownership Table`)** lẫn **Ma Trận Truy Cập Dữ Liệu (`Access Matrix`)**:

### 2.1. Bảng Chủ Quyền Thực Thể (`Authoritative Save Ownership Table`)

| Tên thực thể / Schema Class | Quyền lưu Save File (`Persistent`) | Lý do kiến trúc & Xử lý khi Load game (`Architectural Rationale`) | Ví dụ định danh trong Save |
| --- | --- | --- | --- |
| `FlowerDefinition` | ❌ **Never Save** | Thông số gốc (thời gian lớn, màu sắc). Load từ `Source/Data/flower_definition_*.json`. | *(Excluded)* |
| `FlowerInstance` | ✅ **Save** | Tọa độ luống đất, độ ẩm, giai đoạn phát triển hiện tại của từng bông hoa cụ thể. | `"id": "white_lily", "stage": 3` |
| `NPCData` | ❌ **Never Save** | Tiểu sử, sở thích quà tặng, cấu hình hội thoại cố định của NPC. | *(Excluded)* |
| `NPCState` | ✅ **Save** | Vị trí hiện tại, lịch trình đang thực hiện, cờ sự kiện trong ngày của NPC. | `"npc_id": "florist", "loc": "square"`|
| `Relationship` | ✅ **Save** | Số điểm thân thiện (*Heart Points*) giữa Mia và từng NPC. | `"npc_florist_hearts": 450` |
| `QuestDefinition` | ❌ **Never Save** | Điều kiện hoàn thành nhiệm vụ, phần thưởng mặc định từ hệ thống. | *(Excluded)* |
| `QuestProgress` | ✅ **Save** | Tiến độ hiện tại (`3/5 bông`), trạng thái đang làm hoặc đã trả nhiệm vụ. | `"quest_first_harvest": {"cnt": 3}`|
| `FestivalDefinition`| ❌ **Never Save** | Cấu hình ngày tổ chức, luật lệ thi đấu lễ hội hoa mùa xuân. | *(Excluded)* |
| `FestivalProgress`| ✅ **Save** | Điểm số trưng bày của người chơi trong năm, danh sách giải thưởng đã nhận. | `"festival_bloom_day_2026": 520` |
| `JournalEntry` | ✅ **Save** | Trạng thái mở khóa trang tiêu bản (`Unlocked/Locked`), ngày phát hiện loài hoa. | `"journal_white_lily": true` |
| `PressedMemory` | ✅ **Save** | Danh sách các ký ức ép hoa đã được kích hoạt thành công. | `"memory_greenhouse_01": true` |
| `InventorySlot` | ✅ **Save** | ID vật phẩm nằm trong ô Satchel, số lượng xếp chồng (`Stack Count`). | `"slot_0": {"id": "seed_lily", "qty": 10}`|
| `PlayerData` | ✅ **Save** | Tên nhân vật, ngày tháng năm, mùa, giờ hệ thống, số tiền (`Gold`). | `"name": "Mia", "gold": 1250` |
| `Settings` | ✅ **Save (Separate)**| Cấu hình âm lượng BGM/SFX, độ sáng, ngôn ngữ (lưu ở file `settings.json` riêng). | `"bgm_vol": 0.8, "lang": "vi"` |
| `Texture / Audio VFX`| ❌ **Never Save** | File hình ảnh, âm thanh, animation luôn nạp từ thư mục `Assets/`. | *(Excluded)* |

### 2.2. Ma Trận Quyền Sở Hữu & Truy Cập Dữ Liệu Save (`Save Ownership & Access Matrix`)
Quy định rạch ròi module nào sở hữu dữ liệu save của domain mình (`Own Save`), module nào được quyền đọc (`Read`) và ai được quyền ghi đổi (`Write`):

| Hệ Thống (`System / Module`) | Quyền Sở Hữu Save (`Own Save`) | Quyền Đọc (`Read Access`) | Quyền Ghi (`Write Access`) | Ràng Buộc Kiến Trúc |
| --- | :---: | :---: | :---: | --- |
| **Flower System** | ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `flowers.*` trong save file. |
| **Inventory Module**| ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `inventory.*` trong save file. |
| **NPC System** | ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `npc_states.*` trong save file. |
| **Journal Module** | ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `journal.*` trong save file. |
| **Quest Module** | ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `quests.*` trong save file. |
| **Festival Module** | ✅ **YES** | ✅ **YES** | ✅ **YES** | Chỉ sở hữu và ghi đổi nhánh `festival_progress.*`. |
| **UI Presentation** | ❌ **NO** | ✅ **YES** | ❌ **NO** | UI chỉ đọc để hiển thị (`HUD/Satchel`), cấm trực tiếp sửa save. |
| **Audio System** | ❌ **NO** | ❌ **NO** | ❌ **NO** | Audio cấm quan tâm tới save file, chỉ lắng nghe Signal Bus. |
| **Animation Layer** | ❌ **NO** | ❌ **NO** | ❌ **NO** | Animation cấm truy vấn save file, chỉ lắng nghe Signal Bus. |

---

## 3. Save File Structure (`Clean JSON Architecture`)

Toàn bộ dữ liệu của một phiên chơi được đóng gói thành một cấu trúc cây JSON minh bạch, tối giản và thuần tuý dữ liệu bên trong `save_slot_01.json`. Nghiêm cấm mọi đoạn code hay logic nhúng vào file save:

```text
{
  "metadata": { ... },
  "player": {
    "display_name": "Mia",
    "gold": 1250,
    "current_season": "spring",
    "current_day": 14,
    "time_of_day_minutes": 630
  },
  "inventory": {
    "satchel_slots": [
      { "slot_id": 0, "item_ref_id": "item_seed_white_lily", "stack_count": 12 },
      { "slot_id": 1, "item_ref_id": "item_tool_watering_can", "moisture_level": 80 }
    ]
  },
  "flowers": {
    "active_instances": [
      { "instance_id": 542, "flower_ref_id": "flower_white_lily", "grid_x": 12, "grid_y": 34, "stage": 2, "moisture": 100 },
      { "instance_id": 543, "flower_ref_id": "flower_blue_lavender", "grid_x": 13, "grid_y": 34, "stage": 4, "moisture": 50 }
    ]
  },
  "npc_states": {
    "florist": { "current_location": "village_square", "heart_points": 450, "talked_today": true },
    "mayor": { "current_location": "town_hall", "heart_points": 200, "talked_today": false }
  },
  "journal": {
    "unlocked_pages": ["flower_rose_common", "flower_white_lily"]
  },
  "memories": {
    "unlocked_memories": ["memory_grandfather_greenhouse", "memory_first_rain_drop"]
  },
  "quests": {
    "active_progress": {
      "quest_first_harvest": { "status": "in_progress", "current_count": 3, "target_count": 5 }
    }
  },
  "weather": {
    "current_profile_id": "weather_profile_spring_rain",
    "remaining_rain_seconds": 180
  },
  "statistics": {
    "total_flowers_harvested": 45,
    "total_gold_earned": 3200,
    "days_spent_in_village": 14
  }
}
```

---

## 4. Metadata Schema (`Mandatory Header Record`)

Mọi file save hợp lệ **bắt buộc phải có khối `metadata` ở ngay dòng đầu tiên**. Khối này đóng vai trò là "chứng minh thư" của bản save, giúp UI hiển thị thông tin nhanh ngoài `MainMenuScene` và giúp `SaveManager` kiểm chứng tương thích phiên bản trước khi nạp vào RAM:

```text
"metadata": {
  "version": "1.2.0",               ◄── (Mã phiên bản Schema save hiện tại để chạy Migration)
  "build_number": 20260716,         ◄── (Mã build thực tế của GDevelop Engine khi save)
  "save_timestamp_utc": 1784236800, ◄── (Thời gian thực ghi save UTC Unix Timestamp)
  "playtime_seconds": 14400,        ◄── (Tổng số giây người chơi đã trải nghiệm game)
  "language": "vi",                 ◄── (Ngôn ngữ đang sử dụng trong phiên chơi đó)
  "slot_index": 1,                  ◄── (Số thứ tự của khe lưu trữ Slot 1 / Slot 2 / Slot 3)
  "save_type": "auto_save",         ◄── (Phân loại: `auto_save`, `quick_save`, hay `manual_save`)
  "thumbnail_area": "greenhouse",   ◄── (Định danh ảnh thu nhỏ hiển thị ngoài menu chọn slot)
  "world_seed": 8492041             ◄── (Hạt giống ngẫu nhiên toàn cục của khu vườn)
}
```
❌ **Phán quyết kỹ thuật:** Bất kỳ file save nào thiếu khối `metadata.version` sẽ lập tức bị hệ thống coi là tệp tin hỏng/không hợp lệ (`Corrupted/Legacy Invalid`) và từ chối tải.

---

## 5. Serializer Interface & Compression Policy (`Decoupled Encoding Layer`)

Để giữ cho logic Gameplay không bị phụ thuộc vào cách thức đóng gói dữ liệu trên đĩa, toàn bộ quá trình đóng gói phải đi qua một **Giao diện Serializer (`Serializer Interface`)** trừu tượng, dự trù sẵn chính sách nén và mã hóa (*Compression/Encryption Policy*):

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      SERIALIZER INTERFACE PIPELINE                     │
├────────────────────────────────────────────────────────────────────────┤
│ [Save Manager Singleton]                                               │
│ (Gọi lệnh: `ISaveSerializer.Serialize(runtimeSnapshotDTO)`)             │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Chuyển giao cho Concrete Serializers)
            ┌───────────────────────┼───────────────────────┐
            ▼                       ▼                       ▼
┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐
│  [JSON Serializer]   │ │[CompressedSerializer]│ │[EncryptedSerializer] │
│                      │ │                      │ │                      │
│ ➔ Ghi plain text     │ │ ➔ Dùng Gzip/Zlib nén │ │ ➔ Dùng AES-256 mã hóa│
│    JSON dễ đọc khi   │ │    dưới `250 KB` cho │ │    chống cheat sửa   │
│    chạy Prototype.   │ │    Steam Cloud Sync. │ │    file ở Production.│
└──────────────────────┘ └──────────────────────┘ └──────────────────────┘
```

---

## 6. Versioning Strategy (`Forward Compatibility Protection`)

Trong một tựa game indie có chu kỳ phát triển và cập nhật nội dung liên tục (*Live-Ops / Content Patches*), việc thay đổi cấu trúc dữ liệu là tất yếu. **Plant Tales** ban hành chiến lược quản lý phiên bản nghiêm ngặt:

```text
[Save File Version 1.0.0] ──► (Bản phát hành gốc: Hoa chỉ có 3 stages)
            │
            ▼ (Game Director ra bản vá Update 1.1.0: Thêm hệ thống di truyền hoa)
[Save File Version 1.1.0] ──► (Schema mới có thêm thuộc tính `mutation_rate`)
            │
            ▼ (Game Director ra bản Update 1.2.0: Thêm module nuôi ong)
[Save File Version 1.2.0] ──► (Schema mới có thêm nhánh `bee_keeping_states`)
```

- **Quy định bất biến:** Khi game nâng cấp lên `v1.2.0`, hệ thống **buộc phải đọc được hoàn hảo bản save cũ `v1.0.0` của người chơi** mà không bị mất dữ liệu hay báo lỗi. Nghiêm cấm tuyệt đối việc ép người chơi chơi lại từ đầu chỉ vì một bản cập nhật vá lỗi (`Zero Save Wipe Guarantee`).

---

## 7. Migration Pipeline (`Zero Crash Schema Upgrading`)

Để chuyển hóa các bản save cũ lên phiên bản hiện tại một cách an toàn tuyệt đối, `SaveManager` phải chạy qua đường ống chuyển đổi dữ liệu (*Migration Pipeline*) tự động:

```text
┌────────────────────────────────────────────────────────────────────────┐
│               THE ZERO-CRASH SAVE MIGRATION PIPELINE                   │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [Load Raw JSON from Disk] ──► Đọc `metadata.version` của file save. │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Ví dụ version đang là "1.0.0")
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 2. [Compare with Current Build] ──► Engine Build version là "1.2.0".   │
│                                     Phát hiện lệch phiên bản!          │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Kích hoạt bộ Migrators tuần tự)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. [Execute Migrator: v1.0 ➔ v1.1] ──► Chèn giá trị mặc định cho field │
│                                        mới: `mutation_rate = 0.0`      │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 4. [Execute Migrator: v1.1 ➔ v1.2] ──► Khởi tạo nhánh rỗng cho module  │
│                                        mới: `bee_keeping_states = {}`  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 5. [Validation & Memory Injection] ──► Schema đạt chuẩn v1.2.0! Nạp vào│
│                                        bộ nhớ RAM cho Gameplay Systems. │
└────────────────────────────────────────────────────────────────────────┘
```
❌ **Nghiêm cấm:** Không bao giờ được phép quăng lỗi `Crash` hoặc hiện bảng `Game cannot load save` khi gặp một file save cũ hợp lệ.

---

## 8. Dirty Save Policy & Save Frequency Budget (`Cache-on-Dirty Protection`)

Một trong những sai lầm thảm họa nhất của lập trình viên sơ cấp là thực hiện lệnh ghi file xuống ổ cứng (*Disk Write*) ngay sau mỗi hành động nhỏ của người chơi (`Tưới nước ➔ Save`, `Đi 1 bước ➔ Save`). Lối viết này sẽ hủy hoại tuổi thọ ổ SSD và gây khựng lag (`Frame Stutter`).

### 8.1. Quy Trình Cache-on-Dirty (`Dirty Save Execution`)
```text
┌────────────────────────────────────────────────────────────────────────┐
│                    DIRTY SAVE EXECUTION FLOW CHART                     │
├────────────────────────────────────────────────────────────────────────┤
│ [Player Action] ──► Tưới hoa / Thu hoạch / Nhận quà từ NPC             │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Phát Signal: `SaveManager.MarkDirty()`)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Save Manager RAM Cache] ──► Bật cờ `SaveDirtyFlag = true`.            │
│                              KHÔNG GHI XUỐNG Ổ CỨNG NGAY LẬP TỨC!      │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Bộ đếm Timer ngầm kiểm tra định kỳ)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ [Cooldown Trigger (5.0s)] ──► Nếu `SaveDirtyFlag == true` VÀ đã qua 5s:│
│                               ➔ Chạy `AsyncSerializer` xuống ổ cứng.    │
│                               ➔ Đặt lại `SaveDirtyFlag = false`.       │
└────────────────────────────────────────────────────────────────────────┘
```

### 8.2. Ngân Sách Tần Suất Lưu Trữ (`Save Frequency Budget`)
Để ngăn AI hoặc lập trình viên viết code spam lệnh ghi đĩa, hệ thống áp đặt **Ngân Sách Tần Suất Tối Đa (`Maximum Save Budget`)**:
- **Disk Write Hard Limit:** Tối đa `1 lần ghi đĩa / 5 giây` (`1 write / 5 sec`). Nếu có nhiều yêu cầu save diễn ra trong 5s, chúng sẽ bị gộp (`coalesced`) vào 1 lần ghi duy nhất lúc hết timer.
- **Auto Save Limit:** Tối đa `3 lần auto save / phút` (`3 autosave / min`).
- **Quick Save Limit:** Tối đa `1 quicksave / giây` (`1 quicksave / sec`) chống spam phím F5 liên tục.

---

## 9. Auto Save Rules & Save Slots Architecture

### 9.1. Các Thời Điểm Tự Động Lưu Chuẩn Mực (`Auto Save Triggers`)
- ✅ **Bắt buộc Auto Save khi:** Ngủ chuyển ngày (`Day/Night Transition`), di chuyển giữa các Scene lớn (`VillageScene <-> HouseScene`), hoàn thành nhiệm vụ cốt lõi (`Quest Completion`), kết thúc Lễ Hội (`Festival End`), hoặc thu hoạch trên 5 chậu hoa cùng lúc (`Major Harvest`).
- ❌ **Cấm Auto Save khi:** Mỗi bước di chuyển của nhân vật (`Step-by-Step`), khi bật/tắt trang menu nhật ký (`Menu Toggle`), hoặc đang chạy chuỗi thoại cutscene (`Mid-Dialogue`).

### 9.2. Kiến Trúc 5 Khe Lưu Trữ Đa Nhiệm (`Save Slots Map`)
```text
┌───────────────────────────────────┬────────────────────────────────────┐
│ Tên Khe Lưu Trữ (`Slot ID`)       │ Nhiệm vụ & Đặc tính hoạt động      │
├───────────────────────────────────┼────────────────────────────────────┤
│ `save_slot_01.json` (Slot 1)      │ Khe lưu thủ công/chính thức số 1 của người chơi. │
│ `save_slot_02.json` (Slot 2)      │ Khe lưu thủ công/chính thức số 2 của người chơi. │
│ `save_slot_03.json` (Slot 3)      │ Khe lưu thủ công/chính thức số 3 của người chơi. │
│ `save_auto.json` (Auto Save)      │ Khe lưu tự động ghi đè liên tục theo quy tắc Chương 9.1.│
│ `save_quick.json` (Quick Save)    │ Khe lưu nhanh (F5) khi người chơi muốn test một hành động.│
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 10. Atomic Save Principle (`Zero Data Corruption Guarantee`)

Đây là nguyên tắc tối cao của một **Software Architect cấp studio**: **Không bao giờ ghi đè trực tiếp lên tệp tin save chính thức (`Never write directly to active save file`)**. Nếu mất điện đột ngột ngay giữa lúc đang ghi đĩa, file save chính sẽ bị cắt đôi nửa vời (`corrupted/truncated`) và người chơi mất trắng tiến trình.

**Plant Tales** áp dụng giao thức **Lưu Trữ Nguyên Tử (`Atomic Save Principle / Save Transaction`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                 ATOMIC SAVE TRANSACTION EXECUTION PROTOCOL             │
├────────────────────────────────────────────────────────────────────────┤
│ 1. [Begin Transaction] ──────► Khóa cờ `IsTransactionActive = true`.   │
│                                 Thu thập Snapshot DTO từ các Modules.  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 2. [Write Temporary File] ───► Ghi toàn bộ chuỗi JSON xuống một file   │
│                                 tạm thời mang tên `save_slot_01.tmp`.  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. [Validate Temporary File] ─► Đọc ngược lại `save_slot_01.tmp` để    │
│                                 kiểm chứng Checksum Hash SHA-256 có OK?│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
            ┌───────────────────────┴───────────────────────┐
            ▼ (Validate matches OK!)                        ▼ (Validate FAILED!)
┌───────────────────────────────────────┐   ┌───────────────────────────────────────┐
│ 4. [Commit & Replace Old Save]        │   │ 4. [Abort & Rollback Transaction]     │
│    ➔ Đổi tên `save_slot_01.json` cũ   │   │    ➔ Xóa bỏ ngay file `save_slot_01.tmp`│
│       thành `.bak` / `.previous`      │   │    ➔ Giữ nguyên file `save_slot_01.json` │
│    ➔ Đổi tên `save_slot_01.tmp` mới   │   │       cũ an toàn tuyệt đối!            │
│       thành `save_slot_01.json` chính!│   │    ➔ Log Error: `[AtomicSave] Aborted`│
└───────────────────────────────────────┘   └───────────────────────────────────────┘
```

---

## 11. Backup Rotation Architecture (`Three-Tier Safe Storage`)

Nâng tầm bảo vệ vượt xa chuẩn indie thông thường chỉ có 1 file `.bak`, **Plant Tales** thiết lập cơ chế **Luân Chuyển Bản Sao Lưu 3 Tầng (`Three-Tier Backup Rotation`)**:

```text
[save_slot_01.json]      ◄── Bản save chính thức mới nhất (`Newest Active Save`)
        │ (Khi có lượt Commit mới thành công theo Chương 10)
        ▼
[save_slot_01.bak]       ◄── Bản sao lưu ngay trước đó (`Backup Level 1 - Previous`)
        │ (Luân chuyển bản cũ sâu hơn xuống tầng tiếp theo)
        ▼
[save_slot_01.previous]  ◄── Bản sao lưu khẩn cấp từ 2 chu kỳ trước (`Backup Level 2 - Rollback`)
```
Nếu file `Newest` bị hỏng do lỗi hệ thống ổ đĩa, `SaveManager` lập tức tự động lùi xuống nạp `Backup Level 1 (.bak)`. Nếu `.bak` cũng hỏng, hệ thống tiếp tục lùi xuống `Backup Level 2 (.previous)` để cứu vãn phiên chơi bằng mọi giá.

---

## 12. Save Validator Pipeline (`Strict Verification Gate`)

Ngay trước khi quá trình nạp save đưa dữ liệu vào RAM cho các Gameplay Systems chạy, file save phải bước qua một đường ống kiểm định 3 lớp khắt khe (**Save Validator Pipeline**):

```text
┌────────────────────────────────────────────────────────────────────────┐
│                     3-LAYER SAVE VALIDATOR PIPELINE                    │
├────────────────────────────────────────────────────────────────────────┤
│ Layer 1: [Schema Validator]                                            │
│          ➔ Kiểm tra cấu trúc JSON có đủ 10 nhánh gốc không?            │
│          ➔ Kiểm tra `metadata.version` hợp lệ và parse được cú pháp?   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Schema OK)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 2: [Data Validator (`Sanity & Bounds Check`)]                    │
│          ➔ `flower_id` có thực sự tồn tại trong `FlowerDatabase` không?│
│          ➔ `money` có bị âm (`< 0`) hoặc vượt trần (`> 999999999`)?    │
│          ➔ `inventory slots` có bị tràn số lượng vượt quá sức chứa?    │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Data Bounds OK)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Layer 3: [Relationship Validator (`Graph Integrity Check`)]            │
│          ➔ `npc_id` có tồn tại trong `NPCDatabase` và `hearts <= 1000`?│
│          ➔ `quest_id` đang làm có yêu cầu chậu hoa không hợp lệ không?  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
       ✅ VALIDATION APPROVED! Nạp vào RAM cho các Hệ Thống Core!
```

---

## 13. Deterministic Loading Order & Dependency Graph (`Strict Boot Sequence`)

Một trong những lỗi kinh điển khi nạp save là nạp theo thứ tự ngẫu nhiên hoặc bảng chữ cái alphabet (`Load ABC...`), dẫn đến việc `NPCModule` nạp trước `FlowerSystem` rồi cố gắng truy vấn một chậu hoa chưa hề được khởi tạo trong RAM gây crash game.

**Plant Tales** quy định tuyệt đối **Thứ Tự Nạp Dữ Liệu Quyết Định & Đồ Thị Phụ Thuộc (`Deterministic Loading Order & Dependency Graph`)**:

### 13.1. Sơ Đồ Đồ Thị Phụ Thuộc (`Dependency Graph`)
```text
[Static Definitions (`Authoritative DB`)]
                   │
                   ▼
       [PlayerData (`Global Stats`)]
                   │
                   ▼
     [InventoryModule (`Satchel Slots`)]
                   │
                   ▼
       [FlowerSystem (`Grid Instances`)]
                   │
                   ▼
          [NPCSystem (`NPC States`)]
                   │
                   ▼
      [WeatherSystem & TimeTicker]
                   │
                   ▼
          [QuestModule (`Progress`)]
                   │
                   ▼
       [JournalModule (`Tiêu bản`)]
                   │
                   ▼
       [UI Presentation (`Refresh HUD`)]
```

### 13.2. Thứ Tự Nạp Tuần Tự Bắt Buộc (`Mandatory 10-Step Boot Sequence`)
1. **Definitions:** Nạp `FlowerDefinition`, `NPCData`, `QuestDefinition` từ `Source/Data/` vào bộ nhớ chỉ đọc.
2. **Player:** Khôi phục `PlayerData` (`name`, `gold`, `current_day`).
3. **Inventory:** Khôi phục `InventorySlot` (đảm bảo kho có đồ trước khi trồng/bán).
4. **Flowers:** Khôi phục `FlowerInstance` lên lưới đất Nhà kính (`Greenhouse Grid`).
5. **NPC:** Khôi phục `NPCState` và `Relationship` (NPC xuất hiện đúng vị trí và sở thích).
6. **Weather:** Khôi phục trạng thái thời tiết mưa/nắng hiện tại.
7. **Quests:** Khôi phục `QuestProgress` (kết nối lại với các đối tượng hoa/item vừa nạp).
8. **Journal & Memories:** Khôi phục trang sách tiêu bản (`JournalEntry`) và ký ức (`PressedMemory`).
9. **Audio/VFX:** Đặt lại các biến môi trường cho tầng thanh âm và hình ảnh.
10. **UI Presentation:** Phát Signal `SaveLoadCompleted` để UI tự động vẽ lại toàn bộ HUD (`Refresh ALL`).

---

## 14. Corrupted Save Recovery & Save Security (`Defensive Loading Shield`)

Toàn bộ quá trình nạp save (`Load`) được bọc trong một lá chắn phòng thủ kỹ thuật (**Defensive Loading Shield**). Ngay cả khi người chơi mở file JSON ra chỉnh sửa tay hoặc file bị mất một vài trường, hệ thống vẫn xử lý êm ái:

```text
[Save File JSON] ➔ [Validation Check] ➔ [Unknown Field] ➔ [Ignore Field]
                                    ➔ [Missing Field] ➔ [Inject Default Value] ➔ [Continue Safely]
```

1. **Kháng cự trường dữ liệu lạ (`Unknown Field Tolerance`):** Nếu file save có trường lạ `"mod_magic_flower": true`, `SaveManager` tự động **bỏ qua (`Ignore`)** mà không crash.
2. **Tự động bổ sung trường bị thiếu (`Missing Field Injection`):** Nếu một bản save cũ thiếu `"gold"`, `SaveManager` tự động chèn mặc định `"gold": 100` vào RAM để tiếp tục trò chơi (`Graceful Continuation`).
3. **Phục hồi Checksum AAA (`Fault Tolerance`):** Nếu SHA-256 Checksum không khớp (file hỏng), tự động đổi tên file thành `.bad`, nạp file dự phòng `.bak` hoặc `.previous` và thông báo nhẹ nhàng cho người chơi: `"Đã khôi phục khu vườn từ bản lưu an toàn."`

---

## 15. Future Expansion Strategy (`Architecture Reservation`)

Kiến trúc `SaveManager` được thiết kế dự trù sẵn không gian cho 4 tính năng mở rộng lớn trong tương lai mà **không cần đập bỏ hay viết lại hệ thống cũ**:

- **Modding Support:** Trường `metadata.active_mods` lưu danh sách Mod. Nếu người chơi tắt Mod, `Migration Pipeline` tự động bỏ qua các ID thuộc Mod đó mà không crash game.
- **Cloud Save Sync (Steam/Epic):** Nhờ việc không lưu Static Data, dung lượng save file luôn giữ tối giản dưới `250 KB`, đồng bộ hóa lên Cloud cực nhanh chỉ trong vài mili-giây.
- **Cross-Platform Compatibility:** JSON chuẩn `snake_case` toàn chữ thường, mã hóa `UTF-8`, đọc được mượt mà trên PC, Nintendo Switch và Mobile.
- **Steam Workshop:** Lưu riêng ID của các khu vườn chia sẻ vào `workshop_cache.json` độc lập với Save chính.

---

## 16. AI Collaboration Rules (`GREEN vs RED LIGHT`)

Bảng hiến pháp phân định quyền hạn và lệnh cấm tuyệt đối cho các AI Coding Agents (`Codex`, `Antigravity`, `Claude`, `ChatGPT`) khi can thiệp vào tầng lưu trữ dữ liệu:

### 16.1. Đèn Xanh (`Authorized Persistence Actions` — ✅ GREEN LIGHT)
- ✅ **Thêm trường dữ liệu Runtime mới:** Được phép thêm các thuộc tính động vào `save_slot_01.json` **nếu** đã khai báo trong `Migration Pipeline`.
- ✅ **Thêm kịch bản Migration:** Được viết thêm các hàm `Migrate_v1_to_v2()` nâng cấp schema.
- ✅ **Thêm bộ kiểm chứng Save Validator:** Được viết thêm các hàm kiểm tra hợp lệ (`ValidateGoldNotNegative()`).

### 16.2. Đèn Đỏ (`Strictly Forbidden Persistence Actions` — ❌ RED LIGHT)
- ❌ **Cấm lưu Static Definitions (`No Static Persistence`):** Cấm tuyệt đối chèn `FlowerDefinition`, `NPCData` hay `QuestDefinition` vào trong Save File JSON.
- ❌ **Cấm lưu Asset nhị phân (`No Binary/Texture Persistence`):** Cấm lưu đường dẫn nhị phân, base64 texture sprite hay audio file vào save file.
- ❌ **Cấm tạo thêm Save Manager trôi nổi (`No Duplicate Save Managers`):** Cấm tự ý sinh ra `InventorySaveSys` hay `JournalSaver`. `SaveManager` phải là Singleton duy nhất.
- ❌ **Cấm hardcode phiên bản Save (`No Hardcoded Versioning`):** Cấm gán cứng `version = "1.0"` khi save mà phải đọc từ biến hằng toàn cục `ENGINE_CURRENT_BUILD_VERSION`.
- ❌ **Cấm ghi đè trực tiếp (`No Direct Overwriting`):** Cấm ghi thẳng vào `save_slot_01.json`, buộc phải đi qua giao thức `Atomic Write (.tmp -> Commit)`.

---

## 17. Master Persistence Flow Diagram

Sơ đồ ASCII tổng thể luồng thẩm thấu dữ liệu lưu trữ cấp studio AAA (*Studio-grade Master Persistence Flow Diagram*), minh họa trọn vẹn hành trình từ Database tĩnh thấu qua Runtime Instances trong RAM ra tới `Snapshot DTO`, `Serializer`, `Atomic Transaction` và nằm gọn gàng bên trong tệp tin `save_slot_01.json`:

```text
================================================================================
                    MASTER PERSISTENCE ARCHITECTURE FLOW
================================================================================

[STATIC READ-ONLY DATABASES (`Source/Data/`)]
 ├── FlowerDatabase (`flower_white_lily`) ──────┐
 ├── NPCDatabase (`npc_florist`) ───────────────┼── (Tham chiếu ID, KHÔNG LƯU SAVE FILE)
 └── QuestDatabase (`quest_first_harvest`) ─────┘
                                                │
                                                ▼
[RUNTIME GAMEPLAY INSTANCES & STATE IN RAM]
 ├── [FlowerInstance #542] (Stage: 3, Moisture: 80) ──┐
 ├── [InventorySlot #0] (Item: seed_lily, Qty: 10) ───┼── (Biến đổi liên tục theo thời gian thực)
 ├── [NPCState Florist] (Heart Points: 450) ───────────┤
 └── [PlayerData] (Name: Mia, Gold: 1250, Day: 14) ───┘
                                                │
                                                │ [Hành động xảy ra: MarkDirty()]
                                                ▼
┌────────────────────────────────────────────────────────────────────────┐
│                        DIRTY CACHE & AUTO TIMER                        │
│             `SaveDirtyFlag = true` ➔ Cooldown Timer (> 5.0s)           │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Kích hoạt Snapshot Builder)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                RUNTIME SNAPSHOT BUILDER & SERIALIZABLE DTO             │
│        Bóc tách DTO tách biệt hoàn toàn khỏi Runtime Instances         │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Chuyển giao cho ISaveSerializer)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│             ISAVE SERIALIZER & SHA-256 CHECKSUM GENERATOR              │
│       Đóng gói cấu trúc 10 ngăn chuẩn ➔ Tính toán `checksum_hash`        │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Ghi xuống file tạm theo Atomic Protocol)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│           ATOMIC SAVE TRANSACTION (`save_slot_01.tmp`)                 │
│      Ghi temporary ➔ Validate Checksum OK ➔ Commit & Replace           │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Đổi tên luân chuyển Backup 3 tầng)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                  PERSISTENCE DISK STORAGE (`Save File`)                │
│    `save_slot_01.json` (+ `.bak` Previous 1 + `.previous` Rollback 2)  │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 18. Appendix (`Checklists & Immutable Laws`)

### Appendix A: Immutable Save Laws (*The 16 Persistence Commandments*)
1. **Save stores progress, never definitions.** *(Chỉ lưu tiến trình; cấm lưu bản thiết kế tĩnh).*
2. **Metadata is mandatory.** *(Mọi file save buộc phải có khối metadata header).*
3. **Backward compatibility is sacred.** *(Save cũ luôn phải load được trên bản build mới qua Migration).*
4. **Cache-on-Dirty only.** *(Chỉ ghi ổ cứng qua biến cờ `MarkDirty` sau 5s, cấm save mỗi frame).*
5. **Zero save wipe guarantee.** *(Nghiêm cấm mọi bản update làm mất dữ liệu của người chơi).*
6. **Atomic write is non-negotiable.** *(Luôn ghi `.tmp` rồi mới Commit đè lên file chính thức).*
7. **Three-tier backup rotation.** *(Luôn giữ luân chuyển `.json -> .bak -> .previous`).*
8. **Three-layer validation gate.** *(Luôn qua kiểm định Schema -> Data Bounds -> Relationship).*
9. **Deterministic 10-step loading graph.** *(Nạp tuần tự theo đồ phụ thuộc Graph, cấm nạp random).*
10. **Defensive loading mandate.** *(Tự chèn default cho trường thiếu, bỏ qua trường lạ, không crash).*
11. **Runtime Snapshot DTO isolation.** *(Chuyển qua DTO trước khi serialize, tách rời khỏi runtime class).*
12. **Singleton Save Manager.** *(Chỉ tồn tại 1 `SaveManager` duy nhất quản lý toàn bộ luồng save).*
13. **No texture/audio in save.** *(Tuyệt đối không lưu file nhị phân hay asset vào save JSON).*
14. **JSON must be clean `snake_case`.** *(Cấu trúc JSON phẳng, minh bạch, chuẩn hóa UTF-8).*
15. **Auto save on major transitions only.** *(Chỉ auto save khi ngủ, chuyển scene lớn hay xong quest).*
16. **AI never bypasses persistence laws.** *(AI sinh code buộc phải tuân thủ 100% hiến pháp lưu trữ này).*

### Appendix B: AI Save Checklist (*Pre-Pull Request Verification*)
- [ ] **1. Ownership Check:** File save mới có tuân thủ `Save Ownership Matrix` và không chèn tĩnh không?
- [ ] **2. Atomic Check:** Logic ghi đĩa có tuân thủ giao thức `save_slot_01.tmp` rồi mới Commit không?
- [ ] **3. Validator Check:** Dữ liệu nạp lên có đi qua 3 lớp `Schema -> Data Bounds -> Relationship Validator` không?
- [ ] **4. Graph Order Check:** Thứ tự nạp có tuân thủ đúng 10 bước `Deterministic Boot Sequence` không?
- [ ] **5. Migration Check:** Nếu có thêm thuộc tính mới vào save, đã viết script `Migrate()` cho bản cũ chưa?
- [ ] **6. Checksum Check:** Có tạo bản sao lưu `.bak` và `.previous` trước khi Commit không?

### Appendix C: Production Readiness Checklist & Status
- [x] Khóa 6 triết lý lưu trữ tối cao và sự phân tách `Decoupled Pipeline`.
- [x] Lập bảng `Save Ownership Table` và ma trận `Save Ownership Matrix (Own|Read|Write)`.
- [x] Thiết kế cấu trúc JSON 10 ngăn chuẩn xác và khối `Metadata Schema` bắt buộc.
- [x] Khóa chiến lược `Versioning` và đường ống 5 bước `Migration Pipeline` chống mất save.
- [x] Thiết lập chính sách `Dirty Save Policy (Cache-on-Dirty)` và `Save Frequency Budget`.
- [x] Khóa giao thức `Atomic Save Principle (Transaction Begin -> Tmp -> Commit)`.
- [x] Khóa cơ chế `Three-Tier Backup Rotation (.json -> .bak -> .previous)`.
- [x] Thiết lập bộ kiểm định 3 lớp `Save Validator Pipeline (Schema/Data/Relationship)`.
- [x] Khóa thứ tự nạp quyết định `Deterministic Loading Order & Dependency Graph`.
- [x] Quy định Auto Save, 5 khe lưu trữ đa nhiệm và `Corrupted Recovery & Defensive Loading`.
- [x] Khóa bảng điều luật hợp tác AI `GREEN vs RED LIGHT` và chiến lược mở rộng Cloud/Modding.
- [x] Sơ đồ ASCII Master Persistence Flow toàn cục nối liền Database tới `save_slot_01.json`.

**Status: Approved**
*(Khóa hiến pháp tầng lưu trữ bền vững toàn cục ở cấp độ hoàn hảo AAA. Sẵn sàng tiến sang Module 07: `07_AI_Collaboration.md`).*
