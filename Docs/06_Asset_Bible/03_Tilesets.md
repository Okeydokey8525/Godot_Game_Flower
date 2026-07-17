# Tileset Standard

**Tài liệu quy chuẩn kỹ thuật nền tảng thế giới và kể chuyện qua môi trường cho dự án Plant Tales (World Foundation & Environmental Storytelling Standard Document).**

---

## 1. Purpose

Tài liệu **Tileset Standard (`03_Tilesets.md`)** đóng vai trò là **World Foundation Standard (Quy chuẩn Nền móng Thế giới)** — kim chỉ nam định nghĩa cách toàn bộ thế giới trong **Plant Tales** được xây dựng, kết cấu và thổi hồn thông qua hệ thống lưới Tile.

Nếu `02_Flowers.md` là linh hồn của khu vườn, thì `03_Tilesets.md` chính là **linh hồn của thế giới thị trấn ôn đới**. Mục đích cốt lõi của bộ quy chuẩn này:
- **Xây dựng hệ quy chiếu không gian cho toàn bộ game:** Định nghĩa cấu trúc lưới tiêu chuẩn (*Orthographic Grid*), phân lớp layer và hộp va chạm để mọi công trình, nhân vật và luống hoa có thể tích hợp hoàn hảo.
- **Biến mỗi ô gạch thành một công cụ kể chuyện (Environmental Storytelling):** Khẳng định triết lý rằng Tile không chỉ để lấp đầy màn hình hay phục vụ di chuyển, mà mỗi bề mặt đất, từng viên đá trải đường hay đám rêu phong đều phải góp phần kể lại lịch sử, văn hóa và nếp sống của cư dân thị trấn.
- **Tách biệt vai trò với Level Design:** Tài liệu này chuyên chú vào **quy chuẩn asset kỹ thuật và ngôn ngữ hình ảnh của Tile**, tuyệt đối không mô tả thiết kế của từng bản đồ cụ thể hay vị trí đặt để các khu vực (để xem thiết kế bản đồ, vui lòng tham chiếu tài liệu Level Design).

---

## 2. Tile Categories

Hệ thống Tileset của **Plant Tales** được phân loại thành 10 nhóm tài nguyên chuyên biệt, bao phủ mọi địa hình ngoại thất và nội thất trong thế giới:

- **Ground (Lớp đất nền tự nhiên):**
  - Các lớp nền địa hình cơ bản nhất như thảm cỏ (*Grass*), đất thô (*Dirt*), cát ven hồ (*Sand*) và vách đá tự nhiên. Là lớp lót đáy nền tảng của bản đồ.
- **Path (Đường đi & Lối mòn):**
  - Các loại đường sá nhân tạo hoặc bán nhân tạo: đường đá tảng quảng trường, đường gạch thẻ, lối mòn đất nện dẫn ra rừng, ván cầu gỗ và bậc thềm đá.
- **Farm Soil (Đất trồng trọt chuyên dụng):**
  - Hệ thống ô đất làm vườn có thể tương tác (cuốc, tưới nước, bón phân). Thể hiện rõ các trạng thái khô thô ráp, ẩm ướt tối màu và đất màu mỡ có dinh dưỡng cao.
- **Water (Thủy vực & Dòng chảy):**
  - Mặt nước suối, bờ sông cỏ mọc, ao hồ tĩnh lặng và thác nước mini. Hỗ trợ animation bờ nước tiếp giáp nhẹ nhàng và độ phản chiếu ánh nắng.
- **Nature (Thảm thực vật tự nhiên & Địa hình cản):**
  - Cây cổ thụ, bụi rậm, vách núi, tảng đá tự nhiên, khúc gỗ rêu phong và các cụm hoa dại ven đường. Là các vật thể tạo khung ranh giới (*Bounds*) và làm mềm bản đồ.
- **Decoration (Vật phẩm trang trí môi trường):**
  - Hàng rào gỗ, cột đèn đường rèn sắt, ghế đá công viên, chậu hoa công cộng, giếng nước cũ và biển chỉ dẫn thị trấn.
- **Structures (Chi tiết kiến trúc ngoại thất):**
  - Các phần tiếp giáp kiến trúc như nền móng nhà gạch, bậc thềm gỗ trước hiên, giàn dây leo bám tường hiên và mái vòm cổng chào thị trấn.
- **Interior (Nội thất & Sàn nhà):**
  - Sàn gỗ ấm cúng trong nhà kính, gạch bông trang trí thư viện, thảm trải sàn dệt tay và tường gạch trong nhà.
