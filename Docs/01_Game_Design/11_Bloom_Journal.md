**Tuyệt. 😄 Theo mình thì 11 chính là tài liệu quan trọng thứ hai của toàn bộ game, chỉ sau Story System.**

**Vì đây là thứ khiến game của chúng ta khác với Stardew Valley hay Harvest Moon.**

**Đó chính là Bloom Journal.**

Mình còn muốn đổi cách nghĩ một chút.

**Bloom Journal không phải là Pokédex.**

Nó là:

- 📖 Nhật ký nghiên cứu thực vật
- 📚 Album sưu tập hoa
- 🧠 Nhật ký nghiên cứu của nhân vật
- 🌸 Nơi lưu giữ Pressed Memories
- ❤️ Một phần của cốt truyện

Đây là "trái tim" của game.

# 📄 11_Bloom_Journal.md

# 🎯 Mục tiêu

Trả lời câu hỏi:

Bloom Journal lưu những gì?

Và

Người chơi mở Journal để làm gì?

# 📖 Bloom Journal v1.0

# 1. Core Concept

Bloom Journal là cuốn sổ nghiên cứu do ông của nhân vật để lại.

Ban đầu.

Nó còn rất nhiều trang trống.

Người chơi sẽ dần hoàn thiện nó.

# 2. Journal Sections

Prototype chỉ cần.

```text
Bloom Journal

│

├── Flower Collection

├── Pressed Memories

└── Player Notes
```

Full Game sẽ thêm.

```text
Scientific Notes

Flower Family

Seed Collection

Festival Records

NPC Notes

World Plants
```

# 3. Flower Collection

Mỗi hoa.

Có một trang riêng.

Ví dụ.

```text
🌹 Rose
↓
```

Hiển thị.

- Illustration
- Scientific Name
- Language of Flowers
- Description
- Growth Time
- Season
- Quality Record

# 4. Discovery

Lần đầu.

Người chơi.

Trồng thành công.

```text
Rose
↓
```

Journal.

Unlock.

```text
NEW FLOWER DISCOVERED
↓
```

Animation.

```text
↓
```

Trang mới.

Được thêm.

# 5. Pressed Memories

**Đây là ý tưởng mà mình nghĩ sẽ trở thành đặc sản của game.**

Không gọi là Memory Fragments nữa.

Mà là.

```text
Pressed Memories
```

Ví dụ.

```text
🌸 Pressed Memory #07

The First Flower Festival
```

Khi mở.

Hiện.

- Một bông hoa ép khô
- Sketch bằng bút chì
- Ghi chú viết tay của ông
- Hội thoại của NPC

# 6. Player Notes

Prototype.

Người chơi.

Có thể.

Viết.

Ví dụ.

```text
Rose.

Seems to bloom faster in Summer.
```

Hay.

```text
Need to test with Lily.
```

Nếu chưa muốn làm tính năng nhập liệu, Prototype có thể chỉ có phần ghi chú tự động từ hệ thống.

# 7. Progress Tracking

Ví dụ.

```text
Flowers

8 / 10
Pressed Memories

4 / 12
↓
```

Người chơi.

Biết.

Mình còn thiếu gì.

# 8. Unlock Rewards

Journal.

Không chỉ để xem.

Mỗi mốc.

Ví dụ.

```text
5 Flowers
↓
```

Unlock.

```text
Lavender Seed
```

Hoặc.

```text
10 Flowers
↓
```

Unlock.

```text
New Garden Area
```

Journal.

Trở thành.

Một hệ thống tiến trình.

# 9. Prototype Rules

Prototype chỉ cần.

✅ Flower Pages

✅ Pressed Memories

✅ Progress %

Không cần.

❌ Search

❌ Filter

❌ Sticker

❌ Custom Cover

# 10. Journal Flow

```text
Discover Flower
        │
        ▼
Journal Unlock
        │
        ▼
View Information
        │
        ▼
Complete Collection
        │
        ▼
Unlock Reward
```

