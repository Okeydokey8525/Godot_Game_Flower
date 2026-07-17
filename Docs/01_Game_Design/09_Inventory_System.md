**Tuyệt. 😄 Bây giờ mình sẽ bắt đầu suy nghĩ như Lead Game Designer, chứ không chỉ là viết tài liệu.**

Sau khi nhìn lại toàn bộ 8 tài liệu, mình nhận ra:

**Inventory không phải là một cái túi.**

**Nó là trung tâm của toàn bộ gameplay.**

Mọi hệ thống đều đi qua Inventory.

```text
Shop
 │
 ▼
Seed
 │
 ▼
Inventory
 │
 ├─────────────┐
 │             │
 ▼             ▼
Plant       Give NPC
 │
 ▼
Flower
 │
 ├─────────────┐
 │             │
 ▼             ▼
Sell        Breed
 │             │
 ▼             ▼
Coin      New Seed
              │
              ▼
          Inventory
```

Cho nên tài liệu này cực kỳ quan trọng.

# 📄 09_Inventory_System.md

# 🎯 Mục tiêu

Trả lời câu hỏi:

**Người chơi sẽ quản lý tất cả vật phẩm trong game như thế nào?**

# 📦 Inventory System v1.0

# 1. Core Concept

Inventory là nơi lưu toàn bộ:

- Seeds
- Flowers
- Quest Items
- Keepsakes
- Tools

**Prototype không cần nhiều loại vật phẩm.**

# 2. Inventory Categories

| Category | Prototype | Full Game |
| --- | --- | --- |
| Seeds | ✅ | ✅ |
| Flowers | ✅ | ✅ |
| Quest Items | ❌ | ✅ |
| Family Keepsakes | ❌ | ✅ |
| Decorations | ❌ | ✅ |
| Craft Materials | ❌ | ✅ |
| Festival Items | ❌ | ✅ |

# 3. Inventory Layout

Prototype.

Đơn giản.

```text
┌────────────────────────────┐
│ 🌱 🌹 🌷 🌼 🌻 🌿          │
│ 🌱 🌹 🌷                  │
│                            │
│                            │
└────────────────────────────┘
```

Không cần nhiều tab.

# 4. Item Definition

Mọi Item trong Inventory đều có chung cấu trúc.

| Field | Description |
| --- | --- |
| Item ID | Mã vật phẩm |
| Item Name | Tên |
| Category | Loại |
| Icon | Hình ảnh |
| Stack Size | Số lượng tối đa |
| Quantity | Đang có |
| Tradable | Có bán được không |
| Description | Mô tả |

Điều này giúp Codex dùng chung một cấu trúc dữ liệu.

# 5. Stack Rules

| Item | Max Stack |
| --- | --- |
| Seeds | 99 |
| Flowers | 99 |
| Quest Item | 1 |
| Keepsake | 1 |

Prototype chỉ cần 99.

# 6. Item Actions

Khi chọn một vật phẩm.

Có thể.

| Action | Seed | Flower |
| --- | --- | --- |
| Plant | ✅ | ❌ |
| Sell | ✅ (nếu cho phép) | ✅ |
| Breed | ❌ | ✅ |
| View Info | ✅ | ✅ |
| Discard | ✅ | ✅ |

# 7. Item Information Panel

Ví dụ.

```text
Rose

★★★★★

Common

Sell Price

72

Language of Flowers

Love

Description

A timeless garden flower.
```

Prototype.

Chưa cần 3D.

Chỉ là Panel.

# 8. Sorting

Prototype.

Cho phép.

- Sort by Name
- Sort by Rarity
- Sort by Quantity

Không cần Filter nâng cao.

# 9. Inventory Capacity

Prototype.

**👉 Unlimited.**

Không giới hạn.

Lý do.

Game cozy.

Không muốn người chơi.

```text
Inventory Full
```

😂

Sau này.

Full Game.

Có thể thêm.

Storage Box.

# 10. Hotbar

Prototype.

Không cần.

Người chơi.

Mở Inventory.

```text
↓
```

Chọn Seed.

```text
↓
```

Plant.

Đủ.

# 11. Inventory Flow

```text
Buy Seed
      │
      ▼
Inventory
      │
      ▼
Plant
      │
      ▼
Flower
      │
      ▼
Harvest
      │
      ▼
Inventory
      │
      ├────────────┐
      ▼            ▼
Sell         Breed
                   │
                   ▼
             New Seed
                   │
                   ▼
              Inventory
```

# 12. Prototype Rules

Prototype chỉ cần.

✅ Add Item

✅ Remove Item

✅ Stack

✅ View Info

Không cần.

❌ Weight

❌ Durability

❌ Quick Slot

❌ Equipment

❌ Crafting

# 📌 Item Categories

```text
Inventory

│

├── Seeds

├── Flowers

├── Quest Items

├── Keepsakes

├── Decorations

└── Materials
```

Prototype.

Chỉ dùng.

```text
Seeds

Flowers
```

# 💡 Future Feature 1 – Bloom Journal Integration

Đây là ý tưởng mình rất thích.

Khi bấm chuột phải.

```text
Rose
```

Hiện.

```text
Plant

Sell

View Bloom Journal
↓
```

Mở đúng trang.

Rose.

Trong Journal.

Không phải tìm thủ công.

# 💡 Future Feature 2 – Favorite Items

Có thể.

⭐

Đánh dấu.

```text
Favorite
↓
```

Không bị bán nhầm.

Rất hữu ích.

Đặc biệt.

Legendary.

# 💡 Future Feature 3 – Keepsake Slot

Đây là ý tưởng mới mình vừa nghĩ.

**Family Keepsake không nên nằm trong Inventory thường.**

Mà có một ô riêng.

Ví dụ.

```text
Character

Hairpin

✓

Bookmark

✓
```

Điều này giúp:

- Không thể bán.
- Không thể vứt.
- Luôn gắn với nhân vật.
- NPC có thể nhận ra ngay khi tương tác.

Rất hợp với cốt truyện.

# 💡 Future Feature 4 – Herbarium Collection

Đây là ý tưởng mình thích nhất trong Inventory.

Thay vì Inventory chỉ có.

```text
Rose ×10
```

Người chơi có thể.

Bấm.

```text
Pin

to

Bloom Journal
↓
```

Rose.

Được lưu.

Trong Herbarium.

```text
↓
```

Inventory.

Giảm.

```text
↓
```

Journal.

Đầy dần.

Rất giống.

Nhà thực vật học.

# 🎯 Golden Rule

Mình muốn thêm một quy tắc thiết kế rất quan trọng:

**Inventory chỉ là nơi lưu trữ, không phải nơi tạo tiến trình.**

Tiến trình của người chơi phải đến từ:

- 🌸 Bloom Journal (bộ sưu tập và nghiên cứu).
- 📖 Pressed Memories (cốt truyện).
- 🌱 Flower Discovery (khám phá giống mới).
- 🤝 NPC (quan hệ và nhiệm vụ).

Inventory chỉ giúp quản lý vật phẩm. Điều này sẽ giúp giao diện luôn gọn gàng và người chơi không bị biến "chiếc túi đồ" thành trung tâm của trải nghiệm.
