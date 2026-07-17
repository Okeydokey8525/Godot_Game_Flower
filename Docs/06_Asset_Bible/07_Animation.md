# Animation Assets & Visual Motion Standards

**Tài liệu quy chuẩn chuyển động, triết lý nhịp thở thế giới và hiệu ứng thị giác cho dự án Plant Tales (Animation Philosophy & Visual Motion Standards Document).**

---

## 1. Purpose

Tài liệu **Animation Assets & Visual Motion Standards (`07_Animation.md`)** đóng vai trò là hiến pháp tối cao xác lập triết lý chuyển động, thông số khung hình và nguyên tắc hiệu ứng VFX cho toàn bộ tài nguyên trong **Plant Tales**.

Trong các tựa game thuộc thể loại Cozy, người chơi **không ghi nhớ những tấm texture tĩnh độ phân giải lớn**, mà thứ in sâu vào tâm trí họ chính là những khoảnh khắc chuyển động: ngọn gió thổi qua làm luống hoa lavender rung rinh, cánh hoa bay nhẹ khi thu hoạch, nhân vật cúi người ngửi hương hoa hay ánh hoàng hôn lấp lánh trên mặt hồ tĩnh lặng. Khẳng định triết lý cốt lõi:
- **Animation phải khiến thế giới trông như đang hít thở (*Make the world breathe*):** Chuyển động trong game không sinh ra chỉ để "cho có chạy hình" hay làm phô trương kỹ thuật. Mục tiêu tối thượng của animation là thổi sinh khí, nhịp điệu và cảm giác thư thái êm đềm vào từng nhành cây ngọn cỏ.
- **Tách biệt với Gameplay Logic:** Tài liệu này chuyên tâm thiết lập **triết lý chuyển động (*Philosophy*) và quy chuẩn kỹ thuật cho asset animation/VFX**, không phải tài liệu lập trình gameplay hay chỉ đơn thuần là một danh sách kiểm kê tên animation vô hồn.

---

## 2. Living Animation Standard

**Living Animation Standard (Quy chuẩn Chuyển động Sống động & Nhịp thở Thế giới)** quy định rằng không một thành phần môi trường quan trọng nào trong **Plant Tales** bị đông cứng tuyệt đối trong trạng thái tĩnh đơ `0` frame:

- **Nguyên tắc chuyển động vi mô êm dịu (*Micro-motion Loop*):**
  - **Flowers (Hoa trên luống):** Nhẹ nhàng rung rinh lượn sóng theo nhịp gió thổi (`4–8` frames loop), tạo cảm giác luống hoa mềm mại như một tấm thảm sống.
  - **Leaves & Trees (Tán lá & Cây cổ thụ):** Tán lá cây trên lớp `Roof Layer` rung nhẹ mép lá, thỉnh thoảng thả rơi 1–2 chiếc lá rụng chầm chậm xuống đất.
  - **Grass (Thảm cỏ gió thổi):** Cỏ dại và ngọn cỏ cao nhấp nhô lượn sóng liên tục theo chu kỳ gió môi trường.
  - **Water (Mặt nước & Suối):** Gợn sóng lấp lánh phản chiếu ánh sáng mặt trời (*Water ripples*), bọt nước vỗ nhẹ vào bờ cát ẩm.
  - **Smoke & Lanterns (Khói ấm & Đèn lồng hiên):** Làn khói mỏng mảnh bay lượn lờ từ ống khói nhà kính, chiếc đèn lồng trước hiên tiệm hoa lắc lư cực nhẹ tỏa ánh sáng vàng cam hắt nhịp nhàng.
  - **NPC Idle (Cư dân đứng yên):** Khi NPC đứng chờ, cơ thể họ có nhịp thở lên xuống đều đặn, đôi khi chớp mắt, đổi trọng tâm chân hoặc vươn vai thư thái.

---

## 3. Secondary Motion Standard

