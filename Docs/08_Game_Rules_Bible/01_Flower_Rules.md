# Chapter 01: Flower & Botany Rules (`Greenhouse Botanical Laws`)

**Quy tắc sinh trưởng thực vật, thuật toán độ ẩm, luật lai tạo di truyền và cơ chế bảo vệ bình yên (`Cozy Constitutional Laws`) cho khu vườn Plant Tales.**

---

## 1. Constitutional Rule 001: No Permanent Plant Death (`Luật Bất Biến 001: Không Sự Chết Vĩnh Viễn`)

Trong hầu hết các tựa game mô phỏng nông nghiệp truyền thống (`Harvest Moon`, `Stardew Valley`), nếu người chơi quên tưới nước trong nhiều ngày hoặc bận rộn ngoài đời thực không thể đăng nhập, cây trồng sẽ bị chết héo (`Withered/Dead Crops`) và biến thành rác, buộc người chơi phải dùng liềm phá bỏ và mất trắng số tiền đầu tư hạt giống.

> [!IMPORTANT]
> **CONSTITUTIONAL LAW IN PLANT TALES**
> Cây trồng trong Nhà kính Plant Tales **KHÔNG BAO GIỜ CHẾT HOẶC BIẾN MẤT VĨNH VIỄN DO THIẾU NƯỚC**. Khi độ ẩm ô đất giảm xuống `0%`, hoa sẽ chuyển sang trạng thái Ngủ Đông (`Botanical Stasis / Dry State`). Ở trạng thái này, tiến trình sinh trưởng tạm dừng (`Growth Rate = 0.0`), nhưng cây tuyệt đối không bị héo úa hay chết đi. Chỉ cần người chơi quay trở lại và tưới nước, cây lập tức bừng tỉnh và tiếp tục sinh trưởng từ đúng mili-giây mà nó đã tạm dừng.

Quy tắc này bảo vệ triệt để bản sắc **Cozy Botanical RPG**: khu vườn là nơi chữa lành, luôn kiên nhẫn chờ đợi người chơi trở về, không bao giờ trừng phạt họ vì áp lực cuộc sống đời thực.

---

## 2. Vòng Đời & Sơ Đồ Trạng Thái (`State Machine Diagram`)

Mỗi loài hoa trong tệp cơ sở dữ liệu `flower_catalog.json` được định nghĩa với 4 giai đoạn sinh trưởng tiêu chuẩn (`stages_count = 4`). Sơ đồ trạng thái dưới đây định nghĩa chính xác luồng chuyển đổi trạng thái (`Transitions`) và trạng thái Ngủ Đông (`Stasis`) tuân thủ `Rule 001`:

```text
┌────────────────────────────────────────────────────────────────────────┐
│               FLOWER INSTANCE STATE MACHINE DIAGRAM                    │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│   [PlantSeed Triggered]                                                │
│             │                                                          │
│             ▼                                                          │
│     ┌───────────────┐        moisture == 0       ┌─────────────────┐   │
│     │ Stage 0: Seed ├───────────────────────────►│ Stasis: Dry     │   │
│     └───────┬───────┘                            │ (Growth = 0.0)  │   │
│             │ accumulated_minutes >= 20%         └────────▲────────┘   │
│             ▼                                             │            │
│    ┌─────────────────┐       moisture == 0                │            │
│    │ Stage 1: Sprout ├────────────────────────────────────┤            │
│    └────────┬────────┘                                    │            │
│             │ accumulated_minutes >= 55%                  │            │
│             ▼                                             │            │
│    ┌─────────────────┐       moisture == 0                │            │
│    │ Stage 2: Bud    ├────────────────────────────────────┘            │
│    └────────┬────────┘                                                 │
│             │ accumulated_minutes >= 100%                              │
│             ▼                                                          │
│   ┌───────────────────┐      [HarvestTriggered]                        │
│   │  Stage 3: Bloom   ├─────────────────────────► [Slot Cleared /      │
│   │ (Emit Bloomed!)   │                           Return to Bud]       │
│   └───────────────────┘                                                │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Thứ Tự Mô Phỏng Bất Biến (`Fixed Simulation Order Rule`)

Để bảo đảm tính xác định tuyệt đối (`Deterministic Execution`) trên toàn bộ thế giới và ngăn chặn lỗi xung đột trạng thái khi AI lập trình, mọi chu kỳ thời gian (`TimeMinuteTicked`) phải thực thi nghiêm ngặt theo đúng thứ tự 8 bước sau:

```text
TimeTicker (+10 min) ➔ Weather Check ➔ Moisture Decay ➔ Growth Calculation ➔ Mutation Check ➔ Bloom Hook ➔ Quest Sync ➔ Save Dirty Hook
```

1. **Minute Tick (`TimeTicker`):** Đồng hồ thế giới tiến lên `+10 phút`, phát tín hiệu `TimeMinuteTicked`.
2. **Weather Check (`WeatherSystem`):** Kiểm tra trạng thái thời tiết hiện tại (`is_raining`). Nếu mưa, tự động khóa độ ẩm ở mức `100%`.
3. **Moisture Decay (`FlowerSystem`):** Nếu trời nắng/sương mù, giảm độ ẩm ô đất (`-2% / 10 phút`). Nếu `moisture == 0`, kích hoạt cờ `is_stasis = true`.
4. **Growth Calculation (`FlowerSystem`):** Nếu `is_stasis == false`, gia tăng `accumulated_minutes` theo hệ số $\mathcal{M} \times \mathcal{W}$.
5. **Mutation Check (`Hybridization Engine`):** Nếu thời điểm hiện tại vừa chuyển sang `06:00 AM (DayAdvanced)`, quét các cặp hoa `Stage == 3` kề cận để tính xác suất lai tạo hạt giống mới.
6. **Bloom Hook (`FlowerSystem`):** Nếu `accumulated_minutes >= base_growth_minutes`, chuyển sang `Stage 3: Bloom` và phát tín hiệu `FlowerBloomed`.
7. **Quest Sync (`QuestSystem`):** Lắng nghe các tín hiệu `FlowerBloomed` hoặc `FlowerHarvested` để cập nhật tiến độ nhiệm vụ.
8. **Save Dirty Hook (`SaveManager`):** Gán `g_SaveManager.is_dirty = true` báo hiệu cần lưu trạng thái vào cache.

---

## 3. Công Thức Toán Học & Thuật Toán Độ Ẩm (`Growth Mathematical Engine`)

Mỗi nhịp đồng hồ thời gian (`TimeMinuteTicked`) do `TimeTicker Singleton` phát ra (`+10 phút game time/tick`), hệ thống `FlowerSystem` thực thi tính toán tiến trình cho từng cá thể hoa (`FlowerInstance`) theo công thức toán học vô danh (`ADR-005 Identity-Agnostic Engine`):

$$\text{EffectiveDeltaMinutes} = \text{BaseDeltaMinutes} \times \mathcal{M}(\text{moisture\_level}) \times \mathcal{W}(\text{weather\_profile})$$

### 3.1. Bảng Hệ Số Độ Ẩm Đất ($\mathcal{M}$)
Độ ẩm ô đất (`moisture_level`) có giá trị nguyên từ `0` đến `100 (%)`. Mỗi `10 phút` game time, độ ẩm tự động giảm `2%` (trong điều kiện trời nắng). Hệ số tác động sinh trưởng $\mathcal{M}$ được chia làm 3 ngưỡng:
- 🔵 **Đất Ướt (`Wet State: 50% - 100%`) ➔ $\mathcal{M} = 1.0 \times$ (`100% Tốc độ tối đa`)**: Hoa phát triển với tốc độ hoàn hảo.
- 🟡 **Đất Ẩm (`Damp State: 1% - 49%`) ➔ $\mathcal{M} = 0.5 \times$ (`50% Tốc độ chậm`)**: Hoa vẫn lớn nhưng tốc độ giảm một nửa, báo hiệu người chơi nên chuẩn bị tưới nước.
- 🔴 **Đất Khô (`Dry State: 0%`) ➔ $\mathcal{M} = 0.0 \times$ (`0% Ngủ Đông / Stasis`)**: Tuân thủ `Rule 001`, cây dừng sinh trưởng nhưng giữ nguyên sự sống.

### 3.2. Bảng Hệ Số Thời Tiết ($\mathcal{W}$)
Thời tiết (`WeatherModule`) tác động trực tiếp lên toàn bộ nhà kính:
- ☀️ **Sunny Day (`weather_sunny`) ➔ $\mathcal{W} = 1.0 \times$**: Sinh trưởng tiêu chuẩn.
- 🌧️ **Spring Rain (`weather_spring_rain`) ➔ $\mathcal{W} = 1.25 \times$ + Tự động làm ẩm đất lên `100%`**: Mưa rào mùa xuân gia tốc sinh trưởng thêm `25%` và tiết kiệm công tưới nước cho người chơi.
- 🌫️ **Morning Fog (`weather_morning_fog`) ➔ $\mathcal{W} = 1.1 \times$**: Sương mù giữ ẩm, giảm tốc độ khô đất xuống còn `1% / 10 phút`.

---

## 4. Luật Lai Tạo Di Truyền (`Cross-Pollination & Hybridization Mechanics`)

Một trong những cơ chế chiều sâu nhất của Plant Tales là **Thuật toán Lai Tạo Di Truyền (`Botanical Genetics`)**. Khi hai bông hoa ở giai đoạn **Nở Rộ (`Stage 3: Blooming`)** nằm kề cạnh nhau trên lưới đất (`Adjacency Check`), có cơ hội sinh ra hạt giống lai mới trong mỗi buổi sáng ngày mới (`DayAdvanced Signal`).

### 4.1. Thuật Toán Kiểm Tra Kề Cận (`4-Way Manhattan Adjacency`)
Lưới nhà kính kích thước `20x20` kiểm tra 4 ô liền kề theo hướng `Đông, Tây, Nam, Bắc` (`North, South, East, West` — không kiểm tra đường chéo).

### 4.2. Công Thức Xác Suất Lai Tạo (`Cross-Pollination Probability`)
Khi hai bông hoa `Parent A` và `Parent B` thỏa mãn điều kiện kề cận tại thời điểm chuyển ngày:

$$\text{HybridChance} = \text{BaseChance } (15\%) + \text{MoistureBonus } (5\%) + \text{BotanistHeartBonus } (\text{NPC Thomas Heart Level} \times 1\%)$$

- **Ngưỡng tối đa (`Max Cap`):** `30% chance per pair per day`.
- **Thực thi tín hiệu (`Event Bus Hook`):** Khi lai tạo thành công, hệ thống không tự động thay thế cây bố mẹ mà phát ra tín hiệu `HybridMutationOccurred (parent_a_id, parent_b_id, hybrid_seed_id, grid_x, grid_y)`. Hạt giống lai mới rơi thẳng vào Satchel của người chơi kèm âm thanh chúc mừng lấp lánh!

### 4.3. Bảng Công Thức Lai Tạo Tiêu Chuẩn (`Hybrid Matrix Sample`)

| Hoa Bố Mẹ A (`Parent A`) | Hoa Bố Mẹ B (`Parent B`) | Hạt Giống Lai Tạo (`Hybrid Seed Output`) | Độ Hiếm (`Rarity`) |
| --- | --- | --- | :---: |
| `flower_white_lily` (Lily Trắng) | `flower_red_rose` (Hồng Đỏ) | `item_seed_pink_blossom` (Hạt Giống Anh Đào Hồng) | ⭐⭐ |
| `flower_blue_lavender` (Oải Hương Xanh) | `flower_white_lily` (Lily Trắng) | `item_seed_silver_bell` (Hạt Giống Chuông Bạc) | ⭐⭐⭐ |
| `flower_red_rose` (Hồng Đỏ) | `flower_golden_sunflower` (Hướng Dương Vàng)| `item_seed_sunset_dahlia` (Hạt Giống Thược Dược Hoàng Hôn)| ⭐⭐⭐⭐ |

---

## 6. Luật Thu Hoạch & Giải Phóng Lưới (`Harvest & Slot Cleansing Rules`)

- **Điều kiện thu hoạch:** Người chơi chỉ có thể thu hoạch khi ô đất đạt giai đoạn `Stage == 3 (Blooming)`.
- **Hành vi thu hoạch tiêu chuẩn (`Annual Plants`):** Khi thu hoạch, `FlowerSystem` phát tín hiệu `FlowerHarvested (flower_id, yield_qty = 1)` tới `EventBus`. Sau đó, ô đất tự động trả về trạng thái trống rỗng (`slot.state = Empty`, `slot.flower_ref_id = ""`) để sẵn sàng gieo vụ mới.
- **Hành vi lưu cữu (`Perennial Plants — Khai báo cờ trait: perennial`):** Một số hoa hiếm sau khi thu hoạch không biến mất hoàn toàn mà tự động lùi về `Stage 2 (Budding)` với `accumulated_minutes = 50% base_growth`, cho phép người chơi tiếp tục chăm sóc và thu hoạch nhiều lần mà không cần gieo hạt mới.

---

## 7. Kiểm Định Hiệu Năng & Quy Định AI (`Performance & AI Rules`)

- **Kiểm tra theo chu kỳ (`Time-Sliced Processing`):** AI Agent khi lập trình `flower_system.json` tuyệt đối không được dùng vòng lặp `For Each Object` kiểm tra toàn bộ 400 ô đất trong Event `Every Frame`. Hệ thống chỉ được phép tính toán lại khi nhận được tín hiệu `TimeMinuteTicked` từ `TimeTicker Singleton` (thực thi theo Batch tối đa `4.0 ms`).
- **Nghiêm cấm vi phạm Contract:** Khi thu hoạch hoa, `FlowerSystem` cấm tự ý gọi `InventorySlot.Add()`. Mọi vật phẩm phải đi qua tín hiệu `FlowerHarvested` và để `InventorySystem` tự xử lý!

---

## 8. Bảng Kịch Bản Kiểm Định QA (`Verification Test Cases`)

Để liên kết trực tiếp luật hiến pháp với quy trình Smoke Test (`QA Constitution - 09_Testing_Debugging.md`), dưới đây là bảng kiểm tra bắt buộc cho Flower System:

| Test ID | Rule Liên Quan (`Rule Governed`) | Kịch Bản Thiết Lập (`Setup / Trigger Steps`) | Kết Quả Mong Đợi (`Expected Deterministic Result`) | Trạng Thái (`QA Status`) |
| --- | --- | --- | --- | :---: |
| **TC-FL-01** | `Rule 001 (No Death)` | 1. Gieo hoa `flower_white_lily`.<br>2. Để `moisture_level` giảm về `0%`.<br>3. Chờ `TimeTicker` chạy thêm 10 ngày simulation (`+14,400 mins`). | Hoa chuyển sang `is_stasis = true` và animation `Stasis_Dry`. **Tuyệt đối KHÔNG BỊ XÓA (`Not Deleted`)** hay biến thành rác (`No Withered Crop`). | ✅ `Passed` |
| **TC-FL-02** | `Rule 001 (Recovery)` | 1. Cây hoa đang ở `is_stasis = true`.<br>2. Người chơi tưới nước (`WaterFlower`) hoặc trời chuyển mưa (`WeatherChanged: spring_rain`). | Gán `moisture_level = 100`, `is_stasis = false`, tiếp tục tăng `accumulated_minutes` từ đúng thời điểm đã dừng. | ✅ `Passed` |
| **TC-FL-03** | `ADR-005 (Identity-Agnostic)` | 1. Thêm loài hoa mới `flower_carnivorous_plant` vào `flower_catalog.json`.<br>2. Gieo hạt xuống ô đất mà không sửa hay compile lại code Event Sheet. | Hệ thống tự động gieo, tính toán độ ẩm và chuyển giai đoạn thành công 100% dựa trên dữ liệu JSON định nghĩa. | ✅ `Passed` |
| **TC-FL-04** | `Harvest Cleansing` | 1. Thu hoạch cây hoa đạt `Stage == 3 (Blooming)`. | Phát tín hiệu `FlowerHarvested` chính xác 1 lần ➔ Ô đất về trạng thái `Empty` ➔ Cây hoa trên đất biến mất sạch sẽ. | ✅ `Passed` |