- **Seasonal (Biến thể theo mùa & Thời tiết):**
  - Bộ lớp phủ và biến thể màu theo mùa (*Spring, Summer, Autumn, Winter*) hoặc lớp phủ thời tiết sau mưa (*Wet overlays*).
- **Special (Đặc biệt & Lễ hội):**
  - Gạch trang trí hoa văn cổ truyền cho Lễ hội Hoa, bệ đá cúng tế thực vật và các ô thạch rêu bí ẩn trong rừng sâu.

---

## 3. Tile Technical Standards

Toàn bộ tài nguyên Tileset khi sản xuất và nghiệm thu bắt buộc phải tuân thủ bảng thông số kỹ thuật tiêu chuẩn dưới đây:

| Standard Component | Technical Specification & Rules | Detailed Application Notes |
| --- | --- | --- |
| **Tile Size (Base Grid)** | **`32x32` pixels** (Base Orthographic Grid) | Kích thước chuẩn cho 1 ô vuông cơ bản. Các vật thể lớn hơn (như cây cối, đá tảng) phải là bội số của `32` (`64x64`, `96x96`, `128x128`). |
| **Collision (Hộp va chạm)** | Pixel-perfect Bounding Box | Vật thể cản (đá, thân cây) chỉ đặt va chạm ở phần gốc sát đất `(khoảng 16-24 pixels dưới cùng)` để nhân vật có thể đi sau tán lá (*Z-sort*). |
| **Layer (Phân lớp)** | 6-Layer Standard Engine Setup | Tuân thủ thứ tự Z-order: Ground → Object → Decoration → Roof → Shadow → Collision. |
| **Grid (Lưới làm việc)** | Orthographic Projection Alignment | Đường viền ngang - dọc phải căn chuẩn theo lưới `32x32`, tránh viền xô lệch gây hở rãnh pixel (*Seam artifacts*) khi lặp lại. |
| **Animation (Chuyển động)** | `4` to `8` Frames Loop per sheet | Dành cho mặt nước rung rinh (*Water ripple*), ngọn cỏ gió thổi (*Swaying grass*) và hoa dại. Tốc độ `150–250ms`/frame. |
| **Transition (Chuyển tiếp)** | Organic Autotile Mask & Dithering | Các đường viền tiếp giáp giữa 2 loại địa hình phải có lớp đệm tự nhiên bo tròn mềm mại, tránh cắt góc vuông vức `90` độ cứng nhắc. |
| **Auto Tile (Lát tự động)** | 47-Tile Bitmask Standard (Wang/Bitmask) | Bộ sprite sheet cấu hình đầy đủ góc trong, góc ngoài, cạnh thẳng và ô độc lập để engine tự động ghép nối mượt mà. |
| **Shadow (Bóng đổ)** | Semi-transparent Black (`#000000`, Alpha `25–35%`) | Bóng đổ của cây cối và công trình hướng góc 45 độ xuống bên phải, không dùng bóng đen đặc hoàn toàn mà phải thấu hình nền đất phía dưới. |

---

## 4. Visual Style

Ngôn ngữ hình ảnh của toàn bộ Tileset phải truyền tải trọn vẹn sự ấm cúng, thư thái và vẻ đẹp thiên nhiên phong phú:

- **Cozy & Botanical (Ấm cúng & Mang đậm chất Thực vật):** Màu sắc dịu dàng, đường nét mộc mạc mang cảm giác bình yên của một thị trấn chuyên trồng trọt và yêu cây cỏ.
- **Soft Edges & Handcrafted Feeling (Đường viền mềm mại & Cảm giác thủ công):**
  - Các đường viền đá lát đường được vẽ bo tròn các góc, có kẽ hở cho rêu xanh chen ngang.
  - Hàng rào gỗ có sự hơi cong vênh nhẹ tự nhiên của thủ công đẽo gọt, không thẳng đơ và công nghiệp.
- **Natural Color Variation (Đổi màu tự nhiên phong phú):**
  - Trên một thảm cỏ lớn, không dùng duy nhất 1 ô gạch lặp lại liên tục gây nhàm chán thị giác (*Grid repetition fatigue*).
  - Phải có ít nhất `4–6` biến thể thảm cỏ (`Tile variations`) với sự chênh lệch nhẹ về độ sáng, xen kẽ vài cụm cỏ ba lá hoặc nhấp nhô của đất.
- **Easy Readability (Độ dễ đọc tối đa):**
  - Màu của nền đất trồng (*Farm Soil*) và đường đi (*Path*) phải có độ tương phản đủ rõ so với thảm cỏ và cây cối xung quanh để người chơi dễ dàng nhận biết khu vực nào có thể cuốc đất gieo hạt, khu vực nào để chạy bộ.

