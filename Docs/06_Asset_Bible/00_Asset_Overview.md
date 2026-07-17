# Asset Overview

**Tài liệu quy chuẩn kỹ thuật và định hướng nghệ thuật chính thức của dự án Plant Tales (Studio Internal Standard Document).**

---

## 1. Purpose

Tài liệu **Asset Overview (`00_Asset_Overview.md`)** là bộ quy tắc chuẩn mực (*Standard Bible*) cho toàn bộ quy trình sản xuất tài nguyên đồ họa (Art Assets), hiệu ứng (VFX), giao diện (UI) và âm thanh (Audio) trong dự án **Plant Tales**.

Mục đích thiết yếu của bộ quy chuẩn này:
- **Đảm bảo tính đồng nhất tuyệt đối (Visual & Audio Cohesion):** Mọi tài nguyên dù được sản xuất bởi các nghệ sĩ khác nhau hay ở các giai đoạn phát triển khác nhau đều phải tuân thủ cùng một ngôn ngữ thiết kế, bảng màu và độ phân giải.
- **Tối ưu hóa hiệu năng và quy trình tích hợp (Engine Production Readiness):** Đặt ra các tiêu chuẩn rõ ràng về kích thước tile, lưới pixel, định dạng file và cấu trúc quy ước đặt tên để tích hợp liền mạch vào game engine mà không phát sinh lỗi kỹ thuật hay dư thừa dữ liệu.
- **Làm kim chỉ nam cho toàn bộ pipeline:** Là tài liệu tham chiếu đầu tiên trước khi bắt tay vào phác thảo concept, vẽ pixel sprite, làm animation hay xử lý hậu kỳ âm thanh.

---

## 2. Art Direction

Định hướng nghệ thuật của **Plant Tales** tập trung vào việc tạo dựng một thế giới mô phỏng ấm cúng, giàu tính học thuật thực vật và mang lại cảm giác bình yên sâu sắc cho người chơi.

Các tính từ cốt lõi định hình phong cách nghệ thuật (*Art Direction Keywords*):
- **Cozy (Ấm cúng & Thư giãn):** Đường nét mềm mại, tỷ lệ hình khối thân thiện, tránh các góc cạnh sắc nhọn hay chi tiết gây căng thẳng thị giác.
- **Botanical (Học thuật & Tinh tế về Thực vật):** Các chi tiết hoa lá, rễ cây, mầm hạt và đất trồng được quan sát và thể hiện với sự tinh tế và chính xác về cấu trúc sinh học, phảng phất phong cách hình minh họa trong các sổ tay thực vật học cổ điển.
- **Warm (Bảng màu ấm áp):** Ưu tiên các tông màu kem (*Cream*), nâu gỗ mộc (*Earthy Brown*), xanh lá trầm mát (*Sage Green*), vàng nắng chiều và các sắc độ hoa tự nhiên dịu mắt. Tránh sử dụng màu neon rực rỡ phi tự nhiên hoặc màu đen/trắng tuyệt đối.
- **Hopeful & Peaceful (Tràn đầy hy vọng & Bình yên):** Không khí tổng thể của thị trấn và khu vườn luôn mang lại cảm giác hy vọng, an lành và nhịp điệu sống chậm rãi.
- **Nature-first & Handcrafted feeling (Ưu tiên thiên nhiên & Cảm giác thủ công):** Mọi công trình kiến trúc, công cụ làm vườn hay vật phẩm đều mang dấu ấn thủ công của con người hài hòa sống cùng thiên nhiên, không có sự xuất hiện của công nghiệp nặng hay máy móc hiện đại thô cứng.

---

## 3. Camera Style

Góc máy trong **Plant Tales** được thiết kế chuẩn mực nhằm hỗ trợ tối đa cho gameplay quan sát từng ô đất trồng và tương tác với thị trấn:
- **Top-down with Slight 3/4 Perspective (Góc nhìn từ trên xuống nghiêng nhẹ 3/4):** Chuẩn góc nhìn orthographic 3/4 đặc trưng của các dòng game mô phỏng nông trại và nhập vai cổ điển chất lượng cao.
- **Orthographic Feeling (Cảm giác chiếu trục chuẩn xác):** 
  - Tỷ lệ các bức tường, nhân vật và cây trồng không bị biến dạng xa - gần (No perspective distortion).
  - Giúp người chơi căn chỉnh chính xác vị trí gieo hạt, đặt vòi phun nước và luân chuyển tài nguyên trên lưới bản đồ (*Grid System*).
  - Bề mặt ngang (đất, sàn nhà) và mặt đứng (mặt tiền nhà cửa, thân nhân vật, hoa nở cao) được cân bằng theo tỷ lệ thị giác hài hòa, giúp thể hiện rõ cả độ bao phủ mặt đất lẫn chiều cao của các loài hoa.