**Secondary Motion Standard (Quy chuẩn Chuyển động Phụ trợ)** là tiêu chuẩn nâng tầm chất lượng hoạt hình pixel của **Plant Tales** vượt lên trên mặt bằng chung của các tựa game indie: khi một nhân vật (Mia, Okeydokey hoặc NPC) di chuyển, không chỉ có đôi chân chạy trên đất, mà toàn bộ các chi tiết phụ trợ trên cơ thể cũng phải phản ứng theo quán tính và trọng lực:

```text
Chuyển động chính (Chân chạy/Bước đi) ➔ Quán tính kéo theo ➔ Chuyển động phụ (Tóc/Váy/Túi/Trâm cài)
```

- **Hair & Clothes (Mái tóc & Trang phục):** Tóc đuôi ngựa hoặc dải khăn choàng cổ bay bồng bềnh về phía sau khi chạy, tà váy hoặc áo khoác dập dờn theo từng bước chân.
- **Bag & Accessories (Túi đeo chéo & Phụ kiện nhỏ):** Chiếc túi vải lanh đeo chéo bên hông nảy nhẹ lên xuống theo nhịp chạy; thẻ đánh dấu trang ruy-băng đỏ dắt ở túi áo sột soạt bung nhẹ; chiếc trâm cài tóc hình hoa (*Flower hairpin*) lấp lánh rung theo nhịp bước.
- **Giá trị mang lại:** Tạo cho nhân vật một cảm giác về **trọng lượng vật lý thực tế (*Physical Weight & Charm*)**, khiến người chơi cảm thấy nhân vật có sự linh hoạt, mềm mại và đáng yêu vô cùng.

---

## 4. Botanical Motion Standard

Đây là "đặc sản" chuyển động độc tôn chỉ có tại **Plant Tales** — **Botanical Motion Standard (Quy chuẩn Chuyển động Thực vật học theo Đặc tính Loài)**. Nghiêm cấm tuyệt đối việc sử dụng chung 1 bộ animation lắc lư dập khuôn duy nhất (`Copy-paste sway`) cho tất cả các loài hoa trong vườn:

| Loài / Nhóm hoa | Đặc điểm giải phẫu tự nhiên | Quy tắc chuyển động (*Botanical Motion Profile*) |
| --- | --- | --- |
| **Tulip (Hoa Tulip)** | Thân thảo thẳng, cánh hoa khép dày cứng cáp | **Sway cực nhẹ:** Thân cây đứng vững, chỉ rùng mình lắc nhẹ phần bông `1–2` pixels khi có gió. |
| **Lavender (Oải hương)**| Thân mảnh, cụm hoa nhỏ dài mềm mại | **High Sway / Linh hoạt cao:** Lắc lư biên độ lớn, lượn sóng mềm mại như dải lụa tím mỗi khi gió thổi qua. |
| **Sunflower (Hướng dương)**| Thân to cao, bông hoa nặng, có tập tính hướng dương | **Slow Turn / Xoay chậm:** Hầu như không lắc theo gió nhẹ vì bông nặng, nhưng thân bông tự động hơi nghiêng quay nhẹ theo góc hướng của mặt trời từ sáng đến chiều. |
| **Rose (Hoa Hồng)** | Thân gỗ nhỏ gai góc, lá cứng, bông nhiều lớp chập | **Sturdy / Vững chãi:** Thân kiên định đứng vững vàng, chỉ có các chồi lá dưới cùng nhẹ nhàng nhấp nhô theo gió. |
| **Mythic Flowers (Hoa Thần thoại)**| Cấu trúc pha lê, gân phát sáng, sinh trưởng bí ẩn | **Unique Subtle Anim:** Có animation nhịp thở phát sáng vi mô tự nội tại (*Bioluminescent pulse*), kèm vài hạt phấn hoa bay lơ lửng ngay cả khi không có gió. |

---

## 5. Quiet Effects Philosophy

