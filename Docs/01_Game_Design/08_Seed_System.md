# 📄 08_Seed_System.md

## 🎯 Mục tiêu

Trả lời câu hỏi:

**Hạt giống trong game hoạt động như thế nào?**

Không chỉ là một icon trong Inventory.

Mà là một đối tượng có dữ liệu riêng.

# 🌱 Seed System v1.0

# 1. Seed Definition

Mỗi hạt giống phải có các thông tin sau.

| Field | Type | Description |
| --- | --- | --- |
| Seed ID | String | Mã định danh duy nhất |
| Seed Name | String | Tên hạt giống |
| Flower ID | String | Hoa sẽ mọc thành |
| Rarity | Enum | Độ hiếm của hạt |
| Buy Price | Integer | Giá mua |
| Sell Price | Integer | Giá bán (nếu bán được) |
| Stack Size | Integer | Số lượng tối đa trong 1 ô |
| Tradable | Boolean | Có thể bán không |
| Unlock Condition | String | Điều kiện mở khóa |

# 2. Seed Lifecycle

```text
Buy Seed
      │
      ▼
Store in Inventory
      │
      ▼
Plant
      │
      ▼
Seed disappears
      │
      ▼
Flower grows
      │
      ▼
Harvest
      │
      ▼
Sell / Breed
```

Nếu lai thành công.

```text
Breed

↓

New Seed

↓

Inventory
```

# 3. Các nguồn nhận hạt giống

| Nguồn | Prototype |
| --- | --- |
| Shop | ✅ |
| Breeding | ✅ |
| Quest | ❌ |
| Festival | ❌ |
| Pressed Memories | ❌ |
| NPC Gift | ❌ |

# 4. Seed Quality

Prototype.

**Không có Quality cho Seed.**

Quality chỉ xuất hiện sau khi hoa được chăm sóc.

Điều này giúp gameplay đơn giản.

# 5. Seed Rarity

Seed sẽ có cùng Rarity với loài hoa của nó.

Ví dụ.

| Seed | Flower |
| --- | --- |
| Rose Seed | Common |
| Tulip Seed | Common |
| Blue Rose Seed | Rare |
| Moon Lily Seed | Legendary |

# 6. Stack Rules

| Item | Max Stack |
| --- | --- |
| Seed | 99 |
| Flower | 99 (Prototype) |

Prototype dùng stack 99 cho đơn giản.

# 7. Planting Rules

Khi người chơi trồng.

```text
Inventory

Rose Seed ×8

↓

Plant

↓

Inventory

Rose Seed ×7
```

Đây là thao tác Codex sẽ rất dễ lập trình.

# 8. Seed Pricing

Nguyên tắc.

```text
Seed Price

≈

40%~60%

Average Flower Sell Price
```

Ví dụ.

| Flower | Sell | Seed |
| --- | --- | --- |
| Rose | 50 | 25 |
| Tulip | 70 | 35 |
| Lavender | 120 | 60 |

# 9. Hybrid Seeds

Nếu lai thành công.

Ví dụ.

```text
Rose

+

Tulip

↓

Peony Seed
```

**Người chơi không nhận hoa ngay.**

Luôn nhận.

```text
Seed
```

Điều này giữ nguyên gameplay trồng trọt.

# 10. Unlock Rules

| Rarity | Cách mở |
| --- | --- |
| Common | Shop |
| Uncommon | Shop sau tiến trình |
| Rare | Breeding |
| Epic | Breeding |
| Legendary | Story hoặc Breeding đặc biệt |
| Mythic | Full Game |

# 11. Prototype Rules

Prototype chỉ cần.

✅ Mua Seed

✅ Trồng Seed

✅ Seed biến mất khi trồng

✅ Lai tạo ra Seed mới

Không cần.

❌ Seed Mutation

❌ Seed Quality

❌ Seed Expiration

❌ Seed Storage

# 12. Data Flow

```text
Shop
   │
   ▼
Seed Inventory
   │
   ▼
Plant
   │
   ▼
Growth
   │
   ▼
Flower
   │
   ▼
Harvest
   │
   ▼
Sell
   │
   ▼
Coins
```

hoặc

```text
Flower

↓

Breed

↓

Hybrid Seed

↓

Inventory

↓

Plant Again
```

# 💡 Future Feature 1 – Seed Encyclopedia

Bloom Journal sẽ có thêm mục:

```text
Seeds
```

Người chơi không chỉ sưu tầm hoa.

Mà còn.

```text
Collected Seeds

27 / 180
```

# 💡 Future Feature 2 – Seed Traits

Mỗi hạt giống có đặc điểm riêng.

Ví dụ.

```text
Ancient Rose Seed

↓

Needs Moonlight
```

hoặc.

```text
Frost Lily Seed

↓

Can only be planted in Winter
```

# 💡 Future Feature 3 – Seed Mutation

Một trong những ý tưởng mình rất thích.

Ví dụ.

```text
Rose Seed
```

Có.

```text
0.2%

↓

Mutated Rose Seed
↓
```

Trồng.

```text
↓
```

Không biết sẽ mọc gì.

```text
↓
```

Người chơi rất hồi hộp.

**Prototype không nên có.**

Nhưng Full Game rất đáng để phát triển.

# 📌 Golden Rule

Mình muốn thêm một nguyên tắc vào Game Design Bible:

**Người chơi không bao giờ nhận trực tiếp một loài hoa mới sau khi lai tạo.**

**Họ luôn nhận một hạt giống mới.**

Lý do:

- Giữ đúng tinh thần "trồng và chăm sóc".
- Người chơi vẫn phải tự tay gieo trồng giống mới.
- Tạo cảm giác thành tựu khi nhìn loài hoa mới nở lần đầu.
- Giữ vòng lặp gameplay nhất quán.
