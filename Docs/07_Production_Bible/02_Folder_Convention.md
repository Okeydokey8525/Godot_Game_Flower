# Folder Convention & Production Pipeline Standard

**Tài liệu quy chuẩn cấu trúc thư mục toàn cục, quy trình nạp tài nguyên và quản lý vòng đời tài sản cho dự án Plant Tales (Folder Convention & Production Pipeline Standard Document).**

---

## 1. Folder Philosophy

Tài liệu **Folder Convention (`02_Folder_Convention.md`)** được ban hành như một đạo luật tối cao quản lý toàn bộ hệ thống tệp tin và cấu trúc lưu trữ của **Plant Tales**, được biên soạn từ góc nhìn quản trị kỹ thuật của **Technical Director + Lead Programmer**.

Trong một dự án phát triển game có sự tham gia liên tục của đa hệ AI Agent (*Codex, Antigravity, Claude, Copilot*) cùng các lập trình viên con người, cây thư mục không đơn thuần là nơi "vứt file cho gọn". Khẳng định triết lý cốt lõi:

> **"Cấu trúc thư mục chính là một phần của kiến trúc phần mềm (`Folders are part of the architecture`). Toàn bộ dự án Plant Tales chỉ tồn tại đúng một cấu trúc thư mục duy nhất và bất biến."**

Hệ thống quản lý thư mục tuân thủ nghiêm ngặt 6 hiến pháp:

```text
• Folders are part of the architecture.   (Thư mục là bộ xương của kiến trúc code & asset)
• Folder names are immutable.             (Tên các thư mục gốc là bất biến, cấm tự ý đổi)
• Authoritative location only.            (Mỗi asset chỉ có đúng 1 nơi lưu trữ duy nhất)
• No duplicate storage.                   (Nghiêm cấm lưu trữ trùng lặp/copy nhiều nơi)
• No temporary folders in production.     (Cấm tạo thư mục rác temp/backup trong production)
• AI must never create new root folders.  (AI tuyệt đối không bao giờ được tạo thư mục gốc mới)
```

---

## 2. Root Directory Rules

Toàn bộ vũ trụ dự án **Plant Tales** được khóa độc tôn bên trong đúng **6 thư mục gốc (`6 Root Directories`)**. Không bất kỳ lập trình viên hay AI Agent nào có quyền sinh ra một thư mục ngang hàng thứ 7.

```text
Plant Tales/
├── Docs/          (Kho lưu trữ toàn bộ tài liệu thiết kế, quy chuẩn kỹ thuật & hiến pháp)
├── Assets/        (Kho tài nguyên sản xuất thực tế: hình ảnh, âm thanh, 3D, VFX đã hoàn thiện)
├── Prompts/       (Kho lệnh AI prompts chuẩn hóa cho tạo hình, lập trình và truyền thông)
├── Prototype/     (Khu vực thử nghiệm nháp, GDevelop sandbox nháp trước khi đưa vào core)
├── Source/        (Kho mã nguồn chính thức, project GDevelop 5 production & logic behaviors)
└── References/    (Tài liệu tham khảo ngoại vi, moodboards, nghiên cứu bách thảo PDF/Link)
```

### Danh Sách Thư Mục Gốc Bị Cấm Tuyệt Đối (`Strictly Prohibited Root Folders`)
❌ **AI và lập trình viên nghiêm cấm tự ý tạo ra các thư mục rác tại Root như:**
```text
New Assets/   |   Assets2/   |   Prototype_New/   |   SourceFinal/   |   Code/   |   Resources/
```
*Phán quyết kỹ thuật:* Bất kỳ tệp tin nào nằm ngoài 6 thư mục gốc chuẩn xác trên sẽ bị hệ thống tự động coi là tệp tin rác không hợp lệ và bị từ chối tích hợp vào Engine.

---

## 3. Documentation Convention (`Docs/`)

Thư mục `Docs/` là trung tâm thần kinh lưu trữ toàn bộ bách khoa toàn thư của dự án, được chia thành 8 phân hệ đánh số thứ tự minh bạch theo luồng làm việc (*Number-prefixed Sequential Pipeline*):