---

## 5. Environmental Storytelling Standard

Đây là tiêu chuẩn cực kỳ đắt giá định hình bản sắc của **Plant Tales** — **Mỗi ô gạch lát nền đều phải sở hữu một linh hồn và góp phần kể lại câu chuyện về không gian nơi nó tồn tại (*Every tile tells a story*)**:

- **Quảng trường trung tâm thị trấn (Central Plaza):**
  - Đường lát đá tảng cẩn thận, bằng phẳng, sạch sẽ, thể hiện đây là nơi tập trung sinh hoạt đông đúc, được chăm sóc và quét dọn thường xuyên bởi cư dân.
- **Lối mòn vào khu vườn lâu năm (Old Garden Path):**
  - Những viên gạch nung nứt nhẹ, mép đường thô ráp có những bụi cỏ dại và hoa mười giờ mọc chen qua kẽ đá, kể lại câu chuyện về một khu vườn từng bị bỏ quên hoặc có tuổi đời lâu năm cùng thiên nhiên.
- **Cầu gỗ bắc qua suối (Rustic Wooden Bridge):**
  - Những thanh ván gỗ sẫm màu vì hơi ẩm mặt nước, hai bên lan can phủ lớp rêu xanh mát dịu nhẹ ở phần chân tiếp xúc bờ đất.
- **Khu Lễ hội Hoa truyền thống (Festival Grounds):**
  - Những ô gạch được xếp theo họa tiết hình cánh hoa hồng hoặc hoa hướng dương ở giữa lối đi, phán ánh lòng tôn kính và di sản văn hóa thực vật lâu đời của thị trấn.
- **Đường mòn trong rừng sâu (Forest Trail):**
  - Lối đất nện xen lẫn rễ cây cổ thụ trồi lên mặt đường, điểm xuyết thảm lá rụng màu nâu vàng và những tán nấm nhỏ ven đường.

---

## 6. Tile Transition Rules

Để loại bỏ hoàn toàn cảm giác "ghép khối vuông vức" giả tạo thường thấy trong các game pixel cơ bản, quy tắc chuyển tiếp địa hình (*Transition Rules*) quy định thứ tự chuyển tiếp hữu cơ mềm mại theo chuỗi hệ sinh thái:

```text
Grass ➔ Tall Grass ➔ Dirt ➔ Stone Path ➔ Water
```

1. **Quy tắc Tiếp giáp Mềm mại (Soft Organic Blending):**
   - Khi `Grass` tiếp giáp với `Dirt` (đất thô), viền cỏ không cắt thẳng mà viền cong lượn sóng lởm chởm nhẹ (`Organic dithering/masking`).
   - Giữa `Grass` và `Stone Path` luôn có lớp cỏ thấp lấn nhẹ lên mép viên đá `1–2` pixels.
2. **Chuyển tiếp Thủy vực (Water Transition):**
   - Tiếp giáp giữa đất/cỏ và `Water` phải qua lớp bờ đất ẩm màu nâu sẫm lót cát sỏi nhỏ sát mép nước (*Riverbank border tile*), kèm animation bọt nước vỗ nhẹ vào bờ.

---

## 7. Layer Rules

Toàn bộ thế giới được tổ chức theo cấu trúc **6 lớp layer tiêu chuẩn** bên trong game engine nhằm quản lý Z-sort và hiệu ứng hình ảnh chính xác:

1. **Ground Layer (Lớp nền đáy):** Thảm cỏ cơ bản, đất nện, cát, vách lòng suối và lòng đường.
2. **Object Layer (Lớp vật thể bề mặt & Đất trồng):** Ô đất làm vườn (*Farm Soil*), đường gạch lát đè lên cỏ, ván cầu gỗ, rêu phong và thảm lá rụng.
3. **Decoration Layer (Lớp trang trí & Yếu tố tương tác ngang):** Hàng rào, ghế đá, gốc cây cổ thụ, chậu hoa, nhân vật (*Characters*) và hoa đang trồng trên luống (*Z-ordered dynamic layer*).
4. **Roof Layer (Lớp mái che & Tán lá trên cao):** Tán lá cây cổ thụ che khuất nhân vật khi đi bên dưới, mái nhà kính, cổng vòm hiên nhà.
5. **Shadow Layer (Lớp bóng đổ môi trường):** Bóng cây và bóng công trình chiếu góc 45 độ xuống nền đất, kết xuất ở chế độ Alpha Blend mờ.
6. **Collision Layer (Lớp dữ liệu va chạm vô hình):** Lưới data định nghĩa các ô cản bước chân người chơi (`1 = blocked, 0 = walkable`).