Toàn bộ hệ thống hiệu ứng hình ảnh (*Visual Effects — VFX*) trong **Plant Tales** phải tuyệt đối tuân thủ **Quiet Effects Philosophy (Triết lý Hiệu ứng Tĩnh lặng & Thanh nhã)**, từ chối sự phô trương ồn ào để nhường chỗ cho vẻ đẹp êm đềm:

- **Nghiêm cấm hiệu ứng cháy nổ bão hòa (`No Aggressive Particle Explosions`):**
  - Khi thu hoạch thành công một bông hoa **Perfect Bloom**, nghiêm cấm việc bắn ra hàng trăm tia sáng chớp nháy đì đùng hay vệt chớp chói lóa kín màn hình.
- **Bộ hiệu ứng tiêu chuẩn êm dịu (*Cozy VFX Palette*):**
  - **Soft Glow (Hào quang mờ dịu):** Lớp ánh sáng tỏa mờ xung quanh nụ hoa hoàn hảo hay bệ đá cúng tế, có độ bão hòa thấp và kết xuất Alpha mượt mà.
  - **Micro Sparkles (Hạt bụi sáng li ti):** Vài `3–5` hạt sáng vàng kem li ti nảy nhẹ từ bông hoa rồi lơ lửng tan vào không khí.
  - **Floating Petals & Gentle Dust (Cánh hoa bay & Bụi phấn dịu):** Khi thu hoạch, `2–3` cánh hoa mỏng mảnh bung nhẹ xoay tròn theo làn gió rồi từ từ đáp xuống nền đất rêu.
  - **Soft Wind (Gió lướt mờ):** Các vệt gió bay qua sân vườn được vẽ bằng các đường cong trắng mờ bán trong suốt lướt qua ngọn cỏ cực kỳ thi thoảng.

---

## 6. Idle Storytelling Standard

Để nhân vật chính không trở thành một cái xác đứng đơ mỗi khi người chơi buông tay chuột/bàn phím để suy ngẫm, **Idle Storytelling Standard (Quy chuẩn Kể chuyện qua Chuyển động Chờ)** quy định chuỗi chuyển tiếp tự động sang các hành vi chờ giàu cảm xúc sau `10–15` giây đứng yên:

- **Quan sát & Ngửi hoa (*Botanical Observation*):** Nhân vật tự động cúi thấp người xuống sát luống hoa gần nhất, nhẹ nhàng đưa tay chạm vào cánh hoa hoặc hít sâu hương hoa thơm ngát với nụ cười hài lòng.
- **Lật sổ tay Bloom Journal (*Journal Interaction*):** Nhân vật rút cuốn sổ **Bloom Journal** đeo bên hông ra, lật vài trang kiểm tra ghi chú rồi cẩn thận vuốt thẳng lại dải ruy-băng đánh dấu trang (*Adjusting bookmark*).
- **Chỉnh sửa phụ kiện & Ngắm trời (*Cozy Relaxation*):**
  - *Mia:* Chỉnh lại chiếc trâm cài tóc hoa hồng hoặc vuốt gọn nếp váy lanh mộc mạc.
  - *Okeydokey:* Chỉnh lại dây đeo chiếc túi da Satchel nặng hạt giống, phủi bụi bìa sách hoặc lấy kính lúp ra ngắm tia nắng mặt trời chiếu qua kẽ lá.
- **Ngồi nghỉ ngơi tự do:** Nếu đứng gần bãi cỏ non hoặc bờ suối lâu, nhân vật có thể tự động ngồi xuống gối cằm ngắm nhìn bướm bay qua lại.

---

## 7. Weather Animation Standard

Hệ thống hoạt hình trong game là một thực thể sống có sự phản ứng nhạy bén với thay đổi của bầu trời thông qua **Weather Animation Standard (Quy chuẩn Chuyển động phản ứng Thời tiết)**, kết nối chuỗi đa hệ thống:

```text
Tilesets (Môi trường) ➔ Flowers (Thực vật) ➔ Animation (Chuyển động) ➔ Audio (Âm thanh)
```