```text
Docs/
├── 01_Game_Design/          (Ý tưởng ban đầu, Game Overview & Game Design Document)
├── 02_Design_Bible/         (Quy chuẩn cốt truyện, Vision Bible, Art/Character/Flower Bible)
├── 03_Concepts/             (Kho lưu trữ bản vẽ phác thảo thô ban đầu của họa sĩ)
├── 04_Research/             (Nghiên cứu bách thảo thực tế, tài liệu cozy games, pixel art)
├── 05_Production/           (Quản lý tiến độ, Roadmap, Todo, Asset Checklist & Changelog)
├── 06_Asset_Bible/          (Hiến pháp quy chuẩn tài nguyên `00–08`: Nhìn, Cảm nhận & Âm thanh)
├── 07_Production_Bible/     (Hiến pháp kỹ thuật lập trình `00–09`: Kiến trúc, Code & AI Workflow)
└── 08_Game_Rules_Bible/     (Hiến pháp luật bất biến tối cao giữ bản sắc Cozy của dự án)
```

❌ **Các thư mục tài liệu bị cấm tự tạo (*Forbidden Docs Subdirectories*):**  
`Game Design/`, `Production Docs/`, `Notes/`, `Random/`, `Drafts/`.

---

## 4. Assets Convention (`Assets/`)

Thư mục `Assets/` là kho tài nguyên production chuẩn bị nạp trực tiếp vào Engine GDevelop 5. Thư mục này chỉ chứa các file tài nguyên đã được nghiệm thu (*Approved/Production Ready*), được tổ chức độc tôn thành 10 nhóm tài nguyên:

```text
Assets/
├── Characters/     (Sprite sheets di chuyển, Portrait chân dung nhân vật chính Mia, Okeydokey)
├── Flowers/        (Sprite thực vật, hoa trên đất, Bloom Plate, hạt giống và tiêu bản)
├── Buildings/      (Tòa nhà, nhà kính kính mờ, nội thất và các điểm ký ức Memory Places)
├── Tilesets/       (Lưới nền tảng thế giới: đất, rêu, nước suối, cây cối Roof Layer)
├── Props/          (Vật thể nhỏ ngoài trời: hàng rào, ghế đá, đèn lồng, chậu hoa hiên)
├── UI/             (Giao diện Botanical UI: HUD, sổ tay Bloom Journal, ngăn túi Satchel, font)
├── Icons/          (Icon chuẩn `32x32`: hoa, nông cụ, hạt giống, trạng thái lịch trình)
├── Audio/          (Hệ sinh thái thính giác: BGM, Ambient loops, SFX vi âm thực vật, Footsteps)
├── Fonts/          (Phông chữ tự nhiên, chữ có chân cổ điển, chữ viết tay sepia `.ttf/.woff2`)
└── VFX/            (Hiệu ứng tĩnh lặng: Soft Glow, hạt phấn `Micro Sparkles`, lá rụng)
```

❌ **Các thư mục asset bị cấm tự tạo (*Forbidden Assets Subdirectories*):**  
`Flower Assets/`, `Characters_New/`, `NPC Assets/`, `Sprites/`, `Audio_Final/`.

---

## 5. Internal Asset Structure

Bên trong các phân mục tài nguyên cụ thể (chẳng hạn như từng loài hoa hay từng nhân vật), cấu trúc thư mục con nội bộ (*Internal Subfolder Chain*) phải tuân thủ chuẩn mô-đun hóa 5 ngăn khép kín:

```text
Assets/Flowers/[Category]/[flower_id]/
                           ├── Concept/    (Bản vẽ concept Turnaround & phác thảo ý tưởng `.png`)
                           ├── Sprites/    (Sheet sprite trên đất, hoa lắc theo gió `.png`)
                           ├── Icons/      (Icon túi đồ & icon trang bách thảo `32x32` `.png`)
                           ├── Journal/    (Hành ảnh tiêu bản ép & trang sổ bách thảo `.png`)
                           └── Animation/  (File nguồn animation Aseprite `.aseprite` & metadata)
```

- **Ví dụ chuẩn xác minh bạch cho Hoa Hồng Common Rose:**
  ```text
  Assets/Flowers/Rose/flower_rose_common/
                      ├── Concept/flower_rose_common_concept.png
                      ├── Sprites/flower_rose_common_idle.png
                      ├── Icons/icon_flower_rose_common.png
                      ├── Journal/journal_flower_rose_common_plate.png
                      └── Animation/flower_rose_common.aseprite
  ```
❌ **Nghiêm cấm tạo thư mục biến thể tên ngẫu hứng như:** `Rose_New/`, `Rose_Final/`, `Rose_v2/`, `Rose_Copy/`. Mọi chỉnh sửa phải ghi đè lên file chính thức hoặc quản lý bằng Git.

---

## 6. Prompt Convention (`Prompts/`)

