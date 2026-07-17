# Flower Assets

**Tài liệu quy chuẩn kỹ thuật và nhận diện thể hiện chuyên biệt dành cho tài nguyên hoa của dự án Plant Tales (Flower Asset & Identity Standard Document).**

---

## 1. Purpose

Tài liệu **Flower Assets (`02_Flowers.md`)** đóng vai trò là hiến pháp tối cao kết hợp cả hai khía cạnh: **Flower Asset Standard (Quy chuẩn Kỹ thuật Tài nguyên)** và **Flower Identity Standard (Quy chuẩn Nhận diện Thể hiện)** cho toàn bộ hệ thống thực vật trong **Plant Tales**.

Trong **Plant Tales**, các loài hoa không đơn thuần là vật phẩm thu hoạch nông nghiệp mà chính là **"nhân vật chính thứ hai"** (*Second Protagonists*) của trò chơi — trung tâm của các hoạt động nghiên cứu thực vật học (*Botanical Research*), sổ tay học giả (*Bloom Journal*), lai tạo di truyền (*Breeding*) và khám phá ký ức (*Pressed Memories*).

Mục đích thiết yếu của bộ quy chuẩn này:
- **Chuẩn hóa chu trình sống trọn vẹn (Full Life Cycle Identity):** Mỗi loài hoa bắt buộc phải được thể hiện qua một hệ sinh thái tài nguyên đồng bộ từ hạt giống, mầm lá, nụ, hoa nở đến khi héo, cũng như các phiên bản minh họa học thuật trong nhật ký.
- **Đảm bảo tính chính xác thực vật học hài hòa với độ dễ thương (Botanical Accuracy vs Cozy Cozy):** Đặt ra tiêu chuẩn cân bằng giữa sự chính xác về hình thái sinh học (*Morphological structure*) và đường nét mềm mại thư thái của game ấm cúng.
- **Tiêu chuẩn hóa quy cách mở rộng hàng trăm loài hoa:** Tạo khung làm việc kiên cố giúp đội ngũ sản xuất và lập trình dễ dàng mở rộng từ vài giống hoa Prototype lên hàng trăm loài hoa, hoa đột biến và hoa lai mà không gây lộn xộn hay vỡ kiến trúc tài nguyên.

---

## 2. Flower Categories

Hệ thống hoa trong **Plant Tales** được phân cấp theo 6 độ hiếm chuẩn từ GDD (`Docs/01_Game_Design/03_Rarity_System.md`). Cấp độ hiếm quyết định trực tiếp đến ngôn ngữ tạo hình, độ phức tạp của silhouette và sự hiện diện thị giác của loài hoa đó trong khu vườn:

- **Common (Phổ biến):**
  - Silhouette đơn giản, gần gũi (4–6 cánh hoa rõ ràng), hình dáng thon gọn dễ nhận diện ngay ở kích thước nhỏ. Bảng màu tự nhiên, tươi tắn mộc mạc.
- **Uncommon (Không phổ biến):**
  - Silhouette bắt đầu có điểm nhấn hình thái (cánh hoa kép nhẹ, viền màu kép bên ngoài cánh hoặc tán lá có răng cưa đặc trưng).
- **Rare (Hiếm):**
  - Hình khối phức tạp hơn với độ sâu lớp cánh (*Layered petals*), màu sắc rực rỡ nhưng dịu mắt hoặc sở hữu tông màu lạ mắt tự nhiên (xanh lam trầm, tím ngọc thạch).
- **Epic (Sử thi):**
  - Cấu trúc độc đáo, mang vẻ đẹp quý phái hoặc quý hiếm trong tự nhiên (như lan rừng quý, hoa tuyết tùng). Silhouette có đường cong thanh lịch, cánh hoa phản chiếu ánh sáng dịu.
- **Legendary (Huyền thoại):**
  - Tạo hình kiêu sa, mang đặc tính thực vật cổ đại hoặc hoa thiêng thị trấn. Thân cây vững chãi, đường nét tinh xảo tuyệt đối, bảng màu pha trộn ánh kim hoặc gradient dịu nhẹ.
