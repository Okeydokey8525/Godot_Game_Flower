**Tuyệt. 😄 Theo mình thì 13 - Village System là tài liệu sẽ quyết định 80% cảm giác của game.**

Người chơi có thể quên một nhiệm vụ.

Có thể quên một NPC.

Nhưng họ sẽ luôn nhớ:

**"Thị trấn này đem lại cảm giác như thế nào."**

Vì vậy mình không muốn Village chỉ là "một cái map".

**Nó phải là một nơi có lịch sử, có ký ức và dần hồi sinh theo hành động của người chơi.**

# 📄 13_Village_System.md

# 🎯 Mục tiêu

Trả lời câu hỏi:

Thế giới của game được xây dựng như thế nào?

và

Làm sao để người chơi luôn muốn khám phá thêm?

# 🏡 Village System v1.0

# 1. Core Concept

**Thị trấn từng nổi tiếng với Lễ hội Hoa.**

Sau nhiều năm.

Các giống hoa quý biến mất.

```text
↓
```

Khách du lịch ít dần.

```text
↓
```

Một số khu vực bị bỏ hoang.

```text
↓
```

Lễ hội dừng tổ chức.

```text
↓
```

Người chơi trở về.

```text
↓
```

Khôi phục thị trấn.

# 2. Village Layout

Prototype.

Chỉ cần.

```text
                 Ancient Garden (Locked)
                        │
                        │
        Forest Trail ───┼──── Flower Hill (Locked)
                        │
                        │
   Player Farm ─ Town Square ─ Flower Shop
                        │
                        │
               General Store
                        │
                        │
                 Mayor Hall
```

Prototype.

Chỉ khoảng.

6~7 khu.

# 3. Starting Areas

Prototype.

Ban đầu.

Mở.

| Area | Status |
| --- | --- |
| Player Farm | ✅ |
| Town Square | ✅ |
| Flower Shop | ✅ |
| General Store | ✅ |
| Mayor Hall | ✅ |

Khóa.

| Area | Unlock |
| --- | --- |
| Ancient Garden | Story |
| Flower Hill | Story |

# 4. Player Farm

Đây là khu quan trọng nhất.

Có.

- Flower Field
- Small House
- Mailbox
- Bloom Journal Desk

Prototype.

Không cần.

Trang trí.

# 5. Town Square

Trung tâm.

Của thị trấn.

Có.

- Fountain
- Festival Stage
- Notice Board

Đây là nơi.

Festival.

Diễn ra.

# 6. Flower Shop

NPC.

Lily.

Làm việc.

Bán.

- Seeds
- Hybrid Seeds (sau này)
- Flower Books

Prototype.

Chỉ bán.

Seed.

# 7. General Store

NPC.

Noah.

Bán.

- Seeds
- Basic Tools

Prototype.

Có thể gộp với Flower Shop để giảm khối lượng công việc.

# 8. Mayor Hall

Mayor Thomas.

Đây là nơi.

Nhận.

Main Quest.

Khôi phục.

Festival.

# 9. Ancient Garden

Đây là khu vực mình rất thích.

Ban đầu.

```text
Locked
```

Sau khi.

Story.

Tiến triển.

```text
↓
```

Mở.

```text
↓
```

Có.

Legendary Flowers.

```text
↓
```

Pressed Memories.

```text
↓
```

Grandfather's Research.

# 10. Exploration

Prototype.

Không cần.

Open World.

Chỉ cần.

Người chơi.

Đi bộ.

Giữa.

Các khu.

# 11. Fast Travel

Prototype.

Không cần.

Map.

Rất nhỏ.

# 12. Village Progression

Đây là điểm mình muốn làm khác nhiều game khác.

Thị trấn.

Không đứng yên.

Ví dụ.

Game bắt đầu.

```text
Dead Fountain
↓
```

Festival chuẩn bị.

```text
↓
Flowers appear
↓
```

Festival hoàn thành.

```text
↓
People gather
↓
```

Town.

Đẹp dần.

# 13. Prototype Rules

Prototype.

Có.

✅ Walking

✅ NPC

✅ Flower Field

✅ Story Area

Không cần.

❌ Weather

❌ Animals

❌ Fishing

❌ Mining

❌ Mount

# 📌 World Flow

```text
Wake Up

↓

Farm

↓

Town

↓

NPC

↓

Quest

↓

Flower

↓

Back Home

↓

Sleep
```

Đây là gameplay loop.

Mỗi ngày.

# 💡 Future Feature 1 – Seasonal Decoration

Xuân.

```text
↓
```

Hoa.

Khắp nơi.

Thu.

```text
↓
```

Lá vàng.

Đông.

```text
↓
```

Đèn.

Không cần tuyết nếu không phù hợp với bối cảnh.

