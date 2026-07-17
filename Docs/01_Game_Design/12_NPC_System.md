**Tuyệt. Mình nghĩ từ phần 12 trở đi game bắt đầu chuyển từ một game trồng hoa thành một thế giới sống.**

**Theo mình, nếu Flower System là trái tim của gameplay thì NPC System là linh hồn của thế giới.**

Đây cũng là nơi chúng ta sẽ gắn:

- 🌸 Flower
- 📖 Bloom Journal
- 🌼 Pressed Memories
- 👴 Grandfather
- 🏡 Village
- ❤️ Story

lại thành một hệ thống thống nhất.

# 📄 12_NPC_System.md

# 🎯 Mục tiêu

Trả lời câu hỏi:

NPC trong game hoạt động như thế nào?

và

Làm sao để NPC không chỉ là "người đứng bán đồ"?

# 👥 NPC System v1.0

# 1. Core Concept

NPC là những cư dân của thị trấn.

Mỗi NPC đều có:

- tên
- nghề nghiệp
- lịch sinh hoạt
- sở thích
- câu chuyện riêng
- nhiệm vụ riêng

Mỗi người đều góp một phần vào việc khôi phục Lễ hội Hoa.

# 2. NPC Categories

Prototype chỉ cần.

| Type | Prototype |
| --- | --- |
| Mayor | ✅ |
| Florist | ✅ |
| Elder | ✅ |
| Shopkeeper | ✅ |

Full Game.

Thêm.

- Botanist
- Child
- Fisherman
- Baker
- Artist
- Traveler
- Gardener

# 3. NPC Data

Mỗi NPC.

Có.

| Field | Description |
| --- | --- |
| NPC ID | Mã |
| Name | Tên |
| Age | Tuổi |
| Occupation | Nghề |
| Personality | Tính cách |
| Favorite Flowers | Hoa yêu thích |
| Schedule | Lịch sinh hoạt |
| Friendship | Mức thân thiết |
| Story Chapter | Chương xuất hiện |

# 4. Friendship System

Prototype.

Friendship.

Có.

5 cấp.

| Level | Name |
| --- | --- |
| 0 | Stranger |
| 1 | Acquaintance |
| 2 | Friend |
| 3 | Close Friend |
| 4 | Family |

Prototype.

Không cần.

Romance.

# 5. Cách tăng Friendship

| Action | Friendship |
| --- | --- |
| Talk | +1 |
| Gift Favorite Flower | +5 |
| Complete Quest | +10 |
| Festival Event | +15 |

Không có.

Spam.

Nói chuyện.

100 lần.

```text
↓
```

100 điểm.

Mỗi ngày.

Chỉ cộng.

1 lần.

# 6. NPC Daily Schedule

Prototype.

Ví dụ.

Mayor.

```text
08:00 Town Hall

10:00 Garden

12:00 Cafe

15:00 Town Hall

18:00 Home
```

Không cần.

AI.

Đi theo.

Waypoint.

Là đủ.

# 7. NPC Quests

Prototype.

Chỉ có.

Quest đơn giản.

Ví dụ.

```text
Need

3 Roses
↓
```

Reward.

```text
50 Coins
```

Hoặc.

```text
Need

Lavender
↓
```

Unlock.

Pressed Memory.

# 8. Flower Preferences

Mỗi NPC.

Có.

Hoa yêu thích.

Ví dụ.

| NPC | Favorite |
| --- | --- |
| Mayor | Lily |
| Florist | Rose |
| Elder | Daisy |

Nếu tặng đúng.

```text
↓
```

Friendship.

Tăng nhanh hơn.

# 9. Dialogue System

Prototype.

Chỉ cần.

3 loại.

```text
Normal Dialogue
Friendship Dialogue
Story Dialogue
```

Đủ.

# 10. Pressed Memories Trigger

Đây là phần quan trọng nhất.

Ví dụ.

NPC.

Nhìn thấy.

Flower Hairpin.

```text
↓
```

Nói.

```text
I remember...

Your grandfather always wore this.
↓
```

Unlock.

```text
Pressed Memory #03
```

