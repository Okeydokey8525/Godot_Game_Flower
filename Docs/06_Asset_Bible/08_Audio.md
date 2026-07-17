# Audio Assets & Environmental Soundscape Standards

**Tài liệu quy chuẩn tài nguyên âm thanh, triết lý không gian thính giác và hệ sinh thái hòa âm cho dự án Plant Tales (Audio Philosophy & Environmental Soundscape Standards Document).**

---

## 1. Purpose

Tài liệu **Audio Assets & Environmental Soundscape Standards (`08_Audio.md`)** là mảnh ghép hiến pháp tối cao cuối cùng hoàn thiện toàn bộ **Asset Bible (`00–08`)** của **Plant Tales**, định nghĩa triết lý thiết kế âm thanh, kỹ thuật hòa trộn nhiều lớp và quy chuẩn tài nguyên SFX/BGM cho trò chơi.

Trong ngành công nghiệp thiết kế âm thanh game (*Game Audio Design*), có một chân lý bất di bất dịch: **"Người chơi có thể không nhớ từng nốt nhạc hay tên bản soundtrack, nhưng họ sẽ vĩnh viễn nhớ rõ cảm giác bình yên, thư thái mà không gian âm thanh đó mang lại cho tâm hồn."** Mục đích cốt lõi của bộ quy chuẩn này:
- **Xây dựng hệ sinh thái thính giác sống động (*Living Soundscape Philosophy*):** Âm thanh trong **Plant Tales** không phải là công cụ phát nhạc nền lấp đầy khoảng trống hay chỉ chạy tiếng động thao tác nhấp chuột. Âm thanh chính là hơi thở, là nhịp đập, là giọng nói thầm thì của tự nhiên và thị trấn.
- **Tôn trọng sự cân bằng giữa âm nhạc và môi trường:** Đảm bảo nhạc nền (*BGM*) không bao giờ lấn át tiếng gió thổi qua lá sồi, tiếng nước suối chảy hay tiếng lạch cạch của chiếc bình tưới nước.
- **Tách biệt với Soundtrack List:** Tài liệu này thiết lập **triết lý thính giác (*Philosophy*) và quy chuẩn kỹ thuật cho asset âm thanh**, không phải là danh sách phát nhạc (*Tracklist catalog*) hay bảng lời ca khúc.

---

## 2. Living Soundscape Philosophy

**Living Soundscape Philosophy (Triết lý Không gian Âm thanh Sống động)** khẳng định rằng thế giới của **Plant Tales** luôn phát ra âm thanh tự hữu cơ ngay cả khi không có bất kỳ nốt nhạc BGM nào đang chạy. Không gian thính giác tổng thể được kiến tạo từ sự hòa quyện của 7 tầng âm thanh tự nhiên (*Audio Stratification*):

```text
BGM + Ambient + Nature + Village + Characters + Weather + UI = Living Soundscape
```

- **Quy tắc không lấn át (`BGM Subordination Rule`):**
  - Nhạc nền (*Background Music — BGM*) được thiết kế ở mức âm lượng vừa phải, tiết tấu chậm rãi mộc mạc (sử dụng đàn acoustic guitar, piano nỉ mềm, sáo gỗ, cello ấm).
  - Khi người chơi đi vào khu rừng sâu hoặc đứng cạnh thác nước, BGM tự động hạ âm lượng (*Duck/Fade*) để nhường chỗ cho tầng **Ambient** (tiếng gió rừng) và **Nature** (tiếng thác đổ, chim hót).

---

## 3. Natural Layer System

**Natural Layer System (Hệ thống Phân lớp Tự nhiên)** định nghĩa rằng mỗi khu vực địa hình trong game phải sở hữu một khối hòa âm môi trường đa lớp (*Multi-layered Soundscape*), được trộn theo thời gian thực dựa trên vị trí và mật độ vật thể xung quanh nhân vật:

```text
Wind (Gió nền) ➔ Leaves (Lá xào xạc) ➔ River (Nước suối) ➔ Birds & Insects (Sinh vật) ➔ Flowers (Hòa âm thực vật)
```

