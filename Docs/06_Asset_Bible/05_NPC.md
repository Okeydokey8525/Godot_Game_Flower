# NPC Assets

**Tài liệu quy chuẩn kỹ thuật tài nguyên, triết lý cộng đồng sống động và tính cách hoa dành cho NPC trong dự án Plant Tales (NPC Assets & Community Standards Document).**

---

## 1. Purpose

Tài liệu **NPC Assets (`05_NPC.md`)** là bộ quy chuẩn tối cao định nghĩa cách thức xây dựng tài nguyên hình ảnh, hành vi tương tác và vai trò xã hội của hệ thống nhân vật không điều khiển (*Non-Playable Characters — NPC*) trong **Plant Tales**.

Trong **Plant Tales**, NPC tuyệt đối không được thiết kế như những cỗ máy phát thoại đứng yên một chỗ hay những bức tượng vô hồn chờ người chơi đến kích hoạt nhiệm vụ. Khẳng định triết lý thiết kế (*Design Philosophy*):
- **NPC là nhịp đập của thị trấn sống động:** Cư dân là những thực thể có nếp sống hàng ngày, có mạng lưới quan hệ cộng đồng, tự động phản ứng với thời tiết, sự kiện khôi phục làng và đặc biệt là có sự am hiểu sâu sắc về ngôn ngữ của các loài hoa (*Language of Flowers*).
- **Tiêu chuẩn hóa hệ thống tài nguyên đồng bộ:** Đặt ra các quy chuẩn kỹ thuật rõ ràng về Sprite sheet, Portrait đa biểu cảm, Icon lịch trình và Icon độ thân thiện để tích hợp hoàn hảo vào engine game cùng với hệ thống tài nguyên nhân vật chính (`01_Characters.md`).
- **Tách biệt vai trò với Character Bible & Script:** Tài liệu này tập trung thiết lập **quy chuẩn asset kỹ thuật và nguyên tắc hệ thống cộng đồng (*Community Standards*)**, không mô tả tiểu sử cốt truyện của từng NPC hay viết lời thoại kịch bản chi tiết (để tra cứu thông tin tiểu sử và kịch bản, vui lòng tham chiếu `Docs/02_Design_Bible/03_Character_Bible.md` và hệ thống Dialogue Script).

---

## 2. NPC Categories

Hệ thống NPC của **Plant Tales** được phân tầng thành 7 nhóm tài nguyên cốt lõi, mỗi nhóm sở hữu vai trò chức năng, độ chi tiết animation và bộ tài nguyên đi kèm riêng biệt:

- **Main NPC (Cư dân cốt lõi):**
  - Những nhân vật trụ cột có cốt truyện sâu sắc, sở hữu mạng lưới quan hệ phức tạp và hành trình phát triển cùng người chơi. Yêu cầu bộ Sprite sheet di chuyển đầy đủ 4 hướng, lịch trình sinh hoạt động và bộ Portrait tối thiểu 7 biểu cảm tiêu chuẩn.
- **Shop NPC (Cư dân thương mại & Quản lý cửa tiệm):**
  - Những người phụ trách giao thương (bán hạt giống, nông cụ, trà thảo mộc). Sở hữu thêm các animation thao tác nghề nghiệp sau quầy hàng và Portrait chào mời thân thiện.
- **Research NPC (Học giả & Nhà nghiên cứu thực vật):**
  - Những nhân vật gắn liền với hệ thống **Bloom Journal**, phòng thí nghiệm và thư viện. Thường xuyên tương tác với mẫu hoa ép, tiêu bản khoa học và cung cấp chỉ dẫn lai tạo di truyền.
- **Festival NPC (Cư dân & Nghệ nhân Lễ hội):**
  - Những nhân vật phụ trách tổ chức, điều phối sự kiện trong đêm Lễ hội Hoa truyền thống. Sở hữu bộ trang phục sự kiện độc đáo (*Festival Outfits*) và animation tham gia nghi lễ.
- **Visitor NPC (Khách vãng lai & Du khách thị trấn):**
  - Những du khách hoặc thương nhân đến thăm thị trấn vào cuối tuần hoặc mùa lễ hội, giúp phản ánh độ danh tiếng của thị trấn hoa đang ngày một khôi phục. Yêu cầu bộ Sprite cơ bản và 1–2 biểu cảm Portrait tiêu chuẩn.