---

## 8. Seasonal Variations & Living World Standard

Để thế giới trong **Plant Tales** thực sự có sinh khí và luôn vận động, quy chuẩn Tileset tích hợp hai cơ chế song hành: **Seasonal Variations (Biến thể theo mùa)** và **Living World Standard (Thế giới sống động tự phản ứng)**:

### 🌸 Seasonal Variations (Quy chuẩn 4 mùa)
Toàn bộ hệ thống Tile nền tảng phải thay đổi bảng màu và lớp chi tiết phụ (*Secondary details*) theo mùa mà **không làm thay đổi hình dáng hình học cơ bản** để giữ nguyên nhận diện và dữ liệu va chạm:
- **Spring (Mùa xuân):** Cỏ màu xanh non tươi mát tràn đầy nhựa sống, xuất hiện xen kẽ các cụm hoa dại nhỏ màu vàng trắng (*Spring wildflowers*).
- **Summer (Mùa hè):** Thảm cỏ chuyển sang màu xanh lục sẫm rực rỡ và dày thảm hơn, bóng râm cây cối đậm và mát mẻ.
- **Autumn (Mùa thu):** Cỏ ngả sang tông màu vàng ấm (*Warm golden-amber*), lối đi và mép sông điểm xuyết những chiếc lá phong khô rụng thưa thớt.
- **Winter (Mùa đông):** Cỏ ngả màu nâu vàng úa tĩnh lặng hoặc phủ một lớp sương muối/tuyết mỏng màu trắng kem dịu mắt (*Soft cream snow dusting*).

### 🌱 Living World Standard (Thế giới sống động tự phản ứng)
Thị trấn phải có những phản ứng nhỏ tinh tế trước thời tiết và sự kiện mà không tạo thêm áp lực gameplay cho người chơi:
- **Phản ứng sau cơn mưa (Post-rain Wetness):** Ngay sau khi trời mưa tạnh, toàn bộ các ô đường đất nện và luống đất chưa trồng hoa sẽ tự động chuyển sang lớp màu nâu sẫm bóng nhẹ trong `1/2` ngày game, phản ánh mặt đất ngấm nước mát lành.
- **Sự sinh trưởng vi mô ven sông (Riverbank Growth):** Sau mỗi tuần trong game, một vài cụm cỏ non hoặc rêu xanh nhỏ có thể ngẫu nhiên xuất hiện thêm dọc bờ suối ven thị trấn.
- **Cánh hoa rơi sau Lễ hội (Post-Festival Petal Drift):** Trong `2–3` ngày sau khi kết thúc đêm Lễ hội Hoa, khu vực quảng trường trung tâm sẽ lưu lại những cánh hoa hồng và hoa giấy li ti rơi rải rác trên nền đá trước khi gió thổi bay hết.

---

## 9. Naming Convention

Mọi file tài nguyên Tileset phải tuân thủ nghiêm ngặt quy tắc **snake_case** theo định dạng chuẩn:  
`tile_[category]_[subcategory/name]_[variant/bitmask].[ext]`

Danh sách ví dụ tiêu chuẩn cho hệ thống Tileset:
- **Ground & Paths:**
  - `tile_ground_grass_base.png` *(Sheet thảm cỏ nền tảng)*
  - `tile_ground_grass_var01.png` *(Biến thể cỏ có hoa dại)*
  - `tile_path_stone_bitmask.png` *(Sheet bitmask autotile đường lát đá quảng trường)*
  - `tile_path_dirt_corner.png` *(Góc rẽ lối đi đất nện)*
- **Farm Soil & Water:**
  - `tile_farm_soil_dry.png` *(Sheet ô đất trồng hoa khi khô)*
  - `tile_farm_soil_wet.png` *(Sheet ô đất trồng hoa đã tưới nước)*
  - `tile_water_river_anim.png` *(Sheet animation dòng suối)*
- **Nature & Storytelling Details:**
  - `tile_nature_tree_oak_base.png` *(Gốc cây cổ thụ rêu phong)*
  - `tile_deco_bridge_mossy.png` *(Ván cầu gỗ phủ rêu rách)*
  - `tile_special_festival_petal.png` *(Lớp phủ gạch hoa văn Lễ hội Hoa)*

---

## 10. Folder Convention

Toàn bộ tài nguyên Tileset phải được phân bổ khoa học bên trong thư mục `Assets/Tilesets/` theo đúng nhóm địa hình và mùa vụ:

```text
Assets/
└── Tilesets/
    ├── Ground/
    │   ├── tile_ground_grass_base.png
    │   └── tile_ground_dirt_base.png
    ├── Road/
    │   ├── tile_path_stone_bitmask.png
    │   └── tile_path_wood_bridge.png
    ├── Farm/
    │   ├── tile_farm_soil_dry.png
    │   └── tile_farm_soil_wet.png
    ├── Water/
    │   └── tile_water_river_anim.png
    ├── Nature/
    │   ├── tile_nature_tree_oak.png
    │   └── tile_nature_rock_moss.png
    ├── Interior/
    │   ├── tile_interior_wood_floor.png
    │   └── tile_interior_greenhouse_wall.png
    ├── Festival/
    │   └── tile_special_festival_plaza.png
    └── Seasonal/
        ├── Spring/
        ├── Summer/
        ├── Autumn/
        └── Winter/
```

---

## 11. Production Pipeline

Quy trình chuẩn hóa sản xuất tài nguyên Tileset từ khâu nghiên cứu địa hình đến khi tích hợp mượt mà vào engine:

```text
┌─────────────────┐
│  1. Reference   │  Thu thập hình ảnh tham khảo về đường đá cổ, gạch mộc và
│                 │  thảm thực vật ôn đới (Botanical & Architecture references)
└────────┬────────┘
         ↓
┌─────────────────┐
│   2. Concept    │  Phác thảo bảng màu và mẫu thử chuyển tiếp trên lưới 32x32 px,
│                 │  kiểm tra ý tưởng kể chuyện môi trường (Moss, fallen leaves)
└────────┬────────┘
         ↓
┌─────────────────┐
│    3. Review    │  Đánh giá độ lặp lại thị giác (Repetition fatigue check) và
│                 │  độ tương phản dễ đọc giữa đường đi và đất trồng trọt
└────────┬────────┘
         ↓
┌─────────────────┐
│   4. Approved   │  Khóa mẫu thiết kế, chuyển sang giai đoạn sản xuất sheet
│                 │  Aseprite chuẩn hóa bitmask
└────────┬────────┘
         ↓
┌─────────────────┐
│    5. Pixel     │  Vẽ Sprite Sheet theo quy chuẩn 47-Tile Bitmask Wang/Auto
│                 │  Tile, đảm bảo khớp nối rãnh pixel 100%
└────────┬────────┘
         ↓
┌─────────────────┐
│6. Auto Tile Test│  Kiểm thử ghép nối tự động trong Aseprite/Tiled Editor,
│                 │  xác minh đường bo cong mềm mại của thảm cỏ khi uốn lượn
└────────┬────────┘
         ↓
┌─────────────────┐
│7. Engine Import │  Tích hợp vào Engine, thiết lập 6 lớp Layer Z-order, cấu
│                 │  hình Bounding Box va chạm chỉ ở gốc cây/đá
└────────┬────────┘
         ↓
┌─────────────────┐
│   8. In Game    │  Kiểm nghiệm chạy thử trong Prototype di chuyển, xác minh
│                 │  phản ứng Living World sau mưa và độ hòa quyện tổng thể
└─────────────────┘
```

---

## 12. Future Expansion

Tài liệu quy chuẩn **Tileset Standard (`03_Tilesets.md`)** sở hữu kiến trúc mở sẵn sàng đón nhận các khu vực và hiệu ứng môi trường đặc biệt trong lộ trình phát triển dài hạn:

- **Weather Variants (Biến thể thời tiết nâng cao):** Hệ thống lớp phủ cho mưa giông lớn (*Storm puddles*), gió lốc xoáy lá rụng hoặc vệt nắng gắt chiếu qua tán lá cây (`God rays overlays`).
- **Seasonal & Festival Decorations (Trang phục môi trường Lễ hội):** Bộ cờ hoa, đèn lồng thảo mộc, cổng chào và thảm hoa trang trí tạm thời cho các sự kiện theo mùa.
- **Ancient Botanical Ruins (Di tích thực vật cổ đại):** Bộ Tileset kiến trúc đá rêu phong thạch anh bí ẩn nằm sâu trong rừng già, nơi mọc những giống hoa Mythic huyền thoại.
- **Botanical Garden & Glasshouse Expansions (Khu bảo tồn Thực vật kính lớn):** Hệ thống gạch kính thông sáng, hệ thống ống dẫn nước tưới tự động và bệ đặt tiêu bản hoa nghiên cứu sang trọng cho khu vực mở rộng tối thượng của người chơi.
- **Secret Areas & Hidden Trails (Khu vực bí ẩn & Lối đi ẩn):** Các vách đá có rèm dây leo che khuất có thể dùng liềm cắt mở ra lối đi dẫn vào thung lũng hoa bí mật.