- **Cơ chế trộn lớp môi trường hữu cơ (`Organic Layer Blending`):**
  - **Wind Layer (Lớp gió nền):** Lớp âm thanh dải tần rộng êm dịu thổi liên tục nhẹ nhàng làm nền tảng cho mọi bản đồ ngoại thất.
  - **Leaves & Foliage Layer (Lớp cây cối):** Khi nhân vật đi dưới tán lá trên `Roof Layer` hoặc khi gió thổi mạnh, lớp âm thanh sột soạt nhẹ của lá sồi và lá ngải cứu tự động tăng âm lượng tương ứng với độ lắc của Animation (`07_Animation.md`).
  - **River Layer (Lớp thủy vực):** Âm thanh róc rách của dòng suối có định vị không gian 2D (*Spatial panning*), lớn dần khi nhân vật bước gần bờ sông và nhỏ dần khi rời đi.
  - **Birds & Insects Layer (Lớp sinh vật nhỏ):** Tiếng chim sẻ hót thưa thớt vào buổi sáng, tiếng dế kêu êm đềm lúc hoàng hôn và màn đêm.

---

## 4. Silence Is Also Audio

Đây là triết lý thính giác vô cùng đắt giá mà rất nhiều tựa game hiện đại bỏ qua — **Silence Is Also Audio (Sự Tĩnh lặng cũng là một Nghệ thuật Âm thanh)**. Trong một thế giới cozy cần sự tĩnh tâm, khoảng lặng không phải là "lỗi mất tiếng", mà là chất xúc tác cảm xúc tối cao:

- **Tôn vinh những khoảnh khắc không BGM (`Intentional BGM Silence`):**
  - **Buổi sáng sớm tinh sương (5:00 AM – 6:30 AM):** Khi nhân vật vừa thức dậy bước ra khỏi hiên nhà, hoàn toàn **không có BGM phát ra**. Người chơi chỉ nghe thấy tiếng gió rít nhẹ qua ống khói, tiếng vài chú chim non vừa tỉnh giấc và tiếng bước chân lạo xạo trên bãi cỏ đẫm sương đêm.
  - **Sau cơn mưa rào lớn:** Khi mưa vừa tạnh, nhạc nền tạm dừng trong vài phút để người chơi lắng nghe trọn vẹn tiếng những giọt nước đọng đầm đìa nhỏ giọt từ mái hiên xuống các vũng nước trên nền đất (*Eaves dropping ambience*).
- **Giá trị mang lại:** Những khoảng lặng chủ đích này giúp tâm trí người chơi được reset, tạo nên sự tương phản tuyệt vời khi bản nhạc nền acoustic êm dịu tiếp theo từ từ cất lên.

---

## 5. Botanical Audio Standard

Trong **Plant Tales**, thực vật không vô tri mà sở hữu những tần số phản hồi cực kỳ tinh tế thông qua **Botanical Audio Standard (Quy chuẩn Âm thanh Thực vật học)**. Hoa không "lên tiếng nói", mà chúng giao tiếp bằng những vi âm tự nhiên và tiếng vang huyền diệu (*Micro-acoustics*):

| Trạng thái / Cấp độ Hoa | Hiện tượng hình ảnh đồng bộ (`07_Animation.md`) | Đặc tả âm thanh thực vật (*Botanical Audio Profile*) |
| --- | --- | --- |
| **Normal Bloom (Nở thường)** | Hoa rung rinh theo nhịp gió nhẹ | **Soft Wind & Leaves:** Tiếng cọ xát cực nhẹ của lá và cánh hoa khi đung đưa trong gió. |
| **Perfect Bloom (Nở hoàn hảo)** | Hạt sáng `Micro Sparkles` nảy lên rồi lơ lửng | **Micro Chimes:** Tiếng chuông thủy tinh vi mô cực nhỏ, thanh mảnh lướt nhẹ như một nốt nhạc pha lê (*Crystal raindrop chime*). |
| **Legendary Species** | Ánh sáng đom đóm mờ, sắc hoa rực rỡ | **Harmonic Breeze:** Tiếng gió lướt qua mang theo âm hưởng hợp âm ấm áp, tiếng phấn hoa bay sột soạt dịu dàng. |
| **Mythic Species (Hoa Thần thoại)**| Hào quang nội tại `Bioluminescent pulse` | **Ethereal Harmonic:** Một lớp hòa âm vi mô huyền bí, êm dịu như tiếng đàn harp vọng lại từ xa xa mỗi khi nhân vật bước đến gần luống hoa. |