---

## 4. Visual Style

Sự đồng nhất về phong cách thị giác (*Visual Cohesion*) được quy định nghiêm ngặt trên tất cả các khía cạnh tài nguyên của game:

1. **Character (Nhân vật):**
   - Thiết kế tỷ lệ thân thiện (khoảng 3.5 đến 4 heads high cho sprite trong game), trang phục mang phong cách nhà nghiên cứu thực vật, làm vườn và cư dân thị trấn ôn đới ấm cúng.
   - Chân dung thoại (*Portrait*) trong Bloom Journal và hội thoại mang phong cách hình minh họa vẽ tay mềm mại (*Hand-drawn Illustration*), đồng điệu với bảng màu của sprite.

2. **Environment & Tilesets (Môi trường & Bản đồ):**
   - Lưới đất (*Soil Grid*) thể hiện rõ độ ẩm (đất khô màu nâu sáng, đất vừa tưới màu nâu sẫm bóng nhẹ).
   - Cây cối, thảm cỏ và lối đi lát đá mềm mại, các đường viền tiếp giáp giữa đất và cỏ được bo góc tự nhiên bằng autotile transition.

3. **Flowers (Hoa & Thực vật):**
   - Là điểm nhấn thị giác quan trọng nhất. Mỗi giai đoạn phát triển (*Seed → Sprout → Young Plant → Bud → Bloom → Perfect Bloom → Wilt*) có silhouette (hình bóng) rõ ràng dễ nhận diện ngay cả ở kích thước nhỏ.
   - Khi đạt trạng thái **Perfect Bloom**, hoa có hiệu ứng lấp lánh vi mô (*Subtle Micro-sparkle*) đắt giá, tạo cảm giác phần thưởng xứng đáng.

4. **Buildings (Kiến trúc & Công trình):**
   - Sử dụng vật liệu tự nhiên: ngói gạch đất nung, tường đá mộc, gỗ thông ấm, cửa kính nhà kính phản chiếu ánh sáng dịu nhẹ.

5. **UI (Giao diện người dùng):**
   - Phong cách sổ tay học giả (*Bloom Journal / Botanical Ledger*), nền giấy da mộc (*Parchment texture*), viền gỗ hoặc đồng cổ thô ráp.
   - Icon rõ ràng, dễ đọc trên nền tối hoặc nền giấy sáng, hỗ trợ tính năng kéo thả mượt mà trong Inventory.

6. **Animation & VFX (Chuyển động & Hiệu ứng):**
   - Chuyển động nhẹ nhàng, tự nhiên: hoa rung rinh trong gió (*Gentle wind sway*), nước tưới lan tỏa theo giọt tròn trịa, bụi phấn hoa bay lơ lửng khi lai tạo thành công.

---

## 5. Technical Standards

Toàn bộ tài nguyên khi xuất xưởng (*Export*) phải tuân thủ bảng thông số kỹ thuật tiêu chuẩn dưới đây:

| Asset Category | Standard Specs | Resolution / Grid | Color Format | Transparency & Background |
| --- | --- | --- | --- | --- |
| **Character Concept** | High-res Illustration | `2048x2048` px | RGBA / sRGB | Transparent Background (`.png`) |
| **Flower Concept** | High-res Botanical Sketch | `2048x2048` px | RGBA / sRGB | Transparent Background (`.png`) |
| **Pixel Sprite (Character)** | Sprite Sheet (`.png`) | `32x48` px per frame | Indexed / RGBA | Transparent, No anti-aliasing on outline |
| **Pixel Sprite (Flower)** | Growth Stages Sprite Sheet | `32x32` px per stage | Indexed / RGBA | Transparent, Crisp pixel art edges |
| **Portrait (Dialog / Journal)** | Hand-drawn Bust Portrait | `512x512` px | RGBA / sRGB | Transparent Background (`.png`) |
| **Tileset (Environment)** | Orthographic Grid Tileset | `32x32` px base grid | RGBA | Transparent border spacing if padded |
| **UI Element & Icon** | Pixel-perfect Icons / Frames | Icons `32x32`, Frames `1920x1080` base layout | RGBA | Transparent (`.png`) |
| **Animation VFX** | Sprite Sheet / Frame Sequence | `32x32` or `64x64` px | RGBA | Transparent (`.png`), Power of 2 sheet |
| **Audio (BGM)** | Stereo Music Loop | Sample Rate `44.1kHz`, 16-bit | Stereo | Seamless Loop (`.ogg` / `.wav`) |
| **Audio (SFX)** | Mono / Stereo Sound Effect | Sample Rate `44.1kHz`, 16-bit | Mono/Stereo | Normalized Peak (`-3dB`), `.wav` |

