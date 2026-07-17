# 🌸 Flower Blueprint v1.0

**Mục đích: Định nghĩa tất cả thông tin mà một loài hoa trong game cần có.**

# 1. General Information

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Flower ID | String | Mã định danh duy nhất | F001 |
| Flower Name | String | Tên loài hoa | Rose |
| Scientific Name | String | Tên khoa học | Rosa spp. |
| Description | Text | Mô tả ngắn về loài hoa | A classic garden flower. |
| Language of Flowers | String | Ý nghĩa biểu tượng của hoa | Love |

# 2. Gameplay

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Rarity | Enum | Độ hiếm của hoa | Common |
| Quality | ★1–★5 | Chất lượng hiện tại | ★★★★☆ |
| Season | Enum | Mùa phát triển | Spring |
| Growth Time | Integer | Số ngày để nở | 5 |
| Regrow | Boolean | Thu hoạch xong có mọc lại không | No |

# 3. Growing

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Water Need | Enum | Lượng nước cần | Medium |
| Sunlight | Enum | Nhu cầu ánh sáng | High |
| Preferred Soil | Enum | Loại đất phù hợp | Normal Soil |
| Temperature | Enum | Nhiệt độ thích hợp | Warm |
| Humidity | Enum | Độ ẩm yêu thích | Medium |

# 4. Economy

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Buy Price | Integer | Giá mua hạt giống | 30 |
| Sell Price | Integer | Giá bán hoa | 80 |
| Festival Score | Integer | Điểm dùng trong lễ hội | 10 |
| Research Point | Integer | Điểm nghiên cứu nhận được | 3 |

# 5. Bloom Journal

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Journal ID | String | Mã trong Bloom Journal | J001 |
| Sketch | Boolean | Có hình phác họa hay không | Yes |
| Research Note | Text | Ghi chú nghiên cứu | Prefers cool mornings. |
| Pressed Memory | String | Ký ức liên quan (nếu có) | PM007 |
| Player Note | Text | Ghi chú người chơi | Empty |

# 6. Breeding

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Can Breed | Boolean | Có thể lai không | Yes |
| Parent A | String | Hoa cha/mẹ thứ nhất | Rose |
| Parent B | String | Hoa cha/mẹ thứ hai | Tulip |
| Hybrid Chance | Percentage | Tỷ lệ thành công | 15% |

# 7. Art Assets

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Concept Art | File | Concept của hoa | Rose_Concept.png |
| Pixel Sprite | File | Sprite trong game | Rose_Sprite.png |
| Inventory Icon | File | Icon trong túi đồ | Rose_Icon.png |
| Journal Icon | File | Icon trong Bloom Journal | Rose_Journal.png |

# 🌿 8. Botanical Identity (Đề xuất bổ sung)

**Đây là phần mình nghĩ sẽ làm game của chúng ta khác biệt, vì nhân vật chính học Botany.**

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Native Region | String | Nguồn gốc của hoa | Europe |
| Flower Fragrance | Enum | Mùi hương | Sweet |
| Flower Color | String | Màu chủ đạo | Red |
| Difficulty | Enum | Độ khó chăm sóc | Easy |
| Preferred Weather | Enum | Thời tiết yêu thích | Sunny |
| Companion Flower | String | Hoa trồng cùng sẽ có lợi | Lavender |

# 🌼 9. Growth Stages (Đề xuất bổ sung)

Để sau này làm animation và gameplay.

| Stage | Description |
| --- | --- |
| Seed | Hạt giống |
| Sprout | Nảy mầm |
| Young Plant | Cây non |
| Bud | Nụ hoa |
| Bloom | Hoa nở |
| Perfect Bloom | Hoa nở hoàn hảo |
| Wilt | Hoa héo |

# 🏆 10. Quest & Story (Đề xuất bổ sung)

Giúp liên kết hoa với nhiệm vụ và cốt truyện.

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| Required for Quest | Boolean | Có dùng trong nhiệm vụ không | Yes |
| NPC Favorite | String | NPC yêu thích loài hoa này | Lily |
| Unlock Condition | Text | Điều kiện mở khóa | Complete Chapter 2 |
| Pressed Memory Reward | String | Mở khóa Pressed Memory nào | PM012 |

# 📌 Flower Blueprint Structure

```text
Flower
│
├── General Information
├── Gameplay
├── Growing
├── Economy
├── Bloom Journal
├── Breeding
├── Botanical Identity
├── Growth Stages
├── Quest & Story
└── Art Assets
```