Để đảm bảo chất lượng tài nguyên tạo bằng AI luôn giữ đúng phong cách *Botanical & Handcrafted Cottagecore* đồng nhất bất kể AI nào thực hiện (*Midjourney, DALL-E 3, Stable Diffusion, Gemini*), thư mục `Prompts/` phải phân loại theo đúng domain của dự án:

```text
Prompts/
├── Characters/     (Prompts tạo hình Turnaround, Portrait góc sáng 45 độ, trang phục lanh)
├── Flowers/        (Prompts tạo hình Bloom Plate, chuỗi phát triển thực vật, hoa ép sepia)
├── NPC/            (Prompts tạo hình cư dân, trang phục nghề bách thảo, phụ kiện làm vườn)
├── Buildings/      (Prompts tạo hình kiến trúc gỗ sồi, mái ngói rêu phong, nhà kính kính mờ)
├── Tilesets/       (Prompts tạo hình lưới đất mùn, thảm cỏ gió thổi, bờ suối lấp lánh)
├── UI/             (Prompts tạo hình giấy da parchment nhám texture, nẹp gỗ, ruy-băng lụa)
├── Animation/      (Prompts/chỉ dẫn cắt frame động, Secondary motion tóc/túi đeo chéo)
├── Music/          (Prompts mô tả cấu trúc BGM acoustic, cảm xúc thính giác cho AI Suno/Udio)
└── Marketing/      (Prompts tạo hình ảnh bìa store, trailer storyboard, bưu thiếp quảng bá)
```

❌ **Các thư mục prompt bị cấm tự tạo (*Forbidden Prompt Subdirectories*):**  
`Prompt New/`, `Midjourney/`, `Gemini/`, `ChatGPT_prompts/`, `Temp_Prompts/`.

---

## 7. Source Code Convention (`Source/`)

Thư mục `Source/` là "thánh địa" dành cho lập trình viên Core và **Codex AI**. Nơi đây lưu trữ project GDevelop 5 chính thức (*GDevelop Project File `.json`*) và toàn bộ mạng lưới logic, hệ thống, cảnh chơi. Cấu trúc nội bộ phải chia cắt rõ ràng theo Module Architecture (`01_Project_Architecture.md`):

```text
Source/
├── Systems/        (Các hệ thống logic core: FlowerSystem, NPCSystem, WeatherSystem, AudioSystem)
├── Managers/       (Đúng 4 Global Singletons: GameManager, AudioManager, SaveManager, SceneManager)
├── Scenes/         (Đúng 7 Scene tiêu chuẩn: Boot, MainMenu, Loading, Village, House, Festival, Credits)
├── UI/             (Behaviors & Logic điều khiển giao diện: JournalController, SatchelController)
├── Objects/        (Định nghĩa đối tượng GDevelop & Prefabs: FlowerBox, NPCInstance, TriggerArea)
├── Data/           (Kho Schemas tĩnh JSON: FlowerDefinition, NPCData, PressedMemory, QuestData)
├── Events/         (Các Event Sheet dùng chung: GlobalSignals, CollisionRules, TimeTickers)
└── Utilities/      (Các hàm tiện ích bổ trợ: MathHelper, DeltaTimer, StringFormatter)
```

❌ **Các thư mục code bị cấm tự tạo (*Forbidden Source Subdirectories*):**  
`Scripts/`, `Script/`, `Codes/`, `Gameplay/`, `New_Logic/`, `Temp_Events/`.

---

## 8. Import Pipeline

Quy trình chuẩn hóa chuỗi cung ứng tài nguyên (*Production Import Pipeline*) từ bàn tay họa sĩ/AI đến khi nằm gọn gàng bên trong bộ nhớ Engine GDevelop:

```text
┌─────────────────┐
│   1. Concept    │  Vẽ phác thảo phác ý tưởng lưu tại `Assets/[Category]/[id]/Concept/`
└────────┬────────┘
         ↓
┌─────────────────┐
│   2. Approved   │  Game Director nghiệm thu theo Asset Bible (`00–08`), chuyển sang số hóa
└────────┬────────┘
         ↓
┌─────────────────┐
│    3. Pixel     │  Vẽ hoàn thiện Pixel Sprite / Portrait / UI Texture trên Aseprite/Photoshop
└────────┬────────┘
         ↓
┌─────────────────┐
│  4. Animation   │  Cắt khung hình động (`Key Poses / In-betweens`), chốt FPS chuẩn
└────────┬────────┘
         ↓
┌─────────────────┐
│  5. Export PNG  │  Xuất file `.png` (RGBA uncompressed) hoặc `.ogg` (Audio loop seamless)
└────────┬────────┘
         ↓
┌─────────────────┐
│ 6. Assets/ Store│  Lưu file chính thức vào vị trí độc tôn `Assets/[Category]/[id]/Sprites/`
└────────┬────────┘
         ↓
┌─────────────────┐
│  7. Prototype   │  Nạp thử vào `Prototype/` sandbox để kiểm chứng va chạm và màu sắc
└────────┬────────┘
         ↓
┌─────────────────┐
│  8. Production  │  Tích hợp chính thức vào `Source/` GDevelop Project, khóa Z-order & Layer
└─────────────────┘
```

