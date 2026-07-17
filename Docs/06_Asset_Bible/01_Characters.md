# Character Assets

**Tài liệu quy chuẩn kỹ thuật và nghệ thuật chuyên biệt dành cho tài nguyên nhân vật của dự án Plant Tales (Character Asset Standard Document).**

---

## 1. Purpose

Tài liệu **Character Assets (`01_Characters.md`)** thiết lập các tiêu chuẩn tối cao cho toàn bộ quy trình thiết kế, sản xuất và đóng gói tài nguyên liên quan đến nhân vật (*Character Art Assets*) trong **Plant Tales**.

Mục đích thiết yếu của bộ quy chuẩn này:
- **Đồng bộ hóa nhận diện hình ảnh nhân vật:** Đảm bảo toàn bộ nhân vật từ nhân vật người chơi (*Playable Characters*) đến cư dân thị trấn (*NPCs*) đều tuân theo cùng một tỷ lệ hình khối, ngôn ngữ thiết kế và độ chi tiết pixel, loại bỏ hiện tượng sai lệch phong cách giữa các đối tượng.
- **Tiêu chuẩn hóa hệ thống Sprite và Portrait:** Định định chính xác lưới pixel (*Grid setup*), kích thước khung hình, quy cách chân dung hội thoại (*Dialog Portrait*) và danh sách animation tối thiểu, cho phép tích hợp trực tiếp vào hệ thống điều khiển và hội thoại của game engine.
- **Tách biệt vai trò với Character Bible:** Tài liệu này chuyên chú vào **quy chuẩn asset kỹ thuật/đồ họa**, không chứa thông tin cốt truyện hay tính cách của từng nhân vật cụ thể (để đối chiếu thông tin tiểu sử nhân vật, vui lòng tham chiếu `Docs/02_Design_Bible/03_Character_Bible.md`).

---

## 2. Character Categories

Hệ thống nhân vật trong **Plant Tales** được phân chia thành 5 nhóm tài nguyên cốt lõi, mỗi nhóm có mức độ chi tiết và yêu cầu bộ sprite/portrait riêng biệt:

- **Playable Characters (Nhân vật người chơi):**
  - Trung tâm trải nghiệm của game. Yêu cầu mức độ chi tiết cao nhất, sở hữu bộ animation di chuyển đa hướng và toàn bộ các thao tác tương tác công cụ làm vườn, nâng vác vật phẩm và sinh hoạt hàng ngày.
- **Main NPCs (NPC cốt lõi / Cư dân chính):**
  - Các nhân vật có cốt truyện sâu sắc, sở hữu lịch trình sinh hoạt phức tạp và độ thân thiện (*Relationship System*). Yêu cầu đầy đủ sprite sheet di chuyển đa hướng và bộ chân dung thoại đa biểu cảm (*Full Expression Set*).
- **Minor NPCs (NPC phụ / Khách vãng lai):**
  - Cư dân hỗ trợ nền hoặc khách tham quan thị trấn. Yêu cầu bộ sprite sheet cơ bản (Đi/Đứng) và chân dung thoại tiêu chuẩn (1–2 biểu cảm cơ bản).
- **Festival NPCs (NPC Lễ hội / Sự kiện đặc biệt):**
  - Nhân vật chỉ xuất hiện trong các sự kiện hoặc Lễ hội Hoa truyền thống. Trang phục và tạo hình mang tính lễ hội độc đáo, tuân thủ bảng màu sự kiện nhưng giữ nguyên tỷ lệ khung hình chuẩn.
- **Animals (Động vật / Thú cưng — Future Expansion):**
  - Các sinh vật nhỏ trong khu vườn hoặc vật nuôi thị trấn (chó, mèo, chim chóc). Hệ thống lưới pixel và animation được thiết kế ở quy mô nhỏ hơn nhưng hài hòa với nét vẽ tổng thể.

---

## 3. Character Visual Style

Tạo hình nhân vật trong **Plant Tales** phải truyền tải được tinh thần ấm áp, gần gũi và niềm say mê với thiên nhiên, tuân thủ chặt chẽ định hướng chung từ `00_Asset_Overview.md`:

- **Cozy & Friendly (Ấm cúng & Thân thiện):** Biểu cảm khuôn mặt hiền hòa, ánh mắt mềm mại, mang lại cảm giác an tâm và chào đón cho người chơi ngay từ cái nhìn đầu tiên.
- **Soft Shape Language & Rounded Silhouette (Ngôn ngữ hình khối mềm mại & Đường viền bo tròn):**
  - Ưu tiên sử dụng các đường cong mềm mại và các khối bo tròn trên mái tóc, vai áo, mũ và giày.
  - Tuyệt đối tránh các góc nhọn gay gắt, các chi tiết gai góc hoặc tỷ lệ cơ thể quá sắc lạnh.
- **Botanical (Dấu ấn Thực vật học):** Trang phục được lấy cảm hứng từ trang phục làm vườn thực tế, áo choàng nghiên cứu nhẹ nhàng, tạp dề vải lanh và các họa tiết thêu hoa lá mộc mạc.
- **Warm Colors (Bảng màu ấm áp & tự nhiên):** Sử dụng dải màu dịu nhẹ: tông màu da ấm, màu tóc tự nhiên (nâu dẻ hạt, đen tuyền bóng mờ, vàng lúa mì, đỏ rỉ sắt mộc) và màu vải vóc nhuộm từ thảo mộc.
- **Semi-realistic Anime Influence (Ảnh hưởng Anime bán chân thực):** Tỷ lệ khuôn mặt và ánh mắt mang nét biểu cảm tinh tế của anime phong cách đời sống (*Slice-of-life*), kết hợp với tỷ lệ hình thể gọn gàng, cân đối (khoảng `3.5` đến `4` heads high cho sprite pixel trong game).

---

## 4. Character Technical Standards

Bảng thông số kỹ thuật tiêu chuẩn cho toàn bộ tài nguyên nhân vật khi sản xuất và nghiệm thu:

| Asset Type | Standard Dimensions | Resolution / Grid | Color & Alpha Format | Special Technical Notes |
| --- | --- | --- | --- | --- |
| **Character Concept** | Front & Back Illustration | `2048x2048` px | RGBA / sRGB (`.png`) | Transparent background, kèm bảng màu chỉ định (*Color Palette Swatches*) |
| **Full Body Concept** | High-res Render / Key Art | `2048x3072` px | RGBA / sRGB (`.png`) | Transparent background, ánh sáng chuẩn góc 45 độ từ trên xuống |
| **Turnaround Sheet** | 4-View Orthographic Ortho | `3072x2048` px | RGBA / sRGB (`.png`) | Mặt trước, góc nghiêng 3/4, mặt bên, mặt sau (có đường gióng tỷ lệ chuẩn) |
| **Portrait (Dialog)** | Bust Portrait (Ngực lên) | `512x512` px | RGBA / sRGB (`.png`) | Transparent background, viền nét mềm mại, chuẩn xác vị trí mắt/cằm |
| **Sprite Sheet (Base)**| Orthographic Grid Sheet | Frame `32x48` px | Indexed / RGBA (`.png`) | Transparent background, lưới đều `32x48` px, Pivot tại điểm chạm đất giữa 2 chân |
| **Expression Sheet** | Portrait Expression Pack | Grid `512x512` / frame | RGBA / sRGB (`.png`) | Tối thiểu 7 biểu cảm chuẩn, giữ nguyên vị trí khuôn mặt gốc |

---

## 5. Sprite Standards

Quy cách chi tiết cho bộ Sprite Pixel của nhân vật trong game engine:

1. **Pixel Size & Grid Configuration:**
   - Kích thước khung hình tiêu chuẩn cho 1 frame nhân vật: **`32x48` pixels** (Chiều rộng `32` px, Chiều cao `48` px).
   - Điểm neo (*Pivot Point / Anchor*): Đặt chính giữa viền dưới của khung hình `(X: 16, Y: 48)`, tương ứng với điểm tiếp xúc của bàn chân nhân vật với mặt đất.
   - Bounding Box & Collision: Hộp va chạm di chuyển được giới hạn ở phần chân nhân vật `(khoảng 16x12 pixels dưới cùng)` để cho phép phần đầu và thân trên có thể xếp lớp (*Z-order sorting*) chính xác phía trước hoặc phía sau các chậu hoa, cây cối và công trình.

