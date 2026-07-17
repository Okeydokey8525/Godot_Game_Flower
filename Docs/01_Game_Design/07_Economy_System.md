# 📄 07_Economy_System.md

## 🎯 Mục tiêu

Trả lời câu hỏi:

**Người chơi kiếm tiền như thế nào? Tiêu tiền vào đâu? Làm sao để kinh tế game luôn cân bằng?**

**Một game cozy hay không phải vì kiếm tiền thật nhanh, mà vì người chơi luôn có mục tiêu nhỏ để phấn đấu.**

# 💰 Economy System v1.0

## 1. Core Gameplay Loop

```text
Buy Seeds
      │
      ▼
Plant Flowers
      │
      ▼
Take Care
      │
      ▼
Harvest
      │
      ▼
Sell / Breed / Donate
      │
      ▼
Earn Coins
      │
      ▼
Buy Better Seeds & Unlock New Content
      │
      ▼
Repeat
```

# 2. Currency

**Prototype chỉ cần 1 loại tiền.**

| Currency | Description |
| --- | --- |
| Bloom Coins | Tiền chính dùng trong toàn bộ game |

Sau này Full Game có thể thêm:

- Festival Tokens
- Research Points
- Friendship Points

**Nhưng Prototype không cần.**

# 3. Thu nhập (Income)

| Nguồn | Prototype |
| --- | --- |
| Bán hoa | ✅ |
| Hoàn thành nhiệm vụ | ✅ |
| Festival | ❌ |
| NPC Gift Reward | ❌ |
| Museum Donation | ❌ |

# 4. Chi tiêu (Expenses)

| Nội dung | Prototype |
| --- | --- |
| Mua hạt giống | ✅ |
| Mua dụng cụ | ❌ |
| Mở khu vườn mới | ❌ |
| Trang trí | ❌ |
| Greenhouse | ❌ |

Prototype càng đơn giản càng tốt.

# 5. Giá bán

**Giá bán phụ thuộc vào 2 yếu tố:**

```text
Flower Rarity

×

Flower Quality
```

Ví dụ.

| Flower | Quality | Sell Price |
| --- | --- | --- |
| Rose | ★☆☆☆☆ | 25 |
| Rose | ★★★☆☆ | 40 |
| Rose | ★★★★★ | 70 |
| Blue Rose | ★★★☆☆ | 180 |
| Moon Lily | ★★★★★ | 900 |

# 6. Giá mua hạt giống

Nguyên tắc:

```text
Giá hạt giống

<

Giá bán trung bình
```

Ví dụ.

| Seed | Buy Price | Average Sell |
| --- | --- | --- |
| Rose | 20 | 50 |
| Tulip | 25 | 60 |
| Lily | 30 | 75 |

Người chơi luôn có lợi nhuận nếu chăm sóc tốt.

# 7. Value Formula (Prototype)

Để Codex dễ code.

```text
Sell Price

=

Base Price

×

Rarity Multiplier

×

Quality Multiplier
```

Ví dụ.

Rose.

```text
Base Price = 40
```

Common

```text
×1
```

★★★★★

```text
×1.8
↓
72 Coins
```

Sau này chỉ cần sửa Multiplier là cân bằng lại toàn game.

# 8. Rarity Multiplier

| Rarity | Multiplier |
| --- | --- |
| Common | ×1.0 |
| Uncommon | ×1.4 |
| Rare | ×2.0 |
| Epic | ×3.5 |
| Legendary | ×6.0 |
| Mythic | ×10.0 |

# 9. Quality Multiplier

| Quality | Multiplier |
| --- | --- |
| ★☆☆☆☆ | ×0.8 |
| ★★☆☆☆ | ×1.0 |
| ★★★☆☆ | ×1.2 |
| ★★★★☆ | ×1.5 |
| ★★★★★ | ×1.8 |

# 10. Player Choices

Khi thu hoạch.

Người chơi luôn có 3 lựa chọn.

```text
Flower

↓

Sell

Breed

Journal
```

Không phải hoa nào cũng nên bán.

Ví dụ.

Legendary.

Có thể giữ lại.

Lai.

Hoặc.

Làm nhiệm vụ.

# 11. Prototype Shop

Prototype chỉ cần bán.

| Item | Available |
| --- | --- |
| Rose Seed | ✅ |
| Tulip Seed | ✅ |
| Daisy Seed | ✅ |
| Lily Seed | Mở khóa sau |
| Lavender Seed | Mở khóa sau |

Không cần.

- Phân bón
- Bình tưới mới
- Nội thất

# 12. Anti-Inflation Rules

Đây là phần rất nhiều game indie quên.

Nếu người chơi kiếm tiền quá nhanh.

```text
↓
```

Game hết mục tiêu.

Prototype nên giữ.

- Hoa hiếm khó kiếm.
- Không bán Legendary Seed.
- Lai tạo tốn thời gian.
- Chăm sóc tốt mới có ★★★★★.

# 13. Economy Balance Goals

Mục tiêu của Prototype.

| Mục tiêu | Giá trị |
| --- | --- |
| Mua hạt giống mới | Dễ đạt |
| Lai giống mới | Cần cố gắng |
| Kiếm Legendary | Mục tiêu dài hơn |

Người chơi luôn có cái để hướng tới.

# 💡 Future Feature 1 – Flower Market

Mỗi ngày.

Shop.

Có giá khác nhau.

Ví dụ.

```text
Today's Demand

Rose

+20%
↓
```

Hôm nay.

Nên bán Rose.

# 💡 Future Feature 2 – Festival Economy

Lễ hội.

Không chỉ để thi.

Mà còn.

```text
Festival Coins
```

Dùng mua.

- Decoration.
- Rare Seeds.
- Exclusive Items.

# 💡 Future Feature 3 – Florist Orders

Mỗi ngày.

Shop hoa.

Đăng.

```text
Today's Order

Need

5 Tulips

★★★★★

Reward

300 Coins
```

Đây là nhiệm vụ nhỏ, giúp người chơi có mục tiêu ngắn hạn ngoài việc trồng và lai hoa.

# 💡 Future Feature 4 – Research Funding

Vì nhân vật là sinh viên ngành Botany.

Mỗi khi hoàn thành nghiên cứu.

Có thể nhận.

```text
Research Grant
↓
```

Tiền tài trợ nghiên cứu.

```text
↓
```

Mở khóa.

- Greenhouse.
- Laboratory.
- Ancient Garden.

Điều này hợp lý hơn việc "tự nhiên có tiền".

# 📌 Quy tắc vàng của Economy

Mình muốn ghi thành một nguyên tắc trong Game Design Bible:

**Không có lựa chọn nào là "đúng tuyệt đối".**

Một bông hoa quý khi thu hoạch sẽ luôn khiến người chơi phải suy nghĩ:

- 🌼 Bán để lấy tiền?
- 🌱 Giữ lại để lai giống?
- 📖 Đưa vào Bloom Journal để hoàn thiện bộ sưu tập?
- 🎁 Giữ cho nhiệm vụ của NPC?

Nếu người chơi luôn chỉ có một đáp án tối ưu (ví dụ "cứ bán hết"), gameplay sẽ nhanh chóng lặp lại. Nhưng nếu mỗi bông hoa đều là một quyết định nhỏ, khu vườn sẽ trở nên có ý nghĩa hơn rất nhiều.
