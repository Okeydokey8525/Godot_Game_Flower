# 📄 03_Rarity_System.md

Đây là tài liệu chúng ta nên làm ngay.

# Mục tiêu

Trả lời câu hỏi:

**Trong game có bao nhiêu cấp độ hiếm? Chúng khác nhau ở điểm nào?**

# 🌼 Rarity System v1.0

## 1. Tổng quan

| Rarity | Màu gợi ý | Ý nghĩa |
| --- | --- | --- |
| Common | Trắng / Xanh lá | Hoa phổ biến, dễ kiếm |
| Uncommon | Xanh dương | Cần chăm sóc hoặc lai đơn giản |
| Rare | Tím | Khó lai hơn |
| Epic | Cam | Chỉ người chơi có kinh nghiệm mới tạo được |
| Legendary | Vàng | Gắn với truyền thuyết và cốt truyện |
| Mythic | Cầu vồng / Hồng nhạt | Hiếm nhất, điều kiện đặc biệt |

# 2. Cách mở khóa

| Rarity | Có bán ở Shop | Có thể lai | Điều kiện mở khóa |
| --- | --- | --- | --- |
| Common | ✅ | Có | Có từ đầu |
| Uncommon | ✅ (sau tiến trình) | Có | Hoàn thành vài nhiệm vụ |
| Rare | ❌ | ✅ | Lai thành công |
| Epic | ❌ | ✅ | Lai nhiều thế hệ |
| Legendary | ❌ | ✅ | Hoàn thành nhiệm vụ chính / Pressed Memories |
| Mythic | ❌ | ✅ | Điều kiện rất đặc biệt |

# 3. Mục đích của từng cấp

| Rarity | Vai trò |
| --- | --- |
| Common | Học cơ chế game |
| Uncommon | Bắt đầu khám phá lai tạo |
| Rare | Kiếm tiền và sưu tầm |
| Epic | Mục tiêu trung hạn |
| Legendary | Gắn với cốt truyện |
| Mythic | Mục tiêu cuối game |

# 4. Độ khó lai (gợi ý)

| Rarity | Tỉ lệ cơ bản |
| --- | --- |
| Common | Không cần lai |
| Uncommon | 50–70% |
| Rare | 20–40% |
| Epic | 8–15% |
| Legendary | 1–5% |
| Mythic | <1% hoặc điều kiện đặc biệt |

**Đây chỉ là khung thiết kế, sau này sẽ cân bằng khi test game.**

# 5. Quan hệ với các hệ thống khác

| Hệ thống | Ảnh hưởng |
| --- | --- |
| Giá bán | Hoa hiếm bán được giá hơn |
| Bloom Journal | Trang hiếm có hiệu ứng đặc biệt |
| Pressed Memories | Một số ký ức chỉ mở khi có hoa Legendary |
| Festival | Hoa hiếm được cộng nhiều điểm |
| NPC | Một số NPC chỉ yêu cầu hoa Rare trở lên |

# 6. Quy tắc quan trọng

- Độ hiếm (Rarity) ≠ Chất lượng (Quality).

Ví dụ:

- 🌹 Rose (Common ★★★★★)
- 🌹 Blue Rose (Rare ★★☆☆☆)

Hoa Rare không nhất thiết giá trị hơn nếu chất lượng kém.

Điều này tạo chiều sâu cho gameplay.

# 📌 Ghi chú thiết kế

Một nguyên tắc mình muốn giữ từ đầu đến cuối dự án:

**Rarity nói lên "loài hoa hiếm đến mức nào".**

**Quality nói lên "người chơi chăm sóc bông hoa đó tốt đến đâu".**

**Hai khái niệm này không bao giờ được trộn lẫn.**

## Mình còn một đề xuất nữa

**Thay vì chỉ có 6 cấp độ hiếm, mình nghĩ chúng ta nên gắn mỗi cấp với triết lý phát triển của người chơi, chứ không chỉ là màu sắc.**

Ví dụ:

- Common → Learning (Học cách trồng)
- Uncommon → Experimenting (Bắt đầu thử nghiệm)
- Rare → Discovery (Khám phá giống mới)
- Epic → Mastery (Làm chủ kỹ thuật lai tạo)
- Legendary → Legacy (Khôi phục di sản Lễ hội Hoa)
- Mythic → Miracle (Tạo nên điều kỳ diệu)

Đây không ảnh hưởng đến code, nhưng sẽ giúp tất cả mô tả trong Journal, thành tựu và cốt truyện có cùng một ngôn ngữ thiết kế. Người chơi sẽ cảm thấy mình đang trưởng thành cùng nhân vật, thay vì chỉ "mở khóa màu hiếm hơn". Theo mình, đây là một chi tiết nhỏ nhưng tạo chiều sâu rất tốt cho trải nghiệm lâu dài.