---

## 6. File Formats

Quy định định dạng file bắt buộc cho từng giai đoạn làm việc trong pipeline:
- **`.png` (Portable Network Graphics):** Định dạng xuất xưởng chuẩn duy nhất cho toàn bộ sprite, tileset, icon, concept đã duyệt và UI assets (bảo toàn kênh Alpha transparency không mất dữ liệu).
- **`.psd` (Photoshop Document):** Định dạng lưu trữ project gốc cho Concept Art, Portrait và UI Layout (phải giữ nguyên các layer tổ chức ngăn nắp, đặt tên layer rõ ràng).
- **`.aseprite` (Aseprite Sprite):** Định dạng project làm việc gốc cho toàn bộ Pixel Art Sprite, Tileset và Animation (bảo toàn tag animation, frame duration và palette màu).
- **`.wav` (Waveform Audio File Format):** Định dạng âm thanh không nén gốc cho SFX và BGM trước khi master.
- **`.ogg` (Ogg Vorbis):** Định dạng nén tối ưu dung lượng cho BGM khi import vào game engine.
- **`.md` (GitHub Markdown):** Định dạng tiêu chuẩn cho toàn bộ tài liệu kỹ thuật, ghi chú thiết kế và mô tả asset đi kèm trong `Docs/06_Asset_Bible/`.

---

## 7. Naming Convention

Mọi file tài nguyên phải tuân thủ quy tắc đặt tên **snake_case** (toàn bộ chữ thường, phân cách bằng dấu gạch dưới `_`). Tuyệt đối không sử dụng dấu cách, chữ có dấu, hay ký tự đặc biệt.

Cú pháp chuẩn: `[category]_[subcategory]_[name]_[variant/stage].[extension]`

Các ví dụ tiêu chuẩn:
- **Flowers:**
  - `flower_rose_seed.png` *(Sprite hạt giống hoa hồng)*
  - `flower_rose_sprout.png` *(Sprite giai đoạn nảy mầm)*
  - `flower_rose_bloom_perfect.png` *(Sprite giai đoạn nở hoàn hảo)*
  - `flower_rose_icon.png` *(Icon hoa hồng trong túi đồ)*
  - `flower_rose_concept.png` *(Concept art hoa hồng)*
- **Characters & NPC:**
  - `char_player_idle_sheet.png` *(Sprite sheet animation đứng yên của người chơi)*
  - `char_player_watering_sheet.png` *(Sprite sheet animation tưới nước)*
  - `npc_florist_idle.png` *(Sprite NPC bán hoa)*
  - `npc_florist_portrait_happy.png` *(Chân dung thoại biểu cảm vui vẻ của NPC bán hoa)*
- **Buildings & Tilesets:**
  - `bld_greenhouse_exterior.png` *(Sprite ngoại thất nhà kính)*
  - `tile_soil_farmland.png` *(Tileset đất trồng hoa)*
  - `tile_path_stone.png` *(Tileset đường lát đá)*
- **UI & Icons:**
  - `ui_journal_frame_main.png` *(Khung chính của Bloom Journal)*
  - `ui_icon_watercan_bronze.png` *(Icon bình tưới nước đồng)*
- **Audio:**
  - `bgm_spring_morning_loop.ogg` *(Nhạc nền buổi sáng mùa xuân)*
  - `sfx_water_pour_01.wav` *(Hiệu ứng tưới nước biến thể 1)*
  - `sfx_flower_harvest_perfect.wav` *(Hiệu ứng thu hoạch hoa hoàn hảo)*

---

## 8. Folder Convention

Toàn bộ tài nguyên thực tế phải được sắp xếp khoa học bên trong thư mục gốc `Assets/` theo đúng phân cấp loại tài nguyên, đối tượng cụ thể và giai đoạn asset (*Work-in-progress / Production*):

```text
Assets/
├── Flowers/
│   └── Rose/
│       ├── Concept/
│       │   └── flower_rose_concept.png
│       ├── Pixel/
│       │   ├── flower_rose_seed.png
│       │   ├── flower_rose_sprout.png
│       │   └── flower_rose_bloom.png
│       └── Icons/
│           └── flower_rose_icon.png
├── Characters/
│   ├── Player/
│   │   ├── Concept/
│   │   ├── Sprites/
│   │   └── Portraits/
│   └── NPC/
│       └── Florist/
│           ├── Sprites/
│           └── Portraits/
├── Buildings/
│   └── Greenhouse/
├── Tilesets/
│   ├── Farmland/
│   └── Village/
├── UI/
│   ├── Journal/
│   ├── HUD/
│   └── Icons/
└── Audio/
    ├── BGM/
    └── SFX/
```