- **Mythic (Thần thoại):**
  - Đỉnh cao của nghệ thuật thực vật trong game. Vẻ đẹp siêu việt mang hơi hướng huyền bí, sở hữu các chi tiết hình thái độc bản (cánh hoa trong suốt như pha lê mờ, gân lá phát sáng vi mô *bioluminescence* dịu dàng).

---

## 3. Flower Visual Style

Ngôn ngữ nghệ thuật của hoa phải thể hiện sự trân trọng sâu sắc với thực vật học, tuân thủ các quy tắc tạo hình nghiêm ngặt sau:

- **Botanical Accuracy First (Ưu tiên tính chính xác thực vật học):** Cấu trúc cành, cách mọc lá (mọc đối hay mọc so le), số lượng đài hoa và nhị/nhụy hoa được phác họa dựa trên nguyên mẫu thực vật có thật (hoặc cơ sở sinh học hợp lý nếu là hoa lai tưởng tượng).
- **Cozy & Elegant (Ấm cúng & Thanh nhã):** Đường nét viền mềm mại, không dùng nét xước thô ráp. Bố cục hoa toát lên sự tĩnh lặng và sang trọng của thiên nhiên.
- **Natural Proportions (Tỷ lệ tự nhiên hài hòa):** Chiều cao thân cây cân đối với bông hoa và chậu trồng. Hoa lớn không làm đổ gãy thân lùn, lá rậm không che lấp hoàn toàn đài hoa.
- **Soft Colors & Curated Palettes (Bảng màu mềm mại & được tinh chọn):** Sử dụng các tông màu pastel dịu, màu khoáng tự nhiên, màu cánh hoa phản chiếu dưới nắng chiều. Tuyệt đối tránh màu neon bão hòa quá mức.
- **Clear Silhouette & Easy Recognition (Đường viền hình bóng rõ ràng & Dễ nhận diện):** Ngay cả khi thu nhỏ về khung lưới pixel `32x32` px trên luống đất, người chơi chỉ cần nhìn qua hình dáng (*Silhouette*) và màu chủ đạo là lập tức phân biệt được Rose, Tulip hay Lavender.

---

## 4. Flower Life Cycle Assets

Để phục vụ gameplay chăm sóc thực vật học thực thụ, **Mỗi loài hoa bắt buộc phải sở hữu trọn vẹn bộ 7 tài nguyên giai đoạn sinh trưởng (`Life Cycle Sprite Set`)** trên lưới đất:

```text
Seed ➔ Sprout ➔ Young Plant ➔Bud ➔ Bloom ➔ Perfect Bloom ➔ Wilt
```

1. **Seed (Hạt giống đã gieo dưới đất):**
   - *Mục đích:* Xác nhận người chơi đã gieo hạt xuống ô đất.
   - *Thể hiện:* Lấp ló đỉnh hạt giống trên mặt đất ẩm hoặc nhô nhẹ mầm rễ cực nhỏ màu trắng kem.
2. **Sprout (Nảy mầm / Cây mầm lá mầm):**
   - *Mục đích:* Báo hiệu hạt đã nảy mầm thành công sau những ngày đầu tưới nước.
   - *Thể hiện:* Cặp lá mầm tròn trịa vươn lên khỏi mặt đất (*Cotyledons*), màu xanh non tươi sáng.
3. **Young Plant (Cây non sinh trưởng):**
   - *Mục đích:* Giai đoạn cây tích lũy dinh dưỡng, thể hiện đặc tính hình thái lá thực sự của loài hoa.
   - *Thể hiện:* Cây vươn cao, xuất hiện `4–6` lá thật mang đặc trưng loài (ví dụ: lá hồng có răng cưa nhẹ, lá tulip dài bản rộng).
4. **Bud (Nụ hoa đóng kín):**
   - *Mục đích:* Tạo sự hồi hộp, chờ đợi trước ngày thu hoạch.
   - *Thể hiện:* Nụ hoa hé lộ màu sắc chủ đạo ở đỉnh đài hoa màu xanh bọc kín, thân cây đạt chiều cao tối đa.