---

## 6. Dynamic Village Audio

Không gian thính giác của thị trấn mang tính động (*Dynamic Soundscape*), phản ứng nhạy bén theo mốc thời gian trong ngày, điều kiện thời tiết và tiến trình khôi phục của cộng đồng thông qua **Dynamic Village Audio**:

- **Sự chuyển dịch theo thời gian (`Chrono-acoustic Shift`):**
  - **Morning (Sáng):** Tiếng chổi quét sân của NPC bán hoa, tiếng chim sẻ râm ran, tiếng mở chốt cửa gỗ hiên nhà.
  - **Evening (Chiều hoàng hôn):** Tiếng gió chiều thổi qua thảm cỏ vàng, tiếng ấm trà sôi nhẹ trên bếp lửa, BGM chuyển sang các nốt guitar chậm rãi thư giãn.
  - **Night (Đêm tĩnh mịch):** BGM ngưng lại hoặc chỉ còn các nốt piano nỉ đơn lẻ, nhường chỗ hoàn toàn cho tiếng dế kêu êm đềm, tiếng ếch nhái vọng bên hồ và tiếng gió rít qua rèm cửa sổ.
- **Phản ứng Thời tiết (`Weather Acoustics`):**
  - **Rain (Mưa rào):** Tiếng mưa rơi trên mái ngói ấm nồng, tiếng mưa rơi trên luống đất thô (*Muddy splash*), tiếng mưa rơi trên mái kính nhà kính (*Greenhouse glass patter*) mang lại cảm giác an toàn, ấm áp tuyệt đối khi đứng bên trong nhà.
- **Sự kiện Lễ hội (`Festival Soundscape`):**
  - Quảng trường tràn ngập tiếng cười nói thầm thì êm dịu của đám đông cư dân (*Cozy crowd murmur*), tiếng đàn lute truyền thống và tiếng chuông gió thảo mộc vang vọng nhịp nhàng.

---

## 7. Memory Audio Standard

Để những khoảnh khắc mở khóa **Pressed Memories** chạm đến tầng sâu nhất của cảm xúc mà không cần bất kỳ lời thuyết minh dài dòng nào, **Memory Audio Standard (Quy chuẩn Âm thanh Ký ức)** áp dụng công thức tối giản tuyệt đối:

```text
Paper (Giấy da sột soạt) + Pencil (Bút chì phác thảo) + Soft Wind (Gió xa) + Distant Laugh (Tiếng cười ông xa xa)
```

- **Loại bỏ BGM hoành tráng:** Khi trang giấy **Pressed Memories** mở ra (`14_Pressed_Memories.md`), mọi nhạc nền hiện tại từ từ fade-out về `0`.
- **Thế giới của âm thanh vật lý ấm áp (*ASMR & Nostalgic Layers*):**
  - Tiếng lật trang giấy da dẻo dai (*Paper turn*), tiếng ngòi bút chì than cọ xát trên giấy phác thảo hình bông hoa năm xưa (*Pencil sketching*).
  - Lớp gió thổi xa xa qua vòm cây anh đào cổ thụ cạnh hiên nhà.
  - Tiếng cười hiền từ xa xăm hoặc tiếng bước chân lạo xạo trên cỏ của người ông ngoại thuở Mia/Okeydokey còn bé vọng về cực kỳ mờ dịu rồi tan vào thinh không.
- **Giá trị mang lại:** Sự tối giản mộc mạc này tạo nên sức nặng cảm xúc vô giá, khiến người chơi rưng rưng nhớ về những kỷ niệm êm đềm cùng gia đình và thiên nhiên.

---

## 8. Technical Standards

Bảng thông số kỹ thuật tiêu chuẩn bắt buộc cho toàn bộ tài nguyên Âm thanh khi thu âm, xử lý trên DAW và tích hợp vào audio engine:

| Audio Component | Format & Compression | Sample Rate / Bit Depth | Channel Configuration | Technical Specification & Looping Rules |
| --- | --- | --- | --- | --- |
| **BGM (Nhạc nền)** | OGG Vorbis / WAV (Source)| `44.1 kHz` / `16-bit` | Stereo (`2.0`) | Seamless Loop chuẩn xác tới từng sample (`No pop/click at loop point`), LUFS chuẩn `-14 to -16 LUFS` |
| **Ambient Loops** | OGG Vorbis | `44.1 kHz` / `16-bit` | Stereo (`2.0`) | Vòng lặp dài tối thiểu `60–120` giây để tránh cảm giác lặp lại nhàn chán (*Repetition fatigue*) |
| **UI SFX (Giao diện)**| WAV (Uncompressed) | `44.1 kHz` / `16-bit` | Mono hoặc Stereo | Độ trễ cực thấp (`Zero latency start`), tiếng lật sách, bấm nút nẹp gỗ, ruy-băng sột soạt êm dịu |
| **Footsteps (Bước chân)**| WAV (Uncompressed) | `44.1 kHz` / `16-bit` | Mono (Spatialized) | Tối thiểu `4–6` biến thể (`Variations`) cho mỗi bề mặt: Cỏ (`Grass`), Đất (`Dirt`), Đá (`Stone`), Gỗ (`Wood`) |
| **Flower SFX (Thực vật)**| WAV / OGG | `44.1 kHz` / `16-bit` | Stereo / 2D Panning | Tiếng chuông vi mô `Micro Chimes`, tiếng bụi phấn bay, âm lượng mềm không chói gắt (`No sharp high frequencies`) |
| **Weather (Thời tiết)**| OGG Vorbis Loops | `44.1 kHz` / `16-bit` | Stereo / Quad | Tách lớp độc lập: Mưa tổng thể (`Rain base`) + Mưa rơi mái ngói (`Roof`) + Mưa rơi mái kính (`Glasshouse`) |
| **NPC & Crowd** | OGG Vorbis | `44.1 kHz` / `16-bit` | Mono / 2D Panning | Tiếng cười nói mờ dịu (`Murmur`), tiếng chổi quét sân, tiếng ấm trà sôi có suy giảm âm theo khoảng cách (`Attenuation`) |
| **VFX & Action SFX**| WAV (Uncompressed) | `44.1 kHz` / `16-bit` | Stereo | Tiếng bình tưới nước gieo hạt mưa li ti, tiếng liềm cắt cỏ dại mềm mại êm ái |

---

## 9. Naming Convention

Toàn bộ file tài nguyên Audio phải tuân thủ nghiêm ngặt quy định **snake_case** theo cấu trúc phân loại prefix:  
`[audio_type]_[category]_[name]_[variant/state].[ext]`

Danh sách ví dụ tiêu chuẩn cho hệ thống âm thanh:
- **Background Music (BGM):**
  - `bgm_village_day_spring.ogg` *(Nhạc nền thị trấn ngày mùa xuân)*
  - `bgm_forest_deep_ancient.ogg` *(Nhạc nền khu rừng thạch tùng cổ đại)*
  - `bgm_journal_research_theme.ogg` *(Nhạc nền êm dịu khi lật mở Bloom Journal)*
- **Environmental Ambience (AMB):**
  - `amb_forest_wind_gentle_loop.ogg` *(Loop gió rừng nhẹ nhàng)*
  - `amb_water_river_stream_loop.ogg` *(Loop suối chảy róc rách)*
  - `amb_weather_rain_glasshouse_loop.ogg` *(Loop mưa rơi trên mái kính nhà kính)*
- **Sound Effects (SFX):**
  - `sfx_flower_bloom_perfect_chime.wav` *(Tiếng chuông vi mô hoa nở hoàn hảo)*
  - `sfx_tool_watering_can_pour_loop.wav` *(Tiếng tưới nước đều đặn)*
  - `sfx_footstep_grass_var01.wav` *(Tiếng bước chân trên cỏ biến thể 1)*
  - `sfx_memory_pencil_sketching.wav` *(Tiếng bút chì phác thảo hồi ức)*