- **Sunny (Trời nắng đẹp):** Các loài hoa ngẩng cao đầu rực rỡ, tán cây lắc nhẹ thư thái, bướm và ong bay lượn lờ với tốc độ chậm rãi êm đềm.
- **Rain (Trời mưa rào mát lạnh):**
  - Các bông hoa nặng trĩu vì những giọt nước mưa đọng trên cánh, độ lắc lư chậm lại và hơi trĩu gập đầu xuống khoảng `2–3` pixels (*Heavy water-droop animation*).
  - Tán cây rùng mình bắn ra những giọt nước li ti khi gió thổi qua.
- **Wind / Storm (Gió lớn / Mùa giông bão):**
  - Toàn bộ thảm cỏ và luống hoa nghiêng rạp đồng loạt về một phía theo hướng gió thổi (`Dynamic wind angle correlation`).
  - Tán lá cây lắc mạnh đung đưa liên hồi, lá khô bay xoáy cuốn theo chiều gió dọc các lối đi quảng trường.

---

## 8. Technical Standards

Bảng thông số kỹ thuật tiêu chuẩn bắt buộc cho toàn bộ tài nguyên Animation và VFX khi làm việc trên Aseprite và tích hợp vào engine:

| Asset Component | Target Frame Rate | Frame Count / Loop Length | Pivot & Origin Alignment | Technical Specification & Notes |
| --- | --- | --- | --- | --- |
| **Character Walk/Run**| `10–12` FPS | `6–8` Frames per direction | Bottom Center `(X:16, Y:48)` | Chuẩn 4 hướng `(North, South, East, West)`, tích hợp Secondary Motion cho tóc/túi chéo |
| **Character Idle Loop**| `6–8` FPS | `4–6` Frames (Breathing) | Bottom Center `(X:16, Y:48)` | Nhịp thở chớp mắt nhẹ, chuyển tiếp mượt mà sang `Idle Storytelling` sau `15` giây |
| **Flower Wind Sway** | `6–8` FPS | `4–8` Frames Loop | Bottom Center Base `(X:16, Y:32)`| Gốc rễ sát đất giữ nguyên `100%` `(No foot sliding)`, chỉ biến dạng góc uốn ở 2/3 phần trên thân |
| **NPC Daily Routines**| `8–10` FPS | `4–8` Frames per action | Bottom Center `(X:16, Y:48)` | Animation thao tác nghề đặc thù: đọc sách lật trang, cầm bình tưới nghiêng tay gieo nước |
| **Water Ripples & Edge**| `6–8` FPS | `6–8` Frames Loop | Tile Grid Alignment `32x32` | Sóng lượn liên tục mềm mại, tiếp giáp bọt nước vỗ bờ không bị khựng chu kỳ (`Seamless loop`) |
| **Tree & Foliage Sway**| `6–8` FPS | `6–8` Frames Loop | Root Anchor `(X: center, Y: bottom)`| Tán lá trên cao (`Roof Layer`) rùng mình nhẹ theo gió, bóng đổ nghiêng 45 độ lắc theo tương ứng |
| **UI Micro-animations**| `12–15` FPS | `3–5` Frames (Hover/Click) | Component Center / 9-Slice | Nút bấm nhô lên `1-2` px, ruy-băng thông báo lướt mượt vào từ cạnh màn hình (`Ease-out curve`) |
| **Particles & VFX** | `12–15` FPS | `6–10` Frames One-shot/Loop| Emission Center point | Hạt phấn `Micro Sparkles` nảy nhẹ, cánh hoa thu hoạch lốc xoáy nhẹ rồi tan Alpha 100% về `0%` |

---

## 9. Visual Style