Quy tắc bắt buộc:
- Không để file nằm trôi nổi ngay tại thư mục gốc `Assets/` hoặc thư mục cấp 1 (`Assets/Flowers/`). Mọi file phải nằm trong thư mục của đối tượng (`Rose/`, `Player/`, `Farmland/`).
- Phân tách rõ ràng giữa `Concept/` (tài liệu tham khảo/illustrate PSD, PNG 2048x2048) và `Pixel/` hoặc `Sprites/` (asset thực tế đưa vào game engine).

---

## 9. Asset Production Pipeline

Quy trình sản xuất tài nguyên được kiểm soát chặt chẽ theo 7 bước tuần tự nhằm đảm bảo chất lượng nghệ thuật trước khi đưa vào game engine:

```text
┌─────────────────┐
│   1. Concept    │  Phác thảo ý tưởng ban đầu (Sketch / Color Concept) dựa trên
│                 │  thông số thiết kế GDD (e.g. 01_Flower_Definition.md)
└────────┬────────┘
         ↓
┌─────────────────┐
│    2. Review    │  Đánh giá nội bộ về Art Direction, tỷ lệ hình khối, bảng màu
│                 │  và sự phù hợp với không gian chung của Plant Tales
└────────┬────────┘
         ↓
┌─────────────────┐
│   3. Approved   │  Chốt concept chính thức (Lock Concept), chuyển sang giai đoạn
│                 │  sản xuất tài nguyên thực tế (Production)
└────────┬────────┘
         ↓
┌─────────────────┐
│    4. Pixel     │  Vẽ Pixel Art Sprite / Tileset / UI Icon trên lưới tiêu chuẩn
│                 │  (Aseprite), tuân thủ bảng màu và silhouette
└────────┬────────┘
         ↓
┌─────────────────┐
│  5. Animation   │  Tạo chuyển động frame-by-frame (sự sinh trưởng, gió thổi,
│                 │  bước đi, thao tác công cụ) và xuất Sprite Sheet `.png`
└────────┬────────┘
         ↓
┌─────────────────┐
│   6. Import     │  Tích hợp vào Game Engine, kiểm tra cấu hình Pivot Point,
│                 │  Bounding Box, Collision Grid và Layering (Z-sort)
└────────┬────────┘
         ↓
┌─────────────────┐
│   7. In Game    │  Kiểm chứng thực tế trong môi trường gameplay chạy thử nghiệm
│                 │  (Prototype / Build), đánh giá cảm giác tương tác tổng thể
└─────────────────┘
```

---

## 10. Version Control

Mọi tài nguyên đồ họa, âm thanh và tài liệu Asset Bible phải gắn với 1 trong 4 trạng thái kiểm soát phiên bản tiêu chuẩn:
- **`Draft` (Phác thảo):** Tài nguyên hoặc thông số đang trong quá trình thử nghiệm ý tưởng ban đầu, chưa chốt thông số kỹ thuật, chưa sẵn sàng để đưa vào build chính thức.
- **`Review` (Chờ duyệt):** Tài nguyên đã hoàn thiện các bước thiết kế cơ bản, đang chờ kiểm tra đối chứng với `00_Asset_Overview.md` và GDD tương ứng trước khi khóa.
- **`Approved` (Đã duyệt & Sẵn sàng cho Production):** Tài nguyên đã hoàn toàn đạt chuẩn về thẩm mỹ và kỹ thuật, được cấp quyền đưa vào thư mục `Assets/` chính thức và tích hợp vào Source engine.
- **`Deprecated` (Đã lỗi thời / Lưu trữ):** Tài nguyên thuộc các phiên bản cũ đã được thay thế bởi bản nâng cấp tốt hơn. File không bị xóa ngay để phục vụ đối chứng lịch sử nhưng không được phép sử dụng trong code mới.

---

## 11. Future Expansion

Tài liệu quy chuẩn **Asset Overview (`00_Asset_Overview.md`)** được thiết kế như một tài liệu sống (*Living Standard Document*). Trong suốt các giai đoạn phát triển tiếp theo của **Plant Tales** (*Alpha, Beta & Live Service*):
- Các bảng màu theo mùa mới (*Autumn, Winter Palettes*), quy chuẩn kỹ thuật cho các hệ sinh thái mới hoặc cấu trúc shader/VFX nâng cao sẽ được bổ sung trực tiếp vào tài liệu này.
- Mọi tài liệu con từ `01_Characters.md` đến `08_Audio.md` trong thư mục `Docs/06_Asset_Bible/` khi được viết chi tiết đều phải lấy tài liệu số `00` này làm quy tắc căn bản tối cao.