5. **Bloom (Hoa nở tiêu chuẩn):**
   - *Mục đích:* Trạng thái hoa đã nở, sẵn sàng thu hoạch ở mức chất lượng bình thường.
   - *Thể hiện:* Bông hoa nở rộ khoe sắc đẹp tự nhiên, cánh hoa mở hoàn toàn.
6. **Perfect Bloom (Hoa nở hoàn hảo ★★★★★):**
   - *Mục đích:* Trạng thái tối thượng khi người chơi chăm sóc hoàn hảo 100% các chỉ số (đất, nước, ánh sáng, nhiệt độ).
   - *Thể hiện:* Bông hoa nở với độ căng tràn rực rỡ nhất, màu sắc sâu thẳm hơn bản Bloom tiêu chuẩn, kèm hiệu ứng lấp lánh vi mô tinh tế (*Subtle Micro-sparkle*).
7. **Wilt (Hoa héo / Tàn):**
   - *Mục đích:* Phản ánh việc bỏ quên thu hoạch quá hạn hoặc thiếu nước nghiêm trọng.
   - *Thể hiện:* Cánh hoa rũ xuống, chuyển sang màu vàng nâu khô héo hoặc rụng bớt cánh, thân hơi nghiêng gập.

---

## 5. Flower Supporting Assets

Để luân chuyển hoa trong Inventory và lưu trữ vào sổ tay học giả Bloom Journal, mỗi loài hoa phải được gia cố bởi **5 tài nguyên bổ trợ bắt buộc (`Supporting Assets Set`)**:

- **Seed Bag (Túi hạt giống):**
  - *Vai trò:* Vật phẩm xuất hiện trong Shop bán hạt và Inventory của người chơi.
  - *Thể hiện:* Gói giấy da hoặc túi vải lanh nhỏ có in hình phác thảo bông hoa kèm dải màu đặc trưng bên ngoài.
- **Inventory Icon (Icon trong túi đồ & thanh công cụ):**
  - *Vai trò:* Hiển thị bông hoa thu hoạch được khi để trong ba lô, kho lưu trữ hoặc hộp quà tặng NPC.
  - *Thể hiện:* Icon pixel góc nhìn chính diện hoặc nghiêng nhẹ 3/4, bo viền gọn gàng, rõ nét trên cả nền sáng và nền tối.
- **Journal Illustration (Hình minh họa trong Bloom Journal):**
  - *Vai trò:* Hình ảnh màu trang trọng hiển thị trên trang sổ tay học giả khi người chơi mở khóa loài hoa.
  - *Thể hiện:* Hình minh họa chất lượng cao vẽ trên nền giấy da mộc (*Parchment*), màu sắc rực rỡ trang nhã.
- **Pressed Flower (Ký ức hoa ép / Mẫu tiêu bản khô):**
  - *Vai trò:* Mẫu hoa ép khô dùng trong hệ thống **Pressed Memories** hoặc tặng phẩm đặc biệt cho NPC.
  - *Thể hiện:* Hình ảnh bông hoa được ép dẹt 2D như nằm giữa những trang sách cổ, màu sắc trầm lại theo tông cổ điển (*Vintage muted tones*), thấy rõ các đường gân cánh hoa khô mờ.
- **Botanical Sketch (Phác thảo chì/mực nghiên cứu):**
  - *Vai trò:* Hình ảnh phác thảo hiển thị trong giai đoạn người chơi đang nghiên cứu dở dang hoặc ghi chú trong Journal.
  - *Thể hiện:* Nét vẽ chì than hoặc mực nâu sepia mộc mạc (*Sepia line sketch*), chú thích mũi tên chỉ vào đài hoa, rễ hoặc dạng lá.

---

## 6. Flower Technical Standards

Bảng quy cách kỹ thuật tiêu chuẩn bắt buộc cho toàn bộ hệ sinh thái tài nguyên của 1 loài hoa:

| Asset Name | Standard Dimensions | Resolution / Grid Configuration | Color & Alpha Format | Technical Specification & Notes |
| --- | --- | --- | --- | --- |
| **Pixel Sprite (Life Cycle)** | Sprite Sheet 7 giai đoạn | `32x32` px per stage | Indexed / RGBA (`.png`) | Pivot chạm đất trung tâm đáy `(X:16, Y:32)`, Bounding box `16x8` dưới gốc |
| **Inventory Icon** | Single Item Icon | `32x32` px | RGBA (`.png`) | Transparent background, viền pixel sạch, không chèn bóng đổ lan ra ngoài |
| **Seed Bag Icon** | Seed Packet Item | `32x32` px | RGBA (`.png`) | Khung túi vải chuẩn `24x28` px chính giữa, in icon hoa nhỏ bên ngoài |
| **Journal Illustration**| Journal Color Page | `512x512` px | RGBA / sRGB (`.png`) | Transparent background, nét mềm, màu lót phẳng kết hợp đổ bóng cel |
| **Botanical Sketch** | Journal Line Page | `512x512` px | RGBA / sRGB (`.png`) | Transparent background, nét mực chì nâu sepia `(#4A3B32)` |
| **Pressed Flower** | Pressed Memory Specimen | `512x512` px | RGBA / sRGB (`.png`) | Transparent background, mô phỏng kết cấu hoa ép khô dẹt mỏng |

---

## 7. Visual Progression Rules

Để đảm bảo trải nghiệm chơi mượt mà và tính trực quan tuyệt đối cho gameplay chăm sóc hoa, toàn bộ asset sinh trưởng phải tuân thủ **Quy tắc Tiến trình Thị giác (`Visual Progression Rules`)**:

1. **Quy tắc Nhận diện Ngay tức thì (Glance Recognition Rule):**
   - Người chơi khi đi dạo quanh vườn không cần bấm vào kiểm tra bảng thông tin vẫn phải nhận biết chính xác cây đang ở giai đoạn nào dựa trên hình dáng và kích thước lá.
2. **Quy tắc Tiến trình Lớn dần không Nhảy cóc (Continuous Silhouette Growth Rule):**
   - Cây sinh trưởng theo trình tự hình thái logic: **`Seed (0 lá) ➔ Sprout (2 lá mầm tròn) ➔ Young Plant (4–6 lá thật đặc trưng, vươn cao) ➔ Bud (Nụ khép đỉnh cây) ➔ Bloom (Hoa mở rộ)`**.
   - Tuyệt đối không được phép nhảy cóc hình thái (ví dụ: đang 2 lá mầm đột ngột mọc ra bông hoa khổng lồ mà không qua giai đoạn cây non và nụ).
3. **Quy tắc Khác biệt rõ ràng giữa Bloom và Perfect Bloom:**
   - Trạng thái **Perfect Bloom** không làm biến dạng hình khối cấu trúc của hoa, mà làm nổi bật độ hoàn hảo bằng độ bão hòa màu sâu hơn và ánh sáng lung linh nhẹ nhàng, giúp người chơi tự hào khi nhìn thấy thành quả chăm sóc của mình.

---

## 8. Visual Effects

Hiệu ứng hình ảnh (*Visual Effects / VFX*) gắn liền với hoa được kiểm soát nghiêm ngặt theo triết lý: **Tinh tế, Sang trọng và Ấm cúng (`Subtle, Elegant & Cozy`)**, tuyệt đối không biến khu vườn bình yên thành sân khấu fantasy loè loẹt rực rỡ:

- **Bloom (Hoa nở bình thường):**
  - *VFX:* **Không có hiệu ứng hạt phát sáng liên tục.** Chỉ có chuyển động rung rinh cực nhẹ khi có gió thổi qua (`Gentle wind sway`).
- **Perfect Bloom (Hoa nở hoàn hảo ★★★★★):**
  - *VFX:* Hiệu ứng **Hạt sáng nhỏ lấp lánh rất nhẹ (`Subtle Micro-sparkle`)**. Chu kỳ `3–4` giây xuất hiện `1–2` đốm sáng nhỏ li ti màu vàng kim hoặc trắng ngọc trai chớp tắt chậm rãi quanh đóa hoa.
- **Legendary (Độ hiếm Huyền thoại):**
  - *VFX:* Khi hoa nở, có một lớp hào quang đom đóm mờ dịu (`Soft firefly glow`) lơ lửng sát từng cánh hoa, tạo cảm giác quý hiếm và thiêng liêng.
