# 🌿 Plant Tales — Game Overview & Architecture

**Plant Tales** là tựa game mô phỏng trồng hoa ấm cúng (*Cozy Botanical Simulation*) kết hợp chiều sâu về lai tạo giống (*Deep Genetics & Breeding*), nhật ký nghiên cứu thực vật (*Bloom Journal*), cùng thế giới NPC và cốt truyện giàu cảm xúc (*Village & Story*).

---

## 🎯 1. Core Pillars (Trụ cột thiết kế chính)

1. **Botanical Mastery (Học thuật và Chăm sóc thực vật):**
   - Người chơi hóa thân thành một nhà nghiên cứu thực vật (Botany), không chỉ đơn thuần gieo hạt và tưới nước, mà còn theo dõi các yếu tố sinh thái sâu hơn như ánh sáng, độ ẩm, loại đất và thời tiết ([01_Flower_Definition.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/01_Flower_Definition.md), [05_Growth_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/05_Growth_System.md)).

2. **Breeding & Discovery (Lai tạo & Khám phá):**
   - Hệ thống lai tạo (*Breeding*) là linh hồn của game ([06_Breeding_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/06_Breeding_System.md)). Người chơi thử nghiệm các cặp giống để tạo ra các đột biến, màu sắc mới, và mở khóa độ hiếm từ **Common** đến **Mythic** ([03_Rarity_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/03_Rarity_System.md)).

3. **Bloom Journal (Nhật ký Nở hoa):**
   - Không chỉ là một Pokédex đơn thuần, **Bloom Journal** ([11_Bloom_Journal.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/11_Bloom_Journal.md)) là cuốn sổ tay học giả nơi lưu giữ các phác thảo, ghi chú nghiên cứu, và các ký ức ép hoa (*Pressed Memories*) gắn kết với NPC và cốt truyện.

4. **Living World & Narrative (Thị trấn sống động & Cốt truyện):**
   - Mọi hoạt động trong vườn đều có ảnh hưởng mạnh mẽ đến thị trấn ([13_Village_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/13_Village_System.md)) và các mối quan hệ với NPC ([12_NPC_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/12_NPC_System.md)), hướng tới mục tiêu lớn nhất: khôi phục **Lễ hội Hoa** truyền thống ([15_Festival_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/15_Festival_System.md), [14_Story_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/14_Story_System.md)).

---

## 🔄 2. Core Gameplay Loop (Vòng lặp trải nghiệm cốt lõi)

```text
       [ Mua Hạt Giống & Chuẩn Bị Đất ]
                     ↓
        [ Trồng & Chăm Sóc Hàng Ngày ]
  (Tưới nước, ánh sáng, nhiệt độ, phân bón)
                     ↓
             [ Thu Hoạch / Lai Tạo ]
  (Đạt Perfect Bloom, lai ra giống mới/độ hiếm cao)
                     ↓
     ┌───────────────┴───────────────┐
     ▼                               ▼
[ Kinh Tế & Nâng Cấp ]     [ Nghiên Cứu & Cốt Truyện ]
 (Bán hoa, mua công cụ,     (Ghi vào Bloom Journal,
   mở rộng vườn)             tặng hoa NPC, mở sự kiện)
     └───────────────┬───────────────┘
                     ↓
           [ Khôi Phục Lễ Hội Hoa ]
```

---

## 📦 3. Kiến Trúc Dữ Liệu & Sự Phân Tách Hệ Thống

- **Rarity vs Quality:** Hai khái niệm độc lập. **Rarity** ([03_Rarity_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/03_Rarity_System.md)) thể hiện độ hiếm tự nhiên của loài hoa, trong khi **Quality** ([04_Quality_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/04_Quality_System.md)) phản ánh mức độ chăm sóc hoàn hảo của người chơi (★1 đến ★5).
- **Inventory Center:** Túi đồ ([09_Inventory_System.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/09_Inventory_System.md)) đóng vai trò trung tâm luân chuyển tài nguyên giữa Shop, Vườn, và NPC.
- **Prototype Scope:** Giới hạn khả thi cho phiên bản thử nghiệm đầu tiên được xác định rõ ràng tại [02_Prototype_Scope.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/02_Prototype_Scope.md) và danh sách giống mẫu tại [10_Prototype_Flower_Database.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/01_Game_Design/10_Prototype_Flower_Database.md).
