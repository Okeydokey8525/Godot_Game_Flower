# 📄 05_Growth_System.md

## 🎯 Mục tiêu

Trả lời câu hỏi:

**Một bông hoa sẽ trải qua những giai đoạn nào từ khi gieo hạt đến khi héo?**

Đây là hệ thống mà người chơi nhìn thấy nhiều nhất trong game.

# 🌱 Growth System v1.0

> **Canonical time reference:** This document describes pacing. Storage, game-day conversion, and balance calculations are defined only by [Time Convention](../Architecture/Time_Convention.md).

## 1. Growth Flow

```text
Seed
   │
   ▼
Sprout
   │
   ▼
Young Plant
   │
   ▼
Bud
   │
   ▼
Bloom
   │
   ▼
Perfect Bloom
   │
   ▼
Wilt
```

# 2. Growth Stages

| Stage | Tên | Người chơi thấy gì |
| --- | --- | --- |
| Stage 0 | Seed | Hạt giống vừa gieo |
| Stage 1 | Sprout | Mầm nhỏ nhú lên |
| Stage 2 | Young Plant | Cây non có vài lá |
| Stage 3 | Bud | Xuất hiện nụ hoa |
| Stage 4 | Bloom | Hoa nở |
| Stage 5 | Perfect Bloom | Hoa nở đẹp nhất |
| Stage 6 | Wilt | Hoa bắt đầu héo |

# 3. Gameplay của từng giai đoạn

| Stage | Có thể làm gì |
| --- | --- |
| Seed | Tưới nước |
| Sprout | Tưới nước |
| Young Plant | Tưới nước |
| Bud | Theo dõi |
| Bloom | Có thể thu hoạch |
| Perfect Bloom | Thu hoạch đẹp nhất |
| Wilt | Giá trị giảm mạnh |

# 4. Điều kiện chuyển giai đoạn

Ví dụ Prototype.

| Điều kiện | Kết quả |
| --- | --- |
| Đủ số ngày | Sang giai đoạn tiếp theo |
| Thiếu nước | Chậm phát triển |
| Đúng đất | Phát triển bình thường |
| Sai đất | Chậm hơn |

**Prototype không cần hệ thống phức tạp.**

# 5. Growth Time

Ví dụ.

| Flower | Total Days |
| --- | --- |
| Rose | 5 |
| Tulip | 4 |
| Daisy | 3 |
| Lavender | 6 |

Đây chỉ là tổng số ngày.

Chi tiết từng ngày sẽ tính sau.

# 6. Regrow System

Không phải hoa nào cũng giống nhau.

| Regrow | Ý nghĩa |
| --- | --- |
| Yes | Sau thu hoạch sẽ ra hoa lại |
| No | Thu hoạch xong phải trồng mới |

Ví dụ.

```text
Lavender

↓

Yes
Tulip

↓

No
```

# 7. Harvest Timing

Đây là gameplay rất hay.

| Thời điểm | Kết quả |
| --- | --- |
| Thu quá sớm | Chưa đủ Quality |
| Thu đúng Bloom | Bình thường |
| Thu đúng Perfect Bloom | Chất lượng cao nhất |
| Thu khi Wilt | Giá giảm |

# 8. Watering Rules

Prototype chỉ cần.

| Trạng thái | Hiệu ứng |
| --- | --- |
| Đủ nước | Phát triển bình thường |
| Thiếu nước | Chậm phát triển |
| Quá nhiều nước | Quality giảm |

# 9. Visual Changes

Mỗi Stage.

Sprite sẽ đổi.

```text
Seed

↓

Sprout

↓

Young Plant

↓

Bud

↓

Bloom

↓

Perfect Bloom

↓

Wilt
```

Điều này giúp người chơi biết khi nào nên thu hoạch.

# 10. Prototype Rules

Prototype chỉ cần:

✅ Gieo hạt

✅ Tưới nước

✅ Đợi đủ ngày

✅ Thu hoạch

Chưa cần:

❌ Phân bón

❌ Côn trùng

❌ Mưa

❌ Tuyết

❌ Gió

❌ Bệnh cây

# 📌 Growth Cycle

```text
Buy Seed
      │
      ▼
Plant Seed
      │
      ▼
Water Daily
      │
      ▼
Grow
      │
      ▼
Bloom
      │
      ▼
Perfect Bloom
      │
      ▼
Harvest
      │
      ▼
Sell / Breed / Journal
```

Đây sẽ là vòng lặp mà người chơi thực hiện hàng ngày.

# 🎮 Gameplay Rules

## Một ngày trong game

Người chơi thức dậy.

```text
↓
```

Kiểm tra vườn.

```text
↓
```

Hoa nào cần tưới.

```text
↓
```

Tưới.

```text
↓
```

Một số hoa chuyển sang Stage mới.

```text
↓
```

Một số hoa nở.

```text
↓
```

Thu hoạch.

```text
↓
```

Đưa vào Bloom Journal hoặc bán hoặc đem đi lai.

```text
↓
```

Ngày kết thúc.

# 💡 Mình có một ý tưởng nâng cấp rất hợp với game của chúng ta

**Mình nghĩ Perfect Bloom không nên chỉ là một "giai đoạn cuối", mà nên là một khoảng thời gian ngắn.**

Ví dụ:

- Hoa nở (Bloom) → sau một khoảng ngắn đạt Perfect Bloom.
- Perfect Bloom chỉ kéo dài 1 ngày trong game.
- Nếu người chơi thu hoạch đúng lúc, sẽ nhận:
- ★★★★★ dễ hơn.
- Giá bán cao hơn.
- Điểm Festival cao hơn.
- Tỉ lệ lai tạo tốt hơn.
- Nếu bỏ lỡ, hoa chuyển sang Wilt.

**Điều này tạo ra một quyết định thú vị mỗi ngày: hôm nay nên đi khám phá thị trấn hay ở lại thu hoạch bông hoa vừa đạt Perfect Bloom? Nó không tạo áp lực lớn vì chỉ có vài bông ở trạng thái này cùng lúc, nhưng đủ để người chơi cảm thấy việc quan sát khu vườn của mình có ý nghĩa.**

## 📅 Sau khi hoàn thành Growth System

Chúng ta sẽ có:

```text
✅ 01 Flower Definition
✅ 02 Prototype Scope
✅ 03 Rarity System
✅ 04 Quality System
✅ 05 Growth System

➡️ 06 Breeding System ⭐⭐⭐⭐⭐ (Trái tim của game)
➡️ 07 Economy System
➡️ 08 Flower Database
```

**Theo mình, 06 - Breeding System sẽ là tài liệu quan trọng nhất trong toàn bộ Flower System, vì đây chính là cơ chế tạo nên sự khác biệt của game so với các game nông trại thông thường. Khi hoàn thành tài liệu này, chúng ta sẽ bắt đầu thấy "linh hồn" của gameplay xuất hiện.**