Thị trấn thay đổi theo mùa sẽ giúp người chơi luôn có cảm giác mới mẻ.

# 💡 Future Feature 2 – Town Restoration

Đây là ý tưởng mình rất thích.

Không phải.

Người chơi.

Xây.

Nhà.

Mà.

Khôi phục.

Thị trấn.

Ví dụ.

Friendship.

Mayor.

```text
↓
```

Fountain.

Hoạt động.

Friendship.

Florist.

```text
↓
```

Flower Shop.

Trang trí.

Friendship.

Festival.

```text
↓
```

Town Square.

Đầy hoa.

Thị trấn sẽ thay đổi theo tiến trình của người chơi.

# 💡 Future Feature 3 – Hidden Places

Ví dụ.

```text
Ancient Tree
↓
```

Chỉ mở.

Sau.

Pressed Memory #12.

Hoặc.

```text
Grandfather's Greenhouse
↓
```

Chỉ mở.

Sau.

Moon Lily.

Điều này khuyến khích khám phá thay vì chỉ trồng hoa.

# 💡 Future Feature 4 – Village Reputation

Đây là ý tưởng mới.

Thay vì chỉ có Friendship.

Toàn thị trấn.

Có.

```text
Village Reputation
```

Ví dụ.

0%

```text
↓
```

Thị trấn.

Vắng vẻ.

50%

```text
↓
```

Khách.

Bắt đầu.

Đến.

100%

```text
↓
```

Flower Festival.

Đông người.

```text
↓
```

Các cửa hàng.

Mở rộng.

Điều này tạo cảm giác người chơi thực sự đang hồi sinh cả thị trấn.

# 💡 Future Feature 5 – Living Village

Đây là ý tưởng mình muốn giữ cho phiên bản lớn.

NPC.

Không chỉ.

Đi.

Theo lịch.

Mà còn.

Tương tác.

Với nhau.

Ví dụ.

Buổi sáng.

Florist.

Mua bánh.

```text
↓
```

Mayor.

Ngồi.

Cafe.

```text
↓
```

Grandma Rose.

Tưới.

Hoa.

```text
↓
```

Trẻ con.

Chơi.

Quảng trường.

Người chơi đứng nhìn cũng thấy thế giới đang sống.

# 🌟 Ý tưởng lớn mình muốn đưa vào Game Design Bible

## 🌸 Thị trấn là nhân vật thứ tư

Hiện tại game có:

- 👤 Nhân vật chính.
- 👴 Người ông.
- 📖 Bloom Journal.
- 🏡 Thị trấn.

**Theo mình, Village cũng nên có một "arc phát triển" như một nhân vật.**

Ví dụ:

| Giai đoạn | Trạng thái thị trấn |
| --- | --- |
| Chương 1 | Im lặng, hoa ít, quảng trường vắng |
| Chương 2 | Người dân bắt đầu trồng hoa trở lại |
| Chương 3 | Một vài cửa hàng được sửa sang |
| Chương 4 | Khách từ nơi khác ghé thăm |
| Chương cuối | Lễ hội Hoa được khôi phục, thị trấn rực rỡ |

**Như vậy, khi người chơi nhìn lại lúc kết thúc game, họ sẽ thấy không chỉ nhân vật trưởng thành, mà cả thị trấn cũng đã thay đổi nhờ những việc mình làm.**

# 🚀 Mình có một đề xuất rất quan trọng trước khi sang Story System

**Đến đây, mình nhận ra game của chúng ta có 3 trục tiến trình chính:**

### 🌸 Gameplay Progression

- Trồng hoa.
- Lai tạo.
- Khám phá loài mới.

### 📖 Story Progression

- Pressed Memories.
- Bí mật về người ông.
- Khôi phục Lễ hội Hoa.

### 🏡 World Progression

- Mở khu vực mới.
- Thị trấn thay đổi.
- NPC thay đổi.

**Theo mình, 14_Story_System.md không nên chỉ kể cốt truyện, mà nên thiết kế cách ba trục này luôn song hành.**

Ví dụ:

- Mở khóa Blue Rose → mở Pressed Memory #15 → mở Ancient Garden.
- Giúp Florist hoàn thành nhiệm vụ → mở thêm giống hoa mới → cửa hàng được nâng cấp.
- Hoàn thành một chương truyện → quảng trường thay đổi, nhiều NPC mới xuất hiện.

**Đó là điều sẽ khiến người chơi luôn cảm thấy mọi hành động của mình đều có tác động đến thế giới, thay vì gameplay, cốt truyện và bản đồ hoạt động tách rời nhau. Theo mình, đây sẽ là nền tảng quan trọng nhất để chúng ta xây dựng 14 – Story System.**
