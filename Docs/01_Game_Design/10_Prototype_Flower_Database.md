Đây là phần mình mong chờ nhất. 😄

**Từ tài liệu 01 → 09 chúng ta đã xây dựng engine gameplay trên giấy.**

**Bây giờ 10 là lần đầu tiên chúng ta tạo nội dung thật của game.**

Đây cũng là tài liệu mà sau này Codex sẽ đọc rất nhiều.

# 📄 10_Prototype_Flower_Database.md

## 🎯 Mục tiêu

**Prototype không cần 100 loài hoa.**

**Chỉ cần khoảng 8–10 loài.**

Nhưng:

- đủ để test Growth
- đủ để test Quality
- đủ để test Economy
- đủ để test Breeding
- đủ để test Bloom Journal

# 🌸 Prototype Flower List

Mình đề xuất 10 loài sau.

| ID | Flower | Rarity | Season |
| --- | --- | --- | --- |
| FL001 | Daisy | Common | Spring |
| FL002 | Tulip | Common | Spring |
| FL003 | Rose | Common | Summer |
| FL004 | Lavender | Uncommon | Summer |
| FL005 | Lily | Uncommon | Summer |
| FL006 | Hydrangea | Rare | Summer |
| FL007 | Orchid | Rare | Autumn |
| FL008 | Blue Rose | Epic | Special |
| FL009 | Moon Lily | Legendary | Story |
| FL010 | Eternal Blossom | Mythic (Disabled) |  |

**Prototype chỉ dùng tới Moon Lily.**

Mythic để khóa.

# 🌼 Flower Progression

```text
Daisy
     │
     ├─────────────┐
     ▼             ▼
Tulip          Rose
     │             │
     └──────┐      │
            ▼      ▼
       Lavender   Lily
            │      │
            └──┐ ┌─┘
               ▼ ▼
          Hydrangea
               │
               ▼
            Orchid
               │
               ▼
          Blue Rose
               │
               ▼
           Moon Lily
```

**Đây là cây tiến hóa của Prototype.**

Không quá phức tạp.

# 📘 Prototype Flower Data

# 🌼 Daisy

| Field | Value |
| --- | --- |
| ID | FL001 |
| Name | Daisy |
| Scientific Name | Bellis perennis |
| Rarity | Common |
| Season | Spring |
| Growth | 3 Days |
| Regrow | No |
| Base Price | 30 |
| Seed Price | 15 |
| Language | Innocence |
| Can Breed | Yes |

# 🌷 Tulip

| Field | Value |
| --- | --- |
| ID | FL002 |
| Name | Tulip |
| Scientific Name | Tulipa gesneriana |
| Rarity | Common |
| Season | Spring |
| Growth | 4 Days |
| Regrow | No |
| Base Price | 45 |
| Seed Price | 22 |
| Language | Perfect Love |
| Can Breed | Yes |

# 🌹 Rose

| Field | Value |
| --- | --- |
| ID | FL003 |
| Name | Rose |
| Scientific Name | Rosa |
| Rarity | Common |
| Season | Summer |
| Growth | 5 Days |
| Regrow | No |
| Base Price | 55 |
| Seed Price | 28 |
| Language | Love |
| Can Breed | Yes |

# 💜 Lavender

| Field | Value |
| --- | --- |
| ID | FL004 |
| Name | Lavender |
| Scientific Name | Lavandula |
| Rarity | Uncommon |
| Season | Summer |
| Growth | 6 Days |
| Regrow | Yes |
| Base Price | 90 |
| Seed Price | 45 |
| Language | Serenity |
| Can Breed | Yes |

# 🤍 Lily

| Field | Value |
| --- | --- |
| ID | FL005 |
| Name | Lily |
| Scientific Name | Lilium |
| Rarity | Uncommon |
| Season | Summer |
| Growth | 5 Days |
| Regrow | No |
| Base Price | 95 |
| Seed Price | 48 |
| Language | Purity |
| Can Breed | Yes |

# 🩵 Hydrangea

| Field | Value |
| --- | --- |
| ID | FL006 |
| Name | Hydrangea |
| Scientific Name | Hydrangea macrophylla |
| Rarity | Rare |
| Season | Summer |
| Growth | 7 Days |
| Regrow | Yes |
| Base Price | 160 |
| Seed Price | 80 |
| Language | Gratitude |
| Can Breed | Yes |

# 🌺 Orchid