Đây chính là nơi cốt truyện được kể.

# 11. Prototype NPC List

Prototype.

Chỉ cần.

| NPC | Role |
| --- | --- |
| Mayor Thomas | Mayor |
| Lily | Florist |
| Grandma Rose | Elder |
| Noah | General Store |

Chỉ cần.

4 NPC.

Prototype.

Đủ.

# 12. Prototype Rules

Prototype.

Có.

✅ Friendship

✅ Daily Schedule

✅ Simple Quest

✅ Story Trigger

Không cần.

❌ Romance

❌ Marriage

❌ Birthday

❌ Jealousy

❌ Family Tree

# 📌 NPC Gameplay Loop

```text
Meet NPC

↓

Talk

↓

Friendship

↓

Quest

↓

Flower Gift

↓

Pressed Memory

↓

Story Progress
```

# 💡 Future Feature 1 – Dynamic Dialogue

NPC.

Không nói.

Giống nhau.

Ví dụ.

Mùa hè.

Mayor.

```text
The roses are beautiful this year.
```

Mùa đông.

```text
The town feels lonely without flowers.
```

# 💡 Future Feature 2 – NPC Memory

Đây là ý tưởng mình rất thích.

Ví dụ.

Bạn.

Tặng.

Rose.

3 lần.

```text
↓
```

NPC.

Sau này.

Sẽ nói.

```text
You really love roses, don't you?
```

NPC.

Nhớ.

Hành động.

Người chơi.

# 💡 Future Feature 3 – Flower Knowledge

Ví dụ.

Florist.

Không chỉ bán.

Hoa.

Mà còn.

Cho.

Hint.

```text
Lavender prefers dry soil.
```

Hoặc.

```text
Some flowers bloom only under moonlight.
```

Không spoil.

Chỉ gợi ý.

# 💡 Future Feature 4 – NPC Relationship

NPC.

Không chỉ.

Có quan hệ.

Với người chơi.

Mà còn.

Có quan hệ.

Với nhau.

Ví dụ.

Mayor.

Hay.

Cafe Owner.

Hay.

Florist.

```text
↓
```

Có hội thoại riêng.

```text
↓
```

Thị trấn.

Có cảm giác.

Đang sống.

# 💡 Future Feature 5 – Community Restoration

Đây là ý tưởng mình vừa nghĩ.

Friendship.

Không chỉ.

Mở.

Dialogue.

Mà còn.

Khôi phục.

Thị trấn.

Ví dụ.

Friendship.

Mayor.

```text
↓
```

Town Square.

Được sửa.

Friendship.

Florist.

```text
↓
```

Flower Shop.

Trang trí đẹp hơn.

Friendship.

Grandma Rose.

```text
↓
```

Ancient Garden.

Được mở.

**Người chơi sẽ thấy thế giới thay đổi theo mối quan hệ, chứ không chỉ nhận vài đoạn hội thoại.**

# 🌟 Ý tưởng lớn mình muốn đưa vào Game Design Bible

## 🤝 NPC không phải là "máy phát nhiệm vụ"

Đây là nguyên tắc mình rất muốn giữ.

Trong nhiều game nông trại:

```text
NPC

↓

Quest

↓

Reward
```

Nhưng với game của chúng ta, mình muốn là:

```text
NPC

↓

Conversation

↓

Memory

↓

Trust

↓

Quest

↓

Story

↓

Town Changes
```

**Nghĩa là nhiệm vụ là kết quả của việc xây dựng mối quan hệ, chứ không phải mục tiêu duy nhất.**

Ví dụ:

- Bà Rose không nhờ người chơi tìm Lily ngay từ lần đầu gặp.
- Sau vài lần trò chuyện, bà kể về ông của nhân vật.
- Sau khi mở Pressed Memory #05, bà mới nhờ tìm một bông Lily đặc biệt.
- Khi hoàn thành, không chỉ nhận Coin, mà còn mở thêm một phần lịch sử của thị trấn.

**Theo mình, cách này sẽ khiến người chơi cảm thấy mình đang trở thành một phần của cộng đồng, đúng với tinh thần của một game cozy.**