- **UI Sound Effects (UI):**
  - `ui_page_turn_parchment_01.wav` *(Tiếng lật trang giấy da parchment)*
  - `ui_bookmark_ribbon_slide.wav` *(Tiếng cọ xát ruy-băng đánh dấu trang)*
  - `ui_button_wood_click_soft.wav` *(Tiếng nhấp nút nẹp gỗ sồi)*

---

## 10. Folder Convention

Toàn bộ tài nguyên âm thanh được tổ chức khoa học bên trong cấu trúc thư mục `Assets/Audio/`, phân chia minh bạch theo nhóm chức năng thính giác:

```text
Assets/
└── Audio/
    ├── BGM/
    │   ├── bgm_village_day_spring.ogg
    │   └── bgm_journal_research_theme.ogg
    ├── Ambient/
    │   ├── amb_forest_wind_gentle_loop.ogg
    │   └── amb_water_river_stream_loop.ogg
    ├── UI/
    │   ├── ui_page_turn_parchment_01.wav
    │   └── ui_button_wood_click_soft.wav
    ├── Weather/
    │   ├── amb_weather_rain_base_loop.ogg
    │   └── amb_weather_rain_glasshouse_loop.ogg
    ├── Flowers/
    │   ├── sfx_flower_bloom_perfect_chime.wav
    │   └── sfx_flower_pollen_drift.wav
    ├── Festival/
    │   └── amb_festival_crowd_cozy_loop.ogg
    └── NPC/
        ├── Footsteps/
        │   ├── sfx_footstep_grass_var01.wav
        │   └── sfx_footstep_stone_var01.wav
        └── Routines/
            └── sfx_npc_tea_kettle_boil.wav
```

---

## 11. Production Pipeline

Quy trình sản xuất chuẩn hóa cho một tài nguyên Âm thanh từ khâu nghiên cứu không gian đến khi hòa âm trên engine:

```text
┌─────────────────┐
│  1. Reference   │  Nghiên cứu âm thanh thiên nhiên ôn đới (Cottagecore foley,
│                 │  Victorian garden ambience) và xác định bảng cảm xúc
└────────┬────────┘
         ↓
┌─────────────────┐
│  2. Recording   │  Thu âm trực tiếp foley (tiếng giấy sột soạt, gỗ sồi, nước suối)
│                 │  hoặc tổng hợp nhạc cụ acoustic mộc mạc trên DAW
└────────┬────────┘
         ↓
┌─────────────────┐
│   3. Editing    │  Lọc nhiễu tần số cao chói tai (`De-harshing/EQ`), cắt nối
│                 │  điểm đầu cuối hoàn hảo cho các vòng lặp (`Seamless loop`)
└────────┬────────┘
         ↓
┌─────────────────┐
│    4. Review    │  Kiểm tra triết lý Silence Is Also Audio (đảm bảo không rườm
│                 │  rà) và độ cân bằng âm lượng so với tiếng bước chân
└────────┬────────┘
         ↓
┌─────────────────┐
│   5. Approved   │  Khóa file master, xuất chuẩn định dạng `OGG` (BGM/Amb) hoặc
│                 │  `WAV` uncompressed (UI/SFX)
└────────┬────────┘
         ↓
┌─────────────────┐
│6. Implementation│  Tích hợp vào Audio Engine (FMOD/Wwise/Engine native), thiết
│                 │  lập bán kính suy giảm âm thanh không gian 2D Panning
└────────┬────────┘
         ↓
┌─────────────────┐
│   7. Mixing     │  Hòa âm tổng thể (`Sidechain/Ducking`), tự động hạ BGM khi
│                 │  vào rừng hoặc khi mở trang thoại Pressed Memories
└────────┬────────┘
         ↓
┌─────────────────┐
│   8. Testing    │  Kiểm thử chạy thử dưới trời mưa lớn, đêm lễ hội và buổi
│                 │  sáng sớm không BGM để đánh giá cảm xúc thực tế
└────────┬────────┘
         ↓
┌─────────────────┐
│   9. In Game    │  Nghiệm thu trải nghiệm: không gian thính giác đang hít thở,
│                 │  mang lại sự bình yên vĩnh cửu cho tâm hồn người chơi
└─────────────────┘
```