- **Elder NPC (Cư dân trưởng bối & Người lưu giữ ký ức):**
  - Những bão bối lâu năm trong thị trấn (Trưởng làng, ông bà lão làm vườn). Là những chứng nhân lịch sử nắm giữ chìa khóa về **Pressed Memories** và quá khứ thuở hoàng kim của thị trấn.
- **Child NPC (Trẻ em thị trấn):**
  - Các nhân vật nhí với dáng người nhỏ nhắn (khoảng `2.5 - 3` heads high cho sprite), sở hữu animation chạy nhảy hồn nhiên quanh quảng trường hoặc công viên hoa.

---

## 3. Community Standard

Khác với mô hình các tựa game nông trại cũ nơi mỗi NPC sống cô lập trong một "bong bóng vô hình" chỉ biết trò chuyện với người chơi, **Community Standard (Quy chuẩn Cộng đồng Liên kết)** yêu cầu toàn bộ NPC của **Plant Tales** phải tạo thành một mạng lưới xã hội hữu cơ thắt chặt:

```text
Florist ➔ (Quen biết & Nhắc tới) ➔ Librarian ➔ (Thảo luận) ➔ Mayor ➔ (Tôn trọng) ➔ Old Gardener
```

- **Sự liên đới trong lời thoại và nhận thức:** Cư dân trong thị trấn đều biết tên nhau, nắm rõ tính cách và nghề nghiệp của nhau. Trong hội thoại hàng ngày, NPC sẽ tự nhiên nhắc đến các NPC khác (Ví dụ: Người bán hoa sẽ khuyên người chơi đến gặp Học giả thư viện để tìm hiểu về cách trồng loài lan hiếm; Trưởng làng sẽ hỏi thăm sức khỏe của người làm vườn già).
- **Tương tác xã hội tự động:** Vào những khung giờ rảnh rỗi hoặc buổi tối, các NPC có thể cùng tụ tập tại quán trà, quảng trường hiên nhà để cùng nhau trò chuyện, tạo cảm giác thị trấn là một đại gia đình ấm áp thật sự.

---

## 4. Daily Life Standard

Để người chơi thực sự cảm nhận được rằng *"Cư dân đang sống cùng một nhịp thở với thị trấn"*, **Daily Life Standard (Quy chuẩn Nhịp sống Thường nhật)** quy định mỗi NPC phải có một lịch trình di chuyển theo các mốc thời gian trong ngày (*Dynamic Daily Schedule*):

```text
Morning (Dậy & Mở cửa hiên) ➔ Work (Làm việc) ➔ Break (Nghỉ trơi/Uống trà) ➔ Evening (Dạo bộ/Giao lưu) ➔ Home (Về nhà & Nghỉ ngơi)
```

- **Nguyên tắc nhịp sống logic:** Lịch trình của NPC phải phản ánh đúng nghề nghiệp và thói quen tự nhiên. 
  - *Ví dụ nguyên tắc:* Buổi sáng sớm, NPC bán hoa ra trước hiên tưới các chậu hoa chưng bày; buổi trưa nghỉ tay sang thư viện đọc sách hoặc uống trà thảo mộc; chiều tối đi dạo quanh quảng trường ngắm hoàng hôn trước khi trở về hiên nhà đóng cửa nghỉ ngơi.
- **Không đứng yên vĩnh cửu:** Tuyệt đối tránh tình trạng một NPC đứng chết chân tại quầy hàng từ 6 giờ sáng đến 12 giờ đêm không di chuyển.

---

## 5. Living Community Standard

**Living Community Standard (Quy chuẩn Cộng đồng Sống động tự phản ứng)** nâng cấp trí tuệ và sự nhạy bén của NPC lên một tầm cao mới: Cư dân không chỉ phản ứng với món quà của người chơi, mà còn **chủ động nhận thức và bình luận về sự thay đổi của thế giới môi trường xung quanh**:

- **Phản ứng Thời tiết (Weather Awareness):**
  - Khi trời mưa dầm, NPC tự động che ô, trú dưới mái hiên hoặc bình luận về thời tiết: *"Trời mưa rào mát rượi thế này, những rễ hoa hồng ngoài vườn chắc chắn sẽ đâm chồi rất nhanh đấy!"*
- **Phản ứng Mùa vụ (Seasonal Awareness):**
  - Khi chuyển giao mùa, cư dân thay đổi trang phục phù hợp và bày tỏ cảm xúc trước cảnh sắc mới của thị trấn: *"Gió mùa thu đã thổi qua quảng trường rồi, lá vàng bay thực sự lãng mạn."*
