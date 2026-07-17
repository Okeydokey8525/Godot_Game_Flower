# 📄 04_Quality_System.md

## 🎯 Mục tiêu

Trả lời câu hỏi:

**Điều gì quyết định một bông hoa đẹp hay xấu?**

Khác với Rarity.

Ví dụ:

```text
Rose
(Common)

★★★★★
```

vẫn có thể bán đắt hơn

```text
Blue Rose
(Rare)

★★☆☆☆
```

vì người chơi chăm sóc tốt hơn.

# 🌸 Quality System v1.0

## 1. Quality Levels

| Quality | Tên | Ý nghĩa |
| --- | --- | --- |
| ★☆☆☆☆ | Poor | Hoa phát triển kém |
| ★★☆☆☆ | Normal | Đạt mức cơ bản |
| ★★★☆☆ | Good | Đẹp và khỏe mạnh |
| ★★★★☆ | Excellent | Chất lượng cao |
| ★★★★★ | Perfect | Hoa hoàn hảo |

# 2. Chất lượng ảnh hưởng đến gì?

| Hệ thống | Ảnh hưởng |
| --- | --- |
| Giá bán | ⭐⭐⭐⭐⭐ |
| Điểm Festival | ⭐⭐⭐⭐⭐ |
| Giá trị quà tặng NPC | ⭐⭐⭐⭐ |
| Điểm nghiên cứu | ⭐⭐⭐ |
| Tỉ lệ lai tạo | ⭐⭐⭐ |
| Bloom Journal | ⭐⭐ |

# 3. Điều gì làm tăng Quality?

Đây mới là gameplay.

| Yếu tố | Ảnh hưởng |
| --- | --- |
| Tưới nước đúng lúc | ✅ |
| Đủ ánh sáng | ✅ |
| Đúng loại đất | ✅ |
| Không bị sâu bệnh | ✅ |
| Thu hoạch đúng thời điểm | ✅ |

Prototype chỉ cần 3 yếu tố đầu là đủ.

# 4. Điều gì làm giảm Quality?

| Nguyên nhân | Kết quả |
| --- | --- |
| Quên tưới | Quality giảm |
| Tưới quá nhiều | Quality giảm |
| Sai đất | Phát triển chậm |
| Thu hoạch quá sớm | Không đạt ★★★★★ |
| Thu hoạch quá muộn | Hoa héo |

# 5. Công thức Quality (Prototype)

**Hiện tại không cần AI hay Machine Learning, chỉ cần một điểm số đơn giản.**

Ví dụ:

```text
Quality Score = 100
```

Sau đó trừ điểm.

| Lỗi | Trừ điểm |
| --- | --- |
| Quên tưới | -20 |
| Thiếu nắng | -10 |
| Sai đất | -15 |
| Thu hoạch muộn | -15 |

Ví dụ:

```text
100

-10

-15

=75
↓
★★★★☆
```

Sau này nếu muốn có thời tiết, phân bón, sâu bệnh... chỉ việc cộng thêm vào công thức.

# 6. Quality không phải may mắn

Đây là nguyên tắc mình rất muốn giữ.

❌ Không phải:

```text
Random

★★★★☆
```

Mà phải là:

```text
Người chơi chăm sóc tốt

↓

★★★★★
```

Người chơi phải cảm thấy:

"Bông hoa đẹp vì mình chăm sóc tốt."

# 7. Quan hệ với Rarity

Ví dụ:

| Flower | Rarity | Quality |
| --- | --- | --- |
| Rose | Common | ★★★★★ |
| Tulip | Common | ★★★☆☆ |
| Blue Rose | Rare | ★★☆☆☆ |
| Moon Lily | Legendary | ★★★★★ |

**Hai hệ thống hoạt động độc lập.**

# 8. Prototype Rules

Để Prototype đơn giản.

Chỉ có:

- ✅ Tưới nước
- ✅ Đúng đất
- ✅ Thu hoạch đúng lúc

Chưa cần:

- ❌ Phân bón
- ❌ Côn trùng
- ❌ Gió
- ❌ Nhiệt độ
- ❌ Độ ẩm
- ❌ Phân tích đất

Những cái đó sẽ để phiên bản sau.

# 💡 Mình có một ý tưởng mà mình nghĩ sẽ trở thành "đặc sản" của game

Đây là ý tưởng mình vừa nghĩ ra trong lúc sắp xếp hệ thống.

## ✨ Flower Traits (Đặc tính của từng loài hoa)

**Thay vì mọi hoa đều dùng cùng một công thức Quality, mỗi loài sẽ có một tính cách riêng.**

Ví dụ:

**🌹 Rose**

```text
Thích nhiều nắng.

Nếu đủ nắng.

+10 Quality.
```

**🪻 Lavender**

```text
Ghét tưới quá nhiều.

Nếu tưới dư.

-20 Quality.
```

**🌻 Sunflower**

```text
Nếu trồng cạnh hoa thấp hơn.

+5 Quality.
```

**🌼 Lily**

```text
Nếu thu hoạch vào buổi sáng.

+10 Quality.
```

**Điều này tạo ra một cảm giác rất giống việc nghiên cứu thực vật.**

Người chơi sẽ dần khám phá:

"À, Lavender không thích nhiều nước."

"Hoa Lily nên thu hoạch vào sáng sớm."

**Đó không chỉ là gameplay mà còn khiến Bloom Journal thực sự trở thành một cuốn sổ nghiên cứu. Người chơi sẽ ghi nhớ đặc điểm của từng loài thay vì chỉ nhìn vào con số. Theo mình, đây là một hướng rất đáng để bổ sung sau Prototype vì nó vừa tăng chiều sâu, vừa rất phù hợp với chủ đề Botany của game.**