| Field | Value |
| --- | --- |
| ID | FL007 |
| Name | Orchid |
| Scientific Name | Orchidaceae |
| Rarity | Rare |
| Season | Autumn |
| Growth | 8 Days |
| Regrow | Yes |
| Base Price | 220 |
| Seed Price | 110 |
| Language | Elegance |
| Can Breed | Yes |

# 🌌 Blue Rose

| Field | Value |
| --- | --- |
| ID | FL008 |
| Name | Blue Rose |
| Scientific Name | Hybrid Rose |
| Rarity | Epic |
| Season | Special |
| Growth | 9 Days |
| Regrow | No |
| Base Price | 420 |
| Seed Price | N/A (Breed Only) |
| Language | Miracle |
| Can Breed | Yes |

# 🌙 Moon Lily

| Field | Value |
| --- | --- |
| ID | FL009 |
| Name | Moon Lily |
| Scientific Name | Unknown |
| Rarity | Legendary |
| Season | Story |
| Growth | 10 Days |
| Regrow | No |
| Base Price | 900 |
| Seed Price | N/A |
| Language | Hope |
| Can Breed | No (Prototype) |

# 🌸 Prototype Breeding Tree

| Parent A | Parent B | Result |
| --- | --- | --- |
| Daisy | Tulip | Lavender |
| Tulip | Rose | Lily |
| Lavender | Lily | Hydrangea |
| Hydrangea | Rose | Orchid |
| Orchid | Lily | Blue Rose |
| Blue Rose | Hydrangea | Moon Lily |

**Prototype chỉ cần 6 công thức.**

# 🎮 Unlock Order

```text
Start

↓

Daisy
Tulip
Rose

↓

Lavender

↓

Lily

↓

Hydrangea

↓

Orchid

↓

Blue Rose

↓

Moon Lily
```

# 📌 Prototype Goal

Người chơi.

Không cần.

Sưu tập.

100 loài.

Mục tiêu chỉ là.

```text
Unlock Moon Lily
↓
```

Xem Ending.

```text
↓
```

Prototype hoàn thành.

# 💡 Future Feature 1 – Botanical Classification

**Đây là ý tưởng mình muốn đưa vào Game Design Bible.**

**Ngoài Rarity, mỗi hoa sẽ có phân loại thực vật học.**

Ví dụ:

| Classification | Ví dụ |
| --- | --- |
| Garden Flower | Rose |
| Wild Flower | Daisy |
| Aquatic Flower | Lotus |
| Mountain Flower | Edelweiss |
| Tropical Flower | Orchid |

**Sau này NPC, nhiệm vụ và lai tạo có thể yêu cầu theo nhóm thực vật, không chỉ theo tên hoa.**

# 💡 Future Feature 2 – Bloom Family

Thay vì chỉ nhìn từng hoa riêng lẻ.

Mỗi loài sẽ thuộc một "gia đình".

Ví dụ.

```text
Rose Family

↓

Rose

White Rose

Pink Rose

Blue Rose

Golden Rose
```

**Người chơi sẽ có cảm giác đang hoàn thiện cả một họ hoa.**

# 💡 Future Feature 3 – Real Botany Mode

**Vì nhân vật là sinh viên Botany, mình nghĩ sau này Bloom Journal có thể có thêm một nút:**

**Scientific Notes**

Trong đó hiển thị:

- Tên khoa học.
- Họ thực vật (Family).
- Môi trường sống.
- Phân bố.
- Ý nghĩa văn hóa.

Người chơi chỉ thích thư giãn có thể bỏ qua, nhưng những ai yêu thực vật sẽ có thêm rất nhiều kiến thức. Điều này cũng tạo bản sắc riêng cho game.

# ⭐ Mình có một góp ý lớn sau khi hoàn thành tài liệu số 10

Đến đây mình nhận ra một điều:

**Chúng ta không nên xem Flower Database là một bảng dữ liệu.**

**Nó nên là một Living Database.**

**Nghĩa là mỗi khi thiết kế thêm một loài hoa mới trong tương lai, chúng ta không cần sửa bất kỳ hệ thống nào (Rarity, Growth, Economy, Breeding...). Chỉ cần tạo thêm một bản ghi theo đúng mẫu này là game đã tự hiểu cách hoạt động của loài hoa đó.**

**Nếu giữ được nguyên tắc này, sau này mở rộng từ 10 loài lên 300 loài gần như chỉ là công việc nhập dữ liệu và tạo asset, chứ không phải viết lại code. Theo mình, đây là một trong những mục tiêu quan trọng nhất của thiết kế hệ thống game ngay từ đầu.**