- **Phản ứng Lễ hội (Festival Reflections):**
  - Trong và sau các sự kiện, lời thoại NPC phản ánh dư âm lễ hội: *"Quảng trường đêm Lễ hội Hoa năm nay rực rỡ hơn hẳn năm ngoái, cảm ơn những chậu hoa tuyệt đẹp của cậu!"*
- **Phản ứng Khôi phục Làng & Tiến độ Nghiên cứu (Restoration & Research Progress):**
  - Khi người chơi sửa chữa xong Nhà kính cũ hay tìm ra một giống hoa Mythic hiếm trong **Bloom Journal**, NPC sẽ kinh ngạc chúc mừng và chia sẻ niềm tự hào chung của cả thị trấn.

---

## 6. Flower Personality Standard

Đây là bộ hiến pháp độc quyền của **Plant Tales** kết nối sâu sắc giữa hệ thống thực vật và mạng lưới quan hệ xã hội — **Flower Personality Standard (Quy chuẩn Tính cách & Ngôn ngữ Hoa)**. 

Thay vì cơ chế tặng quà học vẹt đơn điệu (*Học thuộc 1 món quà duy nhất cho 1 NPC*), hệ thống sở thích của NPC được định hình dựa trên nhóm thực vật và **Ngôn ngữ các loài hoa (*Language of Flowers*)**:

```text
Flower Database ➔ Language of Flowers ➔ NPC Preference ➔ Story / Bloom Journal ➔ Festival Bond
```

- **Thích theo Nhóm hoa & Ý nghĩa thực vật (Group & Meaning Preference):**
  - Mỗi NPC yêu thích một dải ý nghĩa hoặc một nhóm hoa mang tính cách đồng điệu với tâm hồn họ:
    - *NPC Hướng nội & Thanh khiết:* Yêu thích **White Flowers (Nhóm hoa trắng)** và các loài hoa tượng trưng cho sự tinh khôi (*Purity* như Lily, White Rose).
    - *NPC Nghệ sĩ & Thư thái:* Yêu thích các loài hoa mang tông màu trầm mát và ý nghĩa bình an (*Calm / Serenity* như Lavender, Sage).
    - *NPC Trưởng bối & Uyên bác:* Trân quý những loài hoa cổ điển mang ý nghĩa ngưỡng mộ và kiên trường (*Admiration / Resilience* như Camellia, Winter Pine hoa).
- **Tối ưu hóa giá trị Sưu tầm & Lai tạo:** Cơ chế này khuyến khích người chơi say mê khám phá, lai tạo ra nhiều giống hoa mới và kiểm tra trang **Bloom Journal** để hiểu rõ ý nghĩa của từng bông hoa trước khi chọn làm quà tặng tâm giao cho NPC.

---

## 7. NPC Technical Standards

Bảng thông số kỹ thuật tiêu chuẩn cho toàn bộ tài nguyên NPC khi sản xuất và nghiệm thu vào engine:

| Asset Component | Standard Specs | Resolution / Grid Configuration | Color & Alpha Format | Technical Specification & Notes |
| --- | --- | --- | --- | --- |
| **Concept Art** | Character Turnaround & Outfit | `2048x2048` px | RGBA / sRGB (`.png`) | Transparent background, kèm bảng màu chỉ định và phụ kiện nghề nghiệp |
| **Portrait (Dialog)** | Bust Portrait (Từ ngực lên) | Khung `512x512` px | RGBA / sRGB (`.png`) | Transparent background, nét mềm, góc sáng trên trái `45` độ chuẩn `01_Characters.md` |
| **Expression Pack** | Minimum 7-Expression Sheet | Grid `512x512` / frame | RGBA / sRGB (`.png`) | *Neutral, Happy, Smile, Thinking, Surprised, Sad, Determined* trên cùng 1 base |
| **Pixel Sprite (Base)**| Orthographic Grid Sheet | Frame `32x48` px (`32x32` cho Child)| Indexed / RGBA (`.png`) | Pivot chạm đất giữa 2 chân `(X:16, Y:48)`, Bounding box va chạm `16x12` dưới chân |
| **Schedule Icon** | Daily Routine / Map Indicator | `16x16` hoặc `32x32` px | RGBA (`.png`) | Icon nhỏ hiển thị trạng thái làm việc, nghỉ ngơi hoặc ngủ trên bản đồ mini |
| **Relationship Icon**| Flower Bond / Heart Indicator | `16x16` hoặc `32x32` px | RGBA (`.png`) | Icon nụ hoa/bông hoa nở dần tương ứng với cấp độ thân thiện (*Friendship Level*) |