- **Mythic (Độ hiếm Thần thoại):**
  - *VFX:* Hiệu ứng ánh sáng dịu nhẹ lan tỏa từ gân lá/cánh hoa kèm theo những vụn phấn hoa li ti tựa sương mù mờ (`Bioluminescent mist & petal aura`) bay lơ lửng rất chậm xung quanh thân cây.

---

## 9. Naming Convention

Mọi file tài nguyên thuộc hệ thống hoa phải tuân thủ quy định **snake_case** nghiêm ngặt:  
`flower_[species_id/name]_[stage/type].[ext]`

Danh sách ví dụ tiêu chuẩn cho loài Hoa Hồng (*Rose*):
- **Life Cycle Pixel Sprites (`32x32` px):**
  - `flower_rose_seed.png` *(Sprite hạt đã gieo)*
  - `flower_rose_sprout.png` *(Sprite 2 lá mầm)*
  - `flower_rose_young.png` *(Sprite cây non 4-6 lá)*
  - `flower_rose_bud.png` *(Sprite nụ hoa)*
  - `flower_rose_bloom.png` *(Sprite hoa nở bình thường)*
  - `flower_rose_bloom_perfect.png` *(Sprite hoa nở hoàn hảo)*
  - `flower_rose_wilt.png` *(Sprite hoa héo)*
- **Supporting Assets (`32x32` px & `512x512` px):**
  - `flower_rose_seedbag.png` *(Icon túi hạt giống hoa hồng)*
  - `flower_rose_icon.png` *(Icon hoa hồng trong túi đồ)*
  - `flower_rose_journal.png` *(Hình minh họa màu trong Bloom Journal)*
  - `flower_rose_sketch.png` *(Phác thảo mực chì sepia)*
  - `flower_rose_pressed.png` *(Tiêu bản mẫu hoa ép khô)*

---

## 10. Folder Convention

Mỗi loài hoa là một hệ sinh thái tài nguyên độc lập. Khi lưu trữ bên trong `Assets/Flowers/`, mỗi loài phải có riêng một thư mục mang tên giống hoa đó (`Rose/`, `Tulip/`, `Lavender/`) và chia thành 5 tiểu mục kỹ thuật:

```text
Assets/
└── Flowers/
    ├── Rose/
    │   ├── Concept/
    │   │   ├── flower_rose_concept_art.png
    │   │   └── flower_rose_botanical_study.png
    │   ├── Sprites/
    │   │   ├── flower_rose_seed.png
    │   │   ├── flower_rose_sprout.png
    │   │   ├── flower_rose_young.png
    │   │   ├── flower_rose_bud.png
    │   │   ├── flower_rose_bloom.png
    │   │   ├── flower_rose_bloom_perfect.png
    │   │   └── flower_rose_wilt.png
    │   ├── Icons/
    │   │   ├── flower_rose_icon.png
    │   │   └── flower_rose_seedbag.png
    │   ├── Journal/
    │   │   ├── flower_rose_journal.png
    │   │   └── flower_rose_sketch.png
    │   └── Pressed/
    │       └── flower_rose_pressed.png
    └── Tulip/
        ├── Concept/
        ├── Sprites/
        ├── Icons/
        ├── Journal/
        └── Pressed/
```

---

## 11. Production Pipeline

Quy trình sản xuất chuẩn hóa cho một loài hoa từ khâu nghiên cứu thực vật đến khi hiển thị lung linh trong game:

```text
┌─────────────────┐
│   1. Research   │  Nghiên cứu hình thái thực tế của loài hoa (Botany Study):
│                 │  kiểu lá, số cánh hoa, màu khoáng tự nhiên và đặc tính môi trường
└────────┬────────┘
         ↓
┌─────────────────┐
│   2. Concept    │  Vẽ phác thảo chì và màu (`2048x2048`), định nghĩa rõ 7 giai đoạn
│                 │  sinh trưởng cùng các mẫu minh họa Journal và hoa ép
└────────┬────────┘
         ↓
┌─────────────────┐
│    3. Review    │  Kiểm định theo tiêu chí: Botanical accuracy vs Cozy feeling,
│                 │  độ rõ nét của Silhouette khi thu nhỏ xuống 32x32 px
└────────┬────────┘
         ↓
┌─────────────────┐
│   4. Approved   │  Chốt thiết kế, cấp ID giống hoa chuẩn và chuyển sang bước
│                 │  sản xuất tài nguyên kỹ thuật số hóa
└────────┬────────┘
         ↓
    ┌────┴───────────────────────────┐
    ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│ 5a. Pixel Sprite│              │5b. Journal Spec │
│ Sheet 7 giai    │              │ Vẽ Illustration,│
│ đoạn chuẩn 32x32│              │ Sketch & Pressed│
└────────┬────────┘              └────────┬────────┘
         │                                │
         └───────────────┬────────────────┘
                         ▼
┌──────────────────────────────────────────────────┐
│             6. Animation (if needed)             │
│  Tạo Sprite Sheet gió thổi rung rinh (`Wind      │
│  sway`) hoặc hiệu ứng VFX vi mô Perfect Bloom    │
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    7. Import                     │
│  Tích hợp vào Engine, thiết lập Pivot chạm gốc   │
│  `(X:16, Y:32)`, gắn metadata vào Bloom Database │
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    8. In Game                    │
│  Kiểm chứng chu trình gieo trồng, tương tác tưới │
│  nước, thu hoạch và ghi nhận vào Bloom Journal   │
└──────────────────────────────────────────────────┘
```

---

## 12. Future Expansion & Special Supporting Assets

Tài liệu quy chuẩn **Flower Assets (`02_Flowers.md`)** được thiết kế kiến trúc mở để sẵn sàng đón nhận các dòng tài nguyên thực vật đặc biệt trong các bản mở rộng tương lai:

- **Seasonal Variants (Biến thể theo mùa):** Khung quy định tài nguyên cho các loài hoa đổi màu lá hoặc kích thước cánh theo 4 mùa (*Spring Blossom vs Autumn Crisp*).
- **Hybrid Flowers & Mutation Variants (Hoa lai & Biến thể đột biến di truyền):** Cấu trúc tài nguyên cho các tổ hợp màu kép, đốm vân lạ hoặc sự thay đổi hình thái lá khi lai tạo từ 2 loài cha mẹ (`Parent A + Parent B`).
- **Event-exclusive Flowers (Hoa sự kiện Lễ hội):** Các giống hoa hiếm chỉ mọc và thu hoạch trong các đêm Lễ hội Hoa truyền thống.
- **🌸 Bloom Plate (Tấm minh họa Bách khoa Thực vật cổ điển — Long-term Reward Asset):**
  - **Định nghĩa đặc biệt:** Một loại tài nguyên nghệ thuật đỉnh cao (*Prestige Collectible Asset*) mang phong cách các tấm hình minh họa thực vật cổ điển thời kỳ Victorian (*Antique Botanical Illustration Plate*).
  - **Cấu trúc thể hiện:** Khung hình trang trọng (`1024x1036` px hoặc `2048x2048` px) trên nền giấy da thuộc sẫm màu, thể hiện đồng thời toàn bộ giải phẫu thực vật của loài hoa: bộ rễ chi tiết, lát cắt mặt ngang bông hoa, hình thái nhị/nhụy, tán lá, nụ hoa kèm chú thích tên khoa học chuẩn xác viết bằng thư pháp trang nhã.
  - **Vai trò trong hệ sinh thái game:** Được mở khóa như một **Phần thưởng Thành tựu Tối thượng (*Ultimate Collection Reward*)** khi người chơi hoàn thành 100% nghiên cứu Bloom Journal của một loài hoa hoặc lai tạo thành công biến thể Mythic khó nhất.
  - **Giá trị mở rộng:** Có thể sử dụng làm hình nền trang trí trong nhà của người chơi trong thị trấn (*Wall Art Housing Decoration*), chứng chỉ học giả hoặc phần thưởng sưu tầm dài hạn tạo nên bản sắc độc tôn cho **Plant Tales**.