2. **Standard Action Set (Danh sách Animation cơ bản yêu cầu):**
   Mỗi nhân vật (đặc biệt là Playable Character) phải sở hữu đầy đủ bộ hướng di chuyển cho các hành động sau:
   - **Idle (Đứng yên thở nhẹ):** `4` hướng (Up, Down, Left, Right), nhịp thở mềm mại `4–6` frames.
   - **Walk (Đi bộ cơ bản):** `4` hướng, `6–8` frames/hướng, nhịp bước chân đều đặn.
   - **Run (Chạy nhanh):** `4` hướng, `6–8` frames/hướng, dáng đổ người nhẹ về phía trước.
   - **Water (Tưới nước):** `4` hướng, `6–8` frames, diễn hoạt nhấc bình tưới, nghiêng bình và đổ dòng nước đều đặn.
   - **Harvest (Thu hoạch hoa/cây):** `4` hướng, `6` frames, động tác cúi xuống cắt/nhổ nhẹ nhàng nâng niu bông hoa.
   - **Carry (Bê vác vật phẩm nặng/chậu hoa lớn):** `4` hướng (Đi bộ trong tư thế hai tay ôm vật phẩm phía trước ngực).
   - **Sleep (Ngủ / Nghỉ ngơi):** `1` hướng ngang giường, `4` frames nhịp thở chậm rãi, biểu tượng thư giãn (`Zzz`).

---

## 6. Portrait Standards

Chân dung thoại (*Dialog Portrait*) đóng vai trò truyền tải cảm xúc trong hệ thống hội thoại và Bloom Journal:
- **Resolution (Độ phân giải):** Khung chuẩn **`512x512` pixels**, xuất file `.png` với nền trong suốt (*Transparent Background*).
- **Bust Portrait Framing (Bố cục từ ngực lên):** Cắt bố cục từ phần ngực/vai trở lên đến hết đỉnh đầu. Phần vai phải cân đối, khuôn mặt chiếm khoảng `50–60%` diện tích khung hình để đảm bảo rõ nét khi thu nhỏ trên khung thoại UI.
- **Consistent Lighting (Ánh sáng đồng nhất):** Nguồn sáng chính chiếu dịu nhẹ từ góc trên bên trái xuống góc 45 độ (*Top-left Soft Lighting*). Tránh đánh sáng ngược hoặc bóng đổ quá gắt làm mất đi nét mềm mại ấm cúng.
- **Line Art & Coloring:** Đường viền nét mềm (*Soft Line Art*), màu lót phẳng kết hợp đổ bóng chuyển sắc dịu dàng (*Soft-cel shading*).

---

## 7. Expression Standards

Để phục vụ hệ thống cốt truyện và sự linh hoạt trong tương tác NPC, bộ chân dung thoại phải đi kèm tối thiểu **7 biểu cảm tiêu chuẩn (`Expression Pack`)**, được duy trì trên cùng một khung hình gốc để không bị giật khuôn mặt khi chuyển nháy thoại:

1. **Neutral (Bình tĩnh / Tiêu chuẩn):** Biểu cảm mặc định khi bắt đầu hội thoại, nụ cười nhẹ mỉm thân thiện.
2. **Happy (Vui vẻ rạng rỡ):** Nụ cười tươi, đôi mắt cong nhẹ, không khí vui tươi (dùng khi nhận quà đúng sở thích hoặc khi thu hoạch Perfect Bloom).
3. **Smile (Mỉm cười ấm áp):** Ánh mắt hiền hòa, nét mặt thư thái (dùng trong các cuộc trò chuyện sinh hoạt hàng ngày).
4. **Thinking (Suy tư / Nghiên cứu):** Tay chạm nhẹ cằm hoặc ánh mắt hướng sang bên, chân mày hơi nhướng (dùng khi quan sát hạt giống hoặc đọc Bloom Journal).
5. **Surprised (Ngạc nhiên / Thích thú):** Mắt mở tròn, miệng hé nhẹ (dùng khi phát hiện đột biến lai tạo mới hoặc sự kiện lạ trong vườn).
6. **Sad (Buồn / Tiếc nuối):** Lông mày xệ nhẹ, ánh mắt trầm buông (dùng khi hoa bị héo hoặc nghe kể câu chuyện quá khứ của thị trấn).
7. **Determined (Quyết tâm / Hào hứng):** Ánh mắt kiên định, nụ cười tự tin (dùng khi nhận nhiệm vụ khôi phục Lễ hội Hoa).

---

## 8. Accessories

Các phụ kiện (*Accessories*) không chỉ là trang trí mà là một phần nhận diện thị giác cốt lõi (*Visual Identity*) nói lên nghề nghiệp và tình yêu thực vật của nhân vật:

- **Flower Hairpin (Trâm cài hoa / Kẹp tóc hoa):** Phụ kiện cài trên mái tóc hoặc sau tai, thường phản ánh loài hoa yêu thích hoặc biểu tượng của nhân vật đó.
- **Bookmark (Thẻ kẹp sách / Dây ruy băng):** Dây ruy băng màu pastel giắt trên túi áo choàng hoặc kẹp trong cuốn sổ tay nghiên cứu mang theo bên người.
- **Gardening Gloves (Găng tay làm vườn):** Găng tay vải da hươu mềm hoặc găng tay làm vườn chất liệu tự nhiên, thể hiện sự chuyên nghiệp và cẩn trọng khi chăm sóc rễ hoa.
- **Botanical Bag (Túi đeo chéo thực vật học):** Túi da mộc đeo chéo hông hoặc sau lưng, nơi nhân vật chứa bình xịt nước mini, kéo cắt tỉa, kính lúp và các ống nghiệm bảo quản hạt giống.

---

## 9. Naming Convention

Mọi file tài nguyên nhân vật phải tuân thủ nghiêm ngặt quy tắc **snake_case** theo định dạng chuẩn:  
`[type]_[character_id/role]_[action/view]_[variant/frame].[ext]`

Danh sách ví dụ tiêu chuẩn cho hệ thống nhân vật:
- **Pixel Sprite Sheets:**
  - `player_female_idle.png` *(Sheet animation đứng yên của nhân vật người chơi nữ)*
  - `player_female_water.png` *(Sheet animation tưới nước của người chơi nữ)*
  - `npc_florist_walk.png` *(Sheet animation đi bộ của NPC bán hoa)*
  - `npc_botanist_harvest.png` *(Sheet animation thu hoạch của NPC học giả thực vật)*
- **Dialog Portraits & Expressions:**
  - `portrait_player_female_neutral.png` *(Chân dung biểu cảm mặc định người chơi nữ)*
  - `portrait_player_female_happy.png` *(Chân dung biểu cảm vui vẻ)*
  - `portrait_npc_florist_thinking.png` *(Chân dung biểu cảm suy tư của NPC bán hoa)*
  - `portrait_npc_elder_sad.png` *(Chân dung biểu cảm đượm buồn của trưởng làng)*
- **Concept & Reference Files:**
  - `concept_player_turnaround.png` *(Bản phác thảo turnaround 4 hướng)*
  - `concept_npc_florist_sheet.png` *(Bản thiết kế chi tiết trang phục và phụ kiện)*

---

## 10. Folder Convention

Tài nguyên nhân vật phải được lưu trữ ngăn nắp bên trong cấu trúc thư mục `Assets/Characters/`, phân tách rõ giữa nhân vật người chơi (`Player/`), cư dân (`NPC/`) và các phân nhánh tài nguyên cụ thể:

```text
Assets/
└── Characters/
    ├── Player/
    │   ├── Concept/
    │   │   ├── concept_player_turnaround.png
    │   │   └── concept_player_palette.png
    │   ├── Sprites/
    │   │   ├── player_female_idle.png
    │   │   ├── player_female_walk.png
    │   │   └── player_female_water.png
    │   └── Portraits/
    │       ├── portrait_player_female_neutral.png
    │       └── portrait_player_female_happy.png
    └── NPC/
        ├── Florist/
        │   ├── Concept/
        │   ├── Sprites/
        │   │   └── npc_florist_idle.png
        │   └── Portraits/
        │       ├── portrait_npc_florist_neutral.png
        │       └── portrait_npc_florist_happy.png
        └── Botanist/
            ├── Concept/
            ├── Sprites/
            └── Portraits/
```

---

## 11. Character Production Pipeline

Quy trình chuẩn hóa sản xuất tài nguyên nhân vật từ ý tưởng đến khi tích hợp hoàn chỉnh vào game engine:

```text
┌─────────────────┐
│   1. Concept    │  Vẽ phác thảo tạo hình, kiểm tra tỷ lệ Silhouette bo tròn,
│                 │  phối phụ kiện làm vườn & chỉ định bảng màu ấm áp (`2048x2048`)
└────────┬────────┘
         ↓
┌─────────────────┐
│    2. Review    │  Đánh giá tính đồng nhất Art Direction (Cozy/Botanical) và
│                 │  sự khác biệt nhận diện so với các nhân vật hiện có
└────────┬────────┘
         ↓
┌─────────────────┐
│   3. Approved   │  Khóa thiết kế Concept, chốt Turnaround Sheet (`3072x2048`),
│                 │  chuyển sang bước số hóa Sprite và Portrait
└────────┬────────┘
         ↓
    ┌────┴───────────────────────────┐
    ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│ 4a. Pixel Sprite│              │ 4b. Portrait    │
│ Lưới chuẩn 32x48│              │ Khung chuẩn     │
│ vẽ Idle/Walk    │              │ 512x512 nét mềm │
└────────┬────────┘              └────────┬────────┘
         ↓                                ↓
┌─────────────────┐              ┌─────────────────┐
│  5. Animation   │              │  6. Expressions │
│ Diễn hoạt hướng │              │ Hoàn thiện bộ   │
│ tưới/thu hoạch  │              │ 7 biểu cảm chuẩn│
└────────┬────────┘              └────────┬────────┘
         │                                │
         └───────────────┬────────────────┘
                         ▼
┌──────────────────────────────────────────────────┐
│                    7. Import                     │
│  Thiết lập Pivot Point (X:16, Y:48), Bounding    │
│  Box dưới chân, tích hợp Dialog Portrait UI      │
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                   8. In Game                     │
│  Kiểm chứng di chuyển trong thế giới, Z-sort     │
│  với chậu hoa và trải nghiệm hội thoại thực tế   │
└──────────────────────────────────────────────────┘
```

---

## 12. Future Expansion

Tài liệu quy chuẩn **Character Assets (`01_Characters.md`)** được cấu trúc linh hoạt để hỗ trợ mở rộng quy mô hệ thống nhân vật trong các giai đoạn tiếp theo của dự án:
- **Costume & Seasonal Outfits (Trang phục theo mùa):** Hệ thống sprite sheet và portrait sẽ được mở rộng để hỗ trợ các bộ trang phục thay đổi theo mùa (*Spring Garden Coat, Autumn Knit Sweater, Winter Scarf*), tuân thủ cùng một khung lưới `32x48` px gốc.
- **Festival Outfits (Trang phục Lễ hội Hoa):** Các bộ trang phục trang trọng dành riêng cho sự kiện đêm Lễ hội Hoa truyền thống.
- **Pets & Companions (Thú cưng đồng hành):** Khung tiêu chuẩn cho động vật nhỏ đi theo sau nhân vật (*Follower system*) trên lưới `16x16` hoặc `32x32` px.
- **Mounts / Garden Cart (Xe đẩy hoa / Phương tiện):** Quy chuẩn cho sprite nhân vật khi tương tác hoặc điều khiển các phương tiện vận chuyển chậu hoa lớn trong thị trấn.