---

## 9. File Naming Rules

Mọi tệp tin trong toàn bộ dự án **Plant Tales** phải tuân thủ nghiêm ngặt quy định đặt tên **snake_case** toàn chữ thường, không dấu cách, không ký tự đặc biệt theo cấu trúc định danh phân tầng:  
`[domain/prefix]_[category]_[name]_[variant/state].[ext]`

| Loại tệp tin | Quy tắc định dạng chuẩn (*Naming Formula*) | Ví dụ chuẩn xác (`REQUIRED`) | Ví dụ sai bị cấm (`PROHIBITED`) |
| --- | --- | --- | --- |
| **Sprite Sheet** | `[domain]_[id]_[action].[png]` | `flower_white_lily_idle.png`<br>`npc_florist_walk.png` | `Flower1.png`<br>`New Flower.png` |
| **Portrait / UI**| `portrait_[id]_[expression].[png]`<br>`ui_[module]_[name].[png]` | `portrait_npc_mayor_happy.png`<br>`ui_journal_spread_base.png` | `Mayor_happy.png`<br>`journal_FINAL.png` |
| **JSON Data** | `[schema_name]_[category].[json]` | `flower_definition_rose.json`<br>`npc_data_florist.json` | `data1.json`<br>`rose_data_final.json` |
| **Audio Files** | `[bgm/amb/sfx]_[name]_[state].[ext]` | `bgm_village_day_spring.ogg`<br>`sfx_flower_bloom_chime.wav` | `sound_test.mp3`<br>`village_music.wav` |

---

## 10. Version Policy

Dự án áp dụng chính sách quản lý phiên bản nghiêm ngặt (*Clean Basename Versioning Policy*). Khẳng định nguyên tắc:

> **"Không tồn tại các tệp tin đánh dấu phiên bản bằng rác hậu tố tên file. Git chính là công cụ duy nhất chịu trách nhiệm quản lý version."**

❌ **Nghiêm cấm tuyệt đối tình trạng rác tên file lưu trữ song song như sau:**
```text
rose_final.png   |   rose_final2.png   |   rose_final_final.png   |   rose_2026_07_16.png
```
*Quy định thực thi:* Tệp tin chính thức cho hoa hồng luôn chỉ có đúng 1 tên duy nhất là `flower_rose_common_idle.png`. Khi có bản vẽ đẹp hơn, lập trình viên hoặc họa sĩ **buộc phải ghi đè trực tiếp (*Direct Overwrite*)** lên file cũ và thực hiện lệnh `git commit -m "Update common rose sprite to v2 art standard"`.

---

## 11. Temporary File Policy

Để bảo vệ sự trong sạch tuyệt đối cho môi trường sản xuất (`Assets/` và `Source/`), **Plant Tales** ban hành luật chống tệp tin tạm (*Anti-junk Policy*):

- **Nghiêm cấm tệp tin và thư mục tạm trong Production (`Zero Temp Tolerance`):**
  - AI Agent và lập trình viên **nghiêm cấm tạo các thư mục hoặc file rác** như:  
    `backup/`, `temp/`, `cache/`, `copy/`, `old/`, `_trash/`, `*.bak`, `*.tmp` bên trong `Assets/`, `Docs/`, hay `Source/`.
- **Khu vực Sandbox duy nhất (`Prototype Sandbox`):**
  - Nếu AI hoặc lập trình viên cần tạo các file nháp để thử nghiệm một thuật toán mới hoặc test thử 10 biến thể sprite, **buộc phải đặt toàn bộ bên trong thư mục gốc `Prototype/`**. Thư mục `Prototype/` là nơi duy nhất được phép chứa code nháp và tài liệu thử nghiệm trước khi được dọn dẹp hoặc nghiệm thu vào `Source/`.

---

## 12. Asset Ownership