Ngôn ngữ nghệ thuật của hoạt hình và hiệu ứng phải bảo toàn tuyệt đối 6 từ khóa thẩm mỹ của **Plant Tales**:
- **Cozy & Organic (Ấm cúng & Hữu cơ):** Chuyển động có sự co giãn mềm mại tự nhiên (*Squish & Stretch nhẹ*), tuyệt đối không cứng đơ như robot cơ khí.
- **Natural & Elegant (Tự nhiên & Thanh lịch):** Nhịp điệu chậm rãi vừa phải, phản ánh đúng nhịp sinh học của một thị trấn làm vườn thư thả, không gấp gáp hối hả.
- **Subtle & Responsive (Tinh tế & Nhạy bén):** Hiệu ứng tuy nhỏ bén gọn nhưng lập tức phản hồi chính xác mỗi khi người chơi chạm vào luống hoa hay bước chân qua bãi cỏ non.

---

## 10. Naming Convention

Toàn bộ file tài nguyên Animation và VFX phải tuân thủ nghiêm ngặt quy định **snake_case** theo phân cấp loại hình:  
`[anim/vfx]_[category]_[name]_[action/variant].[ext]`

Danh sách ví dụ tiêu chuẩn cho hệ thống hoạt hình:
- **Character & NPC Animations:**
  - `anim_player_mia_walk_south.png` *(Sheet bước đi hướng Nam của Mia)*
  - `anim_player_mia_idle_journal.png` *(Sheet idle lật sổ Bloom Journal)*
  - `anim_npc_florist_water_flower.png` *(Sheet NPC tưới hoa hiên nhà)*
- **Botanical & Environment Motions:**
  - `anim_flower_tulip_sway_wind.png` *(Sheet lắc nhẹ gió của hoa Tulip)*
  - `anim_flower_lavender_sway_wind.png` *(Sheet lượn sóng gió của Lavender)*
  - `anim_tree_oak_sway_canopy.png` *(Sheet tán cây sồi rùng mình gió)*
  - `anim_water_river_ripple_loop.png` *(Sheet gợn sóng suối tuần hoàn)*
- **Visual Effects (VFX & Particles):**
  - `vfx_harvest_floating_petals.png` *(Sheet cánh hoa bay khi thu hoạch)*
  - `vfx_bloom_micro_sparkles.png` *(Sheet hạt phấn sáng li ti)*
  - `vfx_weather_rain_droop_splash.png` *(Sheet giọt mưa bắn trên lá)*

---

## 11. Production Pipeline

Quy trình sản xuất chuẩn hóa cho một tài nguyên Animation từ khâu nghiên cứu nhịp điệu đến khi kiểm thử trên engine:

```text
┌─────────────────┐
│  1. Reference   │  Nghiên cứu video thực tế gió thổi qua thảm hoa ngoài trời và
│                 │  chuyển động hoạt hình pixel kinh điển (Ghibli/Cozy indie)
└────────┬────────┘
         ↓
┌─────────────────┐
│  2. Key Pose    │  Vẽ các khung hình chính (`Key Poses`), xác định độ cong của
│                 │  thân hoa và biên độ bay của tóc/túi đeo chéo (`Secondary`)
└────────┬────────┘
         ↓
┌─────────────────┐
│    3. Review    │  Kiểm tra triết lý Quiet Effects (đảm bảo không lóa mắt) và
│                 │  đánh giá độ mượt mà nhịp thở khi ghép vòng lặp (`Loop check`)
└────────┬────────┘
         ↓
┌─────────────────┐
│   4. Approved   │  Khóa Key Pose, vẽ các khung hình trung gian (`In-betweens`)
│                 │  chốt thông số FPS chuẩn trên Aseprite
└────────┬────────┘
         ↓
    ┌────┴───────────────────────────┐
    ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│  5a. Animation  │              │     5b. VFX     │
│ Hoàn thiện sheet│              │ Hoàn thiện sheet│
│ Sprite động cho │              │ Alpha mượt cho  │
│ nhân vật/hoa    │              │ phấn hoa/tia sáng│
└────────┬────────┘              └────────┬────────┘
         │                                │
         └───────────────┬────────────────┘
                         ▼
┌──────────────────────────────────────────────────┐
│                    6. Engine                     │
│  Tích hợp sheet vào Engine, thiết lập gốc Pivot  │
│  sát đất `(No foot sliding/No root displacement)`│
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    7. Testing                    │
│  Kiểm thử dưới tác động thời tiết mưa/gió, xác   │
│  minh độ đồng bộ với âm thanh sột soạt lá (`Audio`)│
└────────────────────────┬─────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────┐
│                    8. In Game                    │
│  Nghiệm thu trải nghiệm thực tế: thế giới đang   │
│  hít thở êm đềm, thư thái đúng chất "Cozy Garden"│
└──────────────────────────────────────────────────┘
```