---

## 12. Future Expansion & Advanced Soundscape Systems

Tài liệu quy chuẩn **Audio Assets (`08_Audio.md`)** được cấu trúc linh hoạt để sẵn sàng tiếp nhận các cơ chế âm thanh tương tác phức tạp trong tương lai:

- **Adaptive Music System (Hệ thống Âm nhạc Thích ứng):** BGM tự động thêm hoặc bớt các nhạc cụ (ví dụ: thêm tiếng sáo gỗ khi trời hửng nắng, thêm tiếng cello ấm khi hoàng hôn buông xuống) tùy theo nhịp sinh học của người chơi.
- **Dynamic 3D Audio & Reverb Zones (Vùng âm thanh không gian):** Hiệu ứng vang âm tự nhiên (*Reverb*) thay đổi tự động khi nhân vật bước từ quảng trường rộng lớn vào bên trong nhà kính mái vòm kính hoặc thư viện trần cao.
- **Accessibility Audio & Visual Indicators (Tiêu chuẩn hỗ trợ thính giác):** Tùy chọn hiển thị các biểu tượng sóng âm nhỏ trên màn hình dành cho người chơi khiếm thính để họ vẫn nhận biết được hướng gió, tiếng suối chảy hay hoa nở.
- **Photo Mode & Journal Soundscapes (Âm thanh chế độ Bách thảo):** Các bản nhạc êm dịu đặc biệt chỉ kích hoạt khi người chơi dành nhiều thời gian đọc và ngắm phác thảo trong Bloom Journal.
- **🌸 Botanical Orchestra System (Hệ thống Dàn nhạc Thực vật tự nhiên — Long-term Signature Soundscape Standard):**
  - **Định nghĩa đặc biệt:** Một cơ chế âm thanh cảm xúc đỉnh cao mang tính "chữ ký thính giác" (*Signature Audio Feature*) độc quyền của **Plant Tales** — kết nối trực tiếp với **Bloom Resonance System (`07_Animation.md`)**. Khi người chơi chăm sóc và nuôi dưỡng khu vườn, **toàn bộ khu vườn sẽ hóa thân thành một dàn nhạc tự nhiên kỳ diệu (*A Botanical Orchestra*)**.
  - **Cơ chế hoạt động:**
    - **Mỗi loài hoa là một "Nhạc cụ tự nhiên" vi mô:** Mỗi nhóm hoa trồng trên luống sẽ đóng góp một âm sắc cực kỳ mảnh nhẹ vào lớp âm thanh môi trường (*Environmental Audio Layer*):
      - *Hoa Hồng/Tulip:* Đóng góp tiếng rách lá sột soạt trầm ấm đầm nhịp.
      - *Hoa Lavender/Hương thảo:* Đóng góp tiếng gió lướt qua các nhành nhỏ tạo âm vút thanh mảnh.
      - *Hoa Perfect Bloom/Legendary:* Đóng góp tiếng chuông gió thủy tinh vi mô nhấp nháy ngẫu nhiên theo nhịp gió lượn sóng.
    - **Sự hòa âm theo độ đa dạng sinh học (`Biodiversity Audio Richness`):** Khu vườn càng đa dạng nhiều loài hoa đan xen, không gian thính giác càng trở nên phong phú, đầy đặn và đa tầng hơn. Khi khu vườn đạt đến sự cân bằng sinh thái tuyệt mỹ, các "nhạc cụ" tự nhiên này sẽ tự động hòa quyện cùng tiếng ong hót, tiếng bướm vỗ cánh và nốt nhạc BGM acoustic tạo thành một bản giao hưởng êm đềm bất tận.
  - **Giá trị cốt lõi:** Cơ chế dàn nhạc thực vật này **hoàn toàn không ảnh hưởng đến chỉ số gameplay hay điểm số**, mà là một món quà cảm xúc vô giá, là lời tri ân thính giác ngọt ngào nhất dành cho những người chơi đã đặt trọn trái tim và tình yêu vào hành trình nuôi dưỡng khu vườn của mình.