Mỗi tài nguyên bên trong thế giới game thuộc sở hữu và được điều phối bởi đúng một **Chuỗi Chủ Quyền Tài Sản (*Asset Ownership Chain*)** minh bạch, đảm bảo tính liên đới từ dữ liệu gốc đến âm thanh đầu cuối:

```text
┌────────────────────────────────────────────────────────────────────────┐
│ DOMAIN ROOT: Flower Module (`FlowerDefinition: flower_white_lily`)     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Chủ quản duy nhất của toàn bộ chuỗi)
       ┌────────────────────────────┼────────────────────────────┐
       ▼                            ▼                            ▼
┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────────┐
│  1. Flower Concept   │  │   2. Flower Asset    │  │   3. Flower Sprite   │
│ `Assets/Flowers/.../ │  │ `flower_white_lily   │  │ `flower_white_lily   │
│  Concept/...png`     │  │  _definition.json`   │  │  _idle.png`          │
└──────────────────────┘  └──────────┬───────────┘  └──────────┬───────────┘
                                     │                         │
               ┌─────────────────────┴─────────────────────┐   │
               ▼                                           ▼   ▼
     ┌──────────────────────┐                    ┌──────────────────────┐
     │  4. Flower Journal   │                    │  5. Flower Animation │
     │ `journal_white_lily  │                    │ `anim_flower_white   │
     │  _plate.png`         │                    │  _lily_sway.png`     │
     └──────────────────────┘                    └──────────┬───────────┘
                                                            │
                                                            ▼
                                                 ┌──────────────────────┐
                                                 │   6. Flower Audio    │
                                                 │ `sfx_flower_bloom    │
                                                 │  _perfect_chime.wav` │
                                                 └──────────────────────┘
```

---

## 13. AI Folder Rules

Bảng phân định ranh giới hành vi cho các AI Coding Agents (Codex, Antigravity) khi tương tác với hệ thống tệp tin và thư mục của dự án:

### 13.1. Quyền Hạn Được Phép (`Authorized AI Actions` — ✅ GREEN LIGHT)
- ✅ **Tạo file mới (*Create Files*):** Được phép tạo file `.json`, `.png`, `.md`, hoặc `.js/.gd` mới **bên trong đúng thư mục con quy chuẩn đã định nghĩa sẵn** (ví dụ: tạo `flower_definition_tulip.json` bên trong `Source/Data/`).
- ✅ **Sửa file hiện hữu (*Modify Files*):** Được phép chỉnh sửa nội dung code hoặc cập nhật tài liệu bên trong các file đã có.
- ✅ **Thêm thư mục con nội bộ (*Add Internal Subfolders*):** Được phép tạo thư mục con đúng chuẩn mô-đun khi bổ sung một loài hoa mới vào `Assets/Flowers/[Category]/[flower_id]/` (`Concept/`, `Sprites/`, `Icons/`, `Journal/`, `Animation/`).

### 13.2. Cấm Địa Thư Mục (`Strictly Forbidden AI Actions` — ❌ RED LIGHT)
- ❌ **Không đổi tên Root Directory (`No Root Renaming`):** Cấm tuyệt đối việc đổi tên `Assets/` thành `GameAssets/` hay `Source/` thành `Code/`.
- ❌ **Không di chuyển Asset ngang trái (`No Unauthorized Relocation`):** Cấm tự ý di chuyển file hình ảnh từ `Assets/UI/` sang `Source/UI/` hay ngược lại.
- ❌ **Không nhân bản tài nguyên (`No Asset Duplication`):** Cấm copy `icon_flower_rose.png` sang 3 thư mục khác nhau để gọi cho tiện. Buộc phải tham chiếu cùng về đúng 1 đường dẫn gốc.
- ❌ **Không Rename Folder đang sử dụng (`No Directory Renaming`):** Cấm đổi tên thư mục `Assets/NPC/Main/` thành `Assets/NPC/Core/` vì sẽ làm gãy đường dẫn của toàn bộ GDevelop project.

---

## 14. Asset Lifecycle Standard

Nâng tầm quản trị dự án ngang chuẩn các studio game AAA hàng đầu, mọi thực thể tài nguyên trong **Plant Tales** phải trải qua một vòng đời 8 bước tiêu chuẩn (*8-Stage Asset Lifecycle*). Không một tài nguyên nào được phép tồn tại dưới dạng "file mồ côi" không rõ trạng thái:

```text
[Idea] ➔ [Concept] ➔ [Review] ➔ [Approved] ➔ [Production] ➔ [Imported] ➔ [Used In Game] ➔ [Maintained]
```