---

## 12. Future Expansion & Advanced Motion Mechanics

Tài liệu quy chuẩn **Animation Assets (`07_Animation.md`)** sở hữu kiến trúc mở sẵn sàng tích hợp các cơ chế chuyển động vĩ mô phức tạp trong tương lai:

- **Dynamic Wind Shader Integration (Tích hợp Shader Gió động):** Cơ chế điều khiển biên độ và tốc độ rung lắc của cây cối/hoa cỏ trực tiếp bằng thông số gió từ Engine Shader toàn cục.
- **Seasonal & Festival Performance Animations (Chuyển động Lễ hội & Mùa vụ):** Bộ animation đặc biệt cho các điệu nhảy vòng tròn đêm Lễ hội Hoa hoặc thao tác cào lá phong mùa thu.
- **Animal & Insect Behaviors (Hệ sinh thái động vật nhỏ):** Animation bướm đậu lên nhụy hoa, ong hút mật rung cánh hay chú mèo nhỏ cuộn tròn ngủ dưới hiên nhà kính.
- **Photo Mode Dynamic Poses (Tạo dáng Chụp ảnh):** Danh sách các dáng ngồi ngắm hoa đặc biệt cho phép người chơi chọn lựa khi mở chế độ chụp ảnh Bloom Journal.
- **💡 Bloom Resonance System (Hệ thống Cộng hưởng Hoa nở — Long-term Ecosystem Synchronization Standard):**
  - **Định nghĩa đặc biệt:** Một cơ chế chuyển động và cộng hưởng môi trường đỉnh cao mang tính "chữ ký" (*Signature feature*) của **Plant Tales** — khi nhiều bông hoa cùng nở rực rỡ trong cùng một khu vực vườn, chúng không chỉ đứng độc lập mà sẽ tạo ra **một mạng lưới cộng hưởng nhịp thở chung (*Collective Bloom Resonance*)**.
  - **Cơ chế hoạt động:**
    - **Sự đồng bộ nhịp gió (*Synchronized Swaying*):** Cả một luống hoa lớn sẽ đung đưa theo cùng một nhịp sóng gió uyển chuyển như một dàn hợp xướng tự nhiên.
    - **Lưu chuyển phấn hoa (*Inter-flower Pollen Drift*):** Những làn phấn hoa sáng li ti bay dịu nhẹ lơ lửng qua lại kết nối giữa các bông hoa liền kề.
    - **Hòa quyện ánh sáng & Âm thanh (*Glow & Audio Blending*):** Ánh sáng hào quang của các giống hoa Mythic/Legendary hòa quyện mượt mà vào nhau, đồng thời mật độ hoa càng dày thì tiếng ong bướm bay lượn và âm thanh chuông gió tự nhiên càng trở nên phong phú, êm dịu hơn.
  - **Giá trị cốt lõi:** Cơ chế cộng hưởng này là sự kết tinh tinh hoa giữa `Animation ➔ Audio ➔ Flower System ➔ Weather System`, biến khu vườn của người chơi thành một **thực thể sống động có linh hồn chung**, mang lại sự xúc động sâu sắc và cảm giác thư giãn tuyệt đối đúng với mục tiêu tối thượng của dự án.
