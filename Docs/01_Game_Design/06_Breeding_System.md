# 📄 06_Breeding_System.md

**Đây là tài liệu mình mong chờ nhất, vì Breeding chính là "linh hồn" của Plant Tales.**

# 🎯 Mục tiêu

Trả lời câu hỏi:

**Người chơi sẽ tạo ra loài hoa mới như thế nào?**

Không chỉ là "Rose + Tulip = Peony".

**Mà phải định nghĩa toàn bộ luật lai tạo.**

# 🌸 Breeding System v1.0

## 1. Core Concept

Người chơi có thể kết hợp hai bông hoa trưởng thành để tạo cơ hội sinh ra một giống hoa mới.

Không phải mọi lần lai đều thành công.

**Lai tạo là một quá trình thử nghiệm và khám phá, không phải công thức chắc chắn 100%.**

# 2. Điều kiện để lai

| Điều kiện | Bắt buộc |
| --- | --- |
| Hai bông hoa đã thu hoạch | ✅ |
| Cả hai có thể lai (Can Breed = Yes) | ✅ |
| Đủ số lượng yêu cầu | ✅ |
| Đã mở khóa khu lai tạo | Prototype: Có sẵn |

# 3. Quy trình lai

```text
Chọn Flower A
        │
        ▼
Chọn Flower B
        │
        ▼
Kiểm tra điều kiện
        │
        ▼
Bắt đầu lai tạo
        │
        ▼
Tính tỉ lệ thành công
        │
        ▼
Nhận hạt giống mới hoặc thất bại
```

# 4. Kết quả có thể xảy ra

| Kết quả | Ý nghĩa |
| --- | --- |
| Thành công | Nhận hạt giống hoa mới |
| Không thành công | Nhận lại hạt giống thường hoặc vật liệu |
| Thành công đặc biệt | Có cơ hội nhận giống hiếm hơn (sau này) |

**Prototype chỉ cần 2 kết quả đầu.**

# 5. Tỉ lệ lai cơ bản

| Độ hiếm mục tiêu | Tỉ lệ gợi ý |
| --- | --- |
| Uncommon | 60% |
| Rare | 30% |
| Epic | 12% |
| Legendary | 3% |
| Mythic | Chưa áp dụng |

Đây là giá trị để test, sẽ cân bằng sau.

# 6. Chất lượng ảnh hưởng đến lai

**Quality của hoa cha mẹ có tác động, nhưng không thay đổi hoàn toàn kết quả.**

Ví dụ:

| Parent A | Parent B | Bonus |
| --- | --- | --- |
| ★★★★★ | ★★★★★ | +10% tỉ lệ |
| ★★★★☆ | ★★★☆☆ | +5% |
| ★★☆☆☆ | ★☆☆☆☆ | Không cộng |

Điều này khuyến khích người chơi chăm sóc hoa thật tốt.

# 7. Rarity ảnh hưởng đến lai

| Cha mẹ | Ví dụ |
| --- | --- |
| Common + Common | Chủ yếu tạo Uncommon |
| Common + Rare | Có thể tạo Rare |
| Rare + Rare | Có thể tạo Epic |
| Epic + Legendary | Điều kiện đặc biệt |

# 8. Hybrid Discovery

Lần đầu lai thành công một giống mới:

- Mở khóa trong Bloom Journal.
- Hiện animation "New Flower Discovered!".
- Thêm thông tin vào Flower Database.
- Có thể mở nhiệm vụ mới.

# 9. Prototype Rules

Prototype chỉ cần:

- Chọn 2 loài hoa.
- Nhấn "Breed".
- Chờ kết quả.
- Nhận hạt giống mới nếu thành công.

Chưa cần:

- Phòng thí nghiệm.
- NPC hỗ trợ.
- Mini game.
- Phân tích DNA.

# 10. Gameplay Loop

```text
Trồng hoa
      │
      ▼
Thu hoạch
      │
      ▼
Chọn 2 bông hoa
      │
      ▼
Lai tạo
      │
      ▼
Nhận hạt giống mới
      │
      ▼
Trồng tiếp
```

# 📌 Prototype Breeding Chain (Ví dụ)

```text
Rose
    +
Tulip
    ↓
Peony

Peony
    +
Lavender
    ↓
Hydrangea

Hydrangea
    +
Lily
    ↓
Blue Rose
```

Đây chỉ là ví dụ để test gameplay.

# 🚫 Quy tắc quan trọng

- Không phải cặp hoa nào cũng lai được.
- Không phải lần nào cũng thành công.
- Không nên có "công thức bí mật" quá khó đoán trong Prototype.

# 💡 Future Feature 1 – Hidden Hybrid Chance

Sau Prototype, có thể thêm:

**Một số tổ hợp có tỉ lệ cực thấp (ví dụ 0.5%) tạo ra một giống hoa đặc biệt mà người chơi không hề biết trước.**

Ví dụ:

```text
White Rose
+
Blue Lily

↓

???

↓

Moon Lily
```

Không có công thức hiện sẵn.

Người chơi tự khám phá.

# 💡 Future Feature 2 – Botanical Gene System

Đây là ý tưởng mình rất thích và muốn giữ cho Full Game.

Thay vì viết hàng trăm công thức cố định:

```text
Rose + Tulip = Peony
```

Mỗi hoa sẽ có các thuộc tính như:

| Gene | Ví dụ |
| --- | --- |
| Color | Red |
| Petal Shape | Round |
| Fragrance | Sweet |
| Bloom Type | Single |

Khi lai, game sẽ kết hợp các thuộc tính này để quyết định kết quả.

Ưu điểm:

- Dễ mở rộng lên hàng trăm loài hoa.
- Không phải viết hàng nghìn công thức thủ công.
- Người chơi có cảm giác đang "nghiên cứu" thay vì chỉ học thuộc đáp án.

# 💡 Future Feature 3 – Research Hints

Thay vì biết ngay công thức lai.

Bloom Journal sẽ dần ghi chú:

"Grandfather once noted that flowers with similar fragrances often produce unexpected hybrids."

Hay:

"Lavender seems to pair well with cool-colored flowers."

**Đây không phải đáp án, mà chỉ là gợi ý.**

Người chơi vẫn phải tự thử nghiệm.

**Theo mình, điều này rất hợp với chủ đề Botany và giúp việc lai hoa giống một hành trình nghiên cứu hơn là tra wiki.**