---

## 8. Visual Style

Ngôn ngữ nghệ thuật của NPC phải toát lên sự thân thiện, đa dạng và hòa quyện cùng tự nhiên:
- **Cozy & Warm (Ấm cúng & Gần gũi):** Nét mặt phúc hậu, nụ cười hiền hòa, ánh mắt trong sáng tạo cảm giác an toàn và chào đón.
- **Botanical & Approachable (Mang dấu ấn Thực vật & Dễ tiếp cận):** Trang phục của NPC luôn có sự xuất hiện của các chi tiết tự nhiên như tạp dề làm vườn, trâm cài mái hoa, túi vải thảo dược hoặc hoa văn thêu hình lá.
- **Diverse & Unique Silhouette (Đa dạng lứa tuổi & Hình bóng đặc trưng):** Từ em bé chạy nhảy đến cụ già chống gậy, mỗi NPC sở hữu một dáng đi, chiều cao và silhouette rõ ràng, giúp người chơi dễ dàng nhận ra người quen từ xa mà không cần nhấp chuột xem tên.

---

## 9. Naming Convention

Mọi file tài nguyên thuộc hệ thống NPC phải tuân thủ nghiêm ngặt quy định **snake_case** theo định dạng chuẩn:  
`[category]_[npc_id/role]_[type/action]_[variant].[ext]`

Danh sách ví dụ tiêu chuẩn cho cư dân thị trấn:
- **Pixel Sprite Sheets:**
  - `npc_florist_idle.png` *(Sheet đứng yên của NPC bán hoa)*
  - `npc_florist_walk.png` *(Sheet đi bộ của NPC bán hoa)*
  - `npc_librarian_read.png` *(Sheet đọc sách của học giả thư viện)*
  - `npc_mayor_walk.png` *(Sheet đi dạo của trưởng làng)*
- **Dialog Portraits & Expressions:**
  - `portrait_npc_florist_neutral.png` *(Chân dung mặc định NPC bán hoa)*
  - `portrait_npc_florist_happy.png` *(Chân dung rạng rỡ nhận hoa đúng sở thích)*
  - `portrait_npc_librarian_thinking.png` *(Chân dung suy tư khi nghiên cứu tiêu bản)*
  - `portrait_npc_elder_sad.png` *(Chân dung tiếc nuối khi nhớ về quá khứ)*
- **Icons & Metadata:**
  - `icon_schedule_tea_break.png` *(Icon lịch trình uống trà)*
  - `icon_relation_bloom_stage3.png` *(Icon độ thân thiện cấp 3)*

---

## 10. Folder Convention

Toàn bộ tài nguyên NPC được tổ chức khoa học bên trong cấu trúc thư mục `Assets/NPC/`, phân tách rõ ràng theo nhóm cư dân và loại tài nguyên (*Portraits vs Sprites*):

```text
Assets/
└── NPC/
    ├── Main/
    │   ├── Florist/
    │   │   ├── Concept/
    │   │   ├── Sprites/
    │   │   │   ├── npc_florist_idle.png
    │   │   │   └── npc_florist_walk.png
    │   │   └── Portraits/
    │   │       ├── portrait_npc_florist_neutral.png
    │   │       └── portrait_npc_florist_happy.png
    │   └── Librarian/
    │       ├── Sprites/
    │       └── Portraits/
    ├── Shop/
    │   └── Herbalist/
    ├── Festival/
    │   └── FestivalCoordinator/
    └── Visitors/
        └── TravelingBotanist/
```

---

## 11. Production Pipeline

Quy trình chuẩn hóa sản xuất tài nguyên NPC từ khâu nghiên cứu tính cách đến khi thả vào thị trấn sinh sống:

```text
┌─────────────────┐
│  1. Reference   │  Nghiên cứu tạo hình cư dân thị trấn ôn đới (Cottagecore,
│                 │  botanical occupations) và xác định dải sở thích hoa
└────────┬────────┘
         ↓
┌─────────────────┐
│   2. Concept    │  Vẽ phác thảo Turnaround `2048x2048` px, định hình Silhouette,
│                 │  phụ kiện nghề nghiệp và bảng màu cá nhân
└────────┬────────┘
         ↓
┌─────────────────┐
│    3. Review    │  Đánh giá tính hòa quyện vào cộng đồng (Community Standard),
│                 │  kiểm tra độ rõ nét chân dung trên khung thoại UI
└────────┬────────┘
         ↓
┌─────────────────┐
│   4. Approved   │  Khóa thiết kế Concept, chốt ID nhân vật và chuyển sang
│                 │  giai đoạn số hóa tài nguyên
└────────┬────────┘
         ↓
    ┌────┴───────────────────────────┐
    ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│   5a. Portrait  │              │   5b. Sprite    │
│ Khung chuẩn 512x│              │ Lưới 32x48 px,  │
│ 512, vẽ đủ 7 bộ │              │ vẽ Idle & Walk  │
│ biểu cảm chuẩn  │              │ 4 hướng chuẩn   │
└────────┬────────┘              └────────┬────────┘
         │                                │
         └───────────────┬────────────────┘
                         ▼
┌──────────────────────────────────────────────────┐
│                   6. Animation                   │
│  Hoàn thiện Sprite Sheet di chuyển, animation    │
│  đặc thù nghề nghiệp (đọc sách, tưới chậu hoa)   │
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    7. Import                     │
│  Tích hợp vào Engine, thiết lập Pivot chạm chân  │
│  `(X:16, Y:48)`, cấu hình chu kỳ Daily Schedule  │
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    8. In Game                    │
│  Kiểm chứng lịch trình di chuyển trên map, phản  │
│  ứng với thời tiết mưa/lễ hội và hệ thống tặng hoa│
└──────────────────────────────────────────────────┘
```

---

## 12. Future Expansion & Advanced Community Systems

Tài liệu quy chuẩn **NPC Assets (`05_NPC.md`)** được cấu trúc kiến trúc mở để sẵn sàng tích hợp các hệ thống chiều sâu xã hội cao cấp trong tương lai:

- **Family Trees & Intergenerational Bonds (Cây gia phả & Mối liên hệ thế hệ):** Hệ thống tài nguyên thể hiện mối quan hệ huyết thống giữa các NPC (ông bà — cha mẹ — con cháu), cho phép mở khóa các dòng đối thoại gia tộc sâu sắc.
- **Dynamic Friendships & Rivalries (Tình bạn động & Sự cạnh tranh lành mạnh):** Cư dân có thể tự phát triển mối quan hệ với nhau (cùng nhau tổ chức tiệc trà hay thi đua trồng hoa trong Lễ hội).
- **Seasonal & Event Outfits (Trang phục theo mùa & Sự kiện):** Bộ Sprite và Portrait nâng cấp khi cư dân khoác lên mình áo ấm mùa đông hoặc trang phục lễ hội trang trọng.
- **💡 Village Memory System (Hệ thống Ký ức Thị trấn — Long-term Narrative & Community Standard):**
  - **Định nghĩa đặc biệt:** Một cơ chế kể chuyện cộng đồng vĩ mô độc tôn của **Plant Tales** — không chỉ người chơi có **Pressed Memories**, mà **toàn bộ thị trấn cũng sở hữu một bộ ký ức chung sống động (*Collective Village Memory*)**.
  - **Cơ chế hoạt động:** Khi người chơi đạt được các cột mốc khôi phục làng mạc (*Sửa chữa Quảng trường hoa, Khôi phục Nhà kính kính mờ hay hồi sinh Thư viện cổ*), toàn bộ mạng lưới NPC sẽ tự động cập nhật "ký ức cộng đồng".
  - **Trải nghiệm cốt truyện:** 
    - Các NPC trưởng bối sẽ xúc động hồi tưởng và kể lại những câu chuyện về Lễ hội Hoa hoàng kim nhiều thập kỷ trước ngay tại quảng trường vừa được làm mới.
    - Một học giả nghiên cứu sẽ chia sẻ ký ức về lần đầu tiên người ông của Mia/Okeydokey gieo hạt giống hoa quý tại Nhà kính năm xưa.
  - **Mạng lưới kết nối tối thượng:** Cơ chế này kết nối hoàn hảo giữa **Memory Places (`04_Buildings.md`)**, **Pressed Memories (`14_Pressed_Memories.md`)**, **Bloom Journal** và **NPC Community**, biến mỗi bước chân khôi phục thị trấn của người chơi thành một hành trình đánh thức linh hồn và ký ức của cả một cộng đồng ôn đới đượm tình người.