| Giai đoạn vòng đời | Định nghĩa trạng thái & Nhiệm vụ thực thi | Vị trí lưu trữ tệp tin tương ứng trong dự án |
| --- | --- | --- |
| **1. Idea** | Khởi nguồn ý tưởng thiết kế, xác định đặc tính ngôn ngữ hoa (`Language of Flowers`) | `Docs/01_Game_Design/` & `Docs/02_Design_Bible/` |
| **2. Concept** | Họa sĩ/AI vẽ phác thảo Turnaround thô, định hình Silhouette và bảng màu | `Assets/[Category]/[id]/Concept/` (`_concept.png`) |
| **3. Review** | Game Director kiểm tra độ chuẩn xác theo các tiêu chuẩn trong Asset Bible (`00–08`) | Kiểm duyệt trên kênh quản lý (`Docs/05_Production/`) |
| **4. Approved** | Khóa thiết kế phác thảo, chốt mã ID chính thức và chuyển sang giai đoạn số hóa pixel | `Assets/[Category]/[id]/Concept/` (Locked status) |
| **5. Production** | Vẽ hoàn thiện Pixel Sprite, Portrait, cắt Animation và thu âm SFX vi âm | `Assets/[Category]/[id]/[Sprites/Icons/Audio/VFX]/` |
| **6. Imported** | Nạp tài nguyên vào GDevelop Engine, thiết lập gốc Pivot sát đất và cấu hình bouding box | Cấu hình bên trong file `Source/Project.json` |
| **7. Used In Game** | Tích hợp vào Event Sheet, gán vào Scene thực tế (`Village/House`) và kết nối dữ liệu JSON | Liên kết bên trong `Source/Scenes/` & `Source/Events/` |
| **8. Maintained** | Theo dõi hiệu năng runtime, kiểm tra lỗi va chạm và bảo trì cập nhật art sang v2 nếu cần | Quản lý lịch sử thay đổi thông qua `Git Repository` |

---

## 15. ASCII Folder Diagram

Sơ đồ ASCII tổng thể toàn cầu (*Master Repository Directory Tree*), minh họa trọn vẹn 6 thư mục gốc bất biến và cấu trúc phân nhánh chi tiết của **Plant Tales**:

```text
Plant Tales/
│
├── Docs/
│   ├── 01_Game_Design/
│   ├── 02_Design_Bible/
│   ├── 03_Concepts/
│   ├── 04_Research/
│   ├── 05_Production/
│   ├── 06_Asset_Bible/
│   ├── 07_Production_Bible/
│   │   ├── 00_Production_Overview.md
│   │   ├── 01_Project_Architecture.md
│   │   └── 02_Folder_Convention.md  ◄── (Authoritative Pipeline Standard)
│   └── 08_Game_Rules_Bible/
│
├── Assets/
│   ├── Characters/
│   │   ├── Mia/
│   │   │   ├── Sprites/
│   │   │   └── Portraits/
│   │   └── Okeydokey/
│   ├── Flowers/
│   │   ├── Rose/
│   │   │   └── flower_rose_common/
│   │   │       ├── Concept/
│   │   │       ├── Sprites/
│   │   │       ├── Icons/
│   │   │       ├── Journal/
│   │   │       └── Animation/
│   │   └── Tulip/
│   ├── Buildings/
│   ├── Tilesets/
│   ├── Props/
│   ├── UI/
│   │   ├── Journal/
│   │   └── HUD/
│   ├── Icons/
│   ├── Audio/
│   │   ├── BGM/
│   │   ├── Ambient/
│   │   ├── UI/
│   │   └── Flowers/
│   ├── Fonts/
│   └── VFX/
│
├── Prompts/
│   ├── Characters/
│   ├── Flowers/
│   ├── NPC/
│   ├── Buildings/
│   ├── Tilesets/
│   ├── UI/
│   ├── Animation/
│   └── Music/
│
├── Prototype/
│   ├── Sandbox_Scenes/
│   └── Temp_Experiments/
│
├── Source/
│   ├── Project.json  ◄── (GDevelop 5 Master Authoritative File)
│   ├── Systems/
│   ├── Managers/
│   ├── Scenes/
│   ├── UI/
│   ├── Objects/
│   ├── Data/
│   │   ├── flower_definition_rose.json
│   │   └── npc_data_florist.json
│   ├── Events/
│   └── Utilities/
│
└── References/
    ├── Botanical_PDFs/
    └── Cozy_Game_Moodboards/
```