# 11. Journal Layout

```text
┌──────────────────────────┐
│        BLOOM JOURNAL      │
├──────────────────────────┤
│                          │
│ 🌹 Rose                  │
│                          │
│ Scientific Name          │
│ Language of Flowers      │
│ Description              │
│                          │
│ Pressed Memory           │
│                          │
│ Player Note              │
│                          │
└──────────────────────────┘
```

Prototype.

Không cần.

Animation.

# 💡 Future Feature 1 – Botanical Sketches

Đây là ý tưởng mình cực thích.

Sketch.

Không phải.

Ảnh màu.

Mà là.

```text
Pencil Sketch
```

Giống.

Sổ tay.

Nhà thực vật học.

Sau khi trồng nhiều lần.

Sketch.

Sẽ đẹp hơn.

# 💡 Future Feature 2 – Journal Evolution

Ban đầu.

Journal.

Rất cũ.

Ít trang.

Theo tiến trình.

```text
↓
```

Nhiều bookmark hơn.

```text
↓
```

Nhiều ghi chú hơn.

```text
↓
```

Nhiều hoa ép hơn.

```text
↓
```

Cảm giác.

Cuốn sổ.

"Đang sống."

# 💡 Future Feature 3 – Grandfather's Notes

Một trong những ý tưởng mình thích nhất.

Ví dụ.

Rose.

Ban đầu.

Journal.

Chỉ ghi.

```text
Rose.

A beautiful flower.
```

Sau khi mở.

Pressed Memory.

```text
↓
```

Có thêm.

```text
Grandfather's Note

"The first rose Mia ever planted never bloomed.

She cried all afternoon."
```

Người chơi.

Dần.

Hiểu.

Ông.

Qua Journal.

# 💡 Future Feature 4 – Research Level

Journal.

Có.

Level.

Ví dụ.

```text
Rose

Research

12%
↓
```

50%

```text
↓
```

Hiện.

Scientific Notes.

```text
↓
```

100%

```text
↓
```

Unlock.

Hybrid Hint.

Điều này khiến việc trồng cùng một loài nhiều lần vẫn có ý nghĩa.

# 💡 Future Feature 5 – Pressed Flower Collection

Đây là ý tưởng mới mình vừa nghĩ.

Hiện tại.

Pressed Memories.

Lưu.

Ký ức.

Nhưng.

Sau này.

Có thể.

Thêm.

```text
Pressed Flowers
↓
```

Người chơi.

Có thể.

Chọn.

Một bông.

★★★★★

```text
↓
```

Ép khô.

```text
↓
```

Đưa.

Vào Journal.

```text
↓
```

Không bán được nữa.

```text
↓
```

Đổi lại.

Journal.

Đẹp hơn.

Và.

Có thể dùng để trưng bày trong nhà sau này.

# 🌟 Ý tưởng mình muốn bổ sung vào Game Design Bible

**Đây là điều mình nghĩ sẽ khiến Bloom Journal trở thành biểu tượng của game.**

## 📖 Journal là "nhân vật thứ ba"

Game của chúng ta có:

- 👩 Nhân vật chính (Mia/Okeydokey).
- 👴 Người ông (qua ký ức).
- 📖 Bloom Journal.

**Bloom Journal không chỉ là menu.**

Nó giống như một người bạn đồng hành.

Mỗi khi người chơi:

- khám phá một loài hoa mới,
- gặp một NPC mới,
- mở khóa một Pressed Memory,
- hay hoàn thành một nghiên cứu,

cuốn sổ sẽ thay đổi theo. Nó ngày càng đầy những nét vẽ, ghi chú, hoa ép và bookmark.

Đến cuối game, khi người chơi lật lại những trang đầu tiên, họ sẽ thấy rõ hành trình mình đã đi qua. Theo mình, nếu làm được điều này, Bloom Journal sẽ không chỉ là một giao diện mà sẽ trở thành một trong những ký ức đáng nhớ nhất của người chơi sau khi hoàn thành game.
