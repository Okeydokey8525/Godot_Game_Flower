# ⚡ Performance Budget Constitution (`Frozen Performance Contract`)

## M4.2C Measurement Evidence Rules

Numeric limits below remain unchanged. Every evaluation must name its evidence
source: `PYTHON_BENCHMARK`, `GODOT_RUNTIME`, `STATIC_ANALYSIS`, `ESTIMATED`,
or `NOT_MEASURED` / `NOT_OBSERVABLE`. Estimates cannot receive PASS.

### M4.3A Runtime Target Transition

**Runtime status:** `TARGET_RUNTIME_PENDING`.

GDevelop-specific runtime methods in the historical matrix below are unverified legacy
references, not evidence or requirements for the target runtime. M4.2C-A Python
results remain approved reference evidence only. Godot runtime metrics must be
remeasured after a runnable vertical slice exists; no Godot runtime metric currently
has PASS status.

- Boot and scene readiness require named Godot markers. A legacy BootScene first frame
  is not an approved substitute.
- The `<100 ms` JSON/registry numeric target applies to a future Godot loader and
  registry. Python timing supports the frozen 55-entry manifest but is not runtime
  proof.
- Runtime memory, FPS, frame time, draw calls, visible objects, and 500-flower stress
  require a named Godot debug build, Compatibility renderer, resolution, scenario, and
  raw samples. FPS evidence must report average/minimum/1%-low when valid plus
  average/p95/maximum frame time.

The numeric limits remain frozen. Their GDevelop implementation wording below is
historical until M4.3A.6 defines validated Godot measurement points.

- **Boot time:** `PENDING_RUNTIME_EVIDENCE`. The current project has no
  `MainMenuScene`, so the “boot-to-menu” endpoint is unresolved. Do not substitute
  BootScene first frame without an approved marker definition.
- **JSON parse / registry load:** The `<100 ms` target applies to the GDevelop
  `ContentManagerSystem` runtime load of the frozen 55-entry manifest. Python timing
  is supporting data-pipeline evidence only; it does not substitute for runtime proof.
- **Registry RAM:** Report raw JSON bytes, parsed Python deep-size, Python registry
  deep-size, and Python allocation metrics separately. GDevelop runtime registry RAM
  requires a profiler and remains `PENDING_RUNTIME_EVIDENCE`.
- **Draw calls, visible objects, FPS, and frame time:** Require a named GDevelop
  runtime scenario, resolution, build type, and raw samples. FPS evidence must report
  average, minimum, 1% low when sample count permits, average frame time, p95 frame
  time, and maximum frame time; a rounded average alone cannot PASS.
- **500-flower stress:** Requires a verified runtime fixture containing 500 active
  flowers. The present `StressTest.json` fixture does not establish this condition.

Tài liệu này xác lập **Hiến pháp Ngân sách Hiệu năng (`Performance Budget Constitution / Contract`)** của Plant Tales. Đây là hợp đồng kỹ thuật bất khả xâm phạm (`Frozen Contract`) bắt buộc mọi lập trình viên (`Engine Engineers`) và nhà thiết kế (`Designers / Authors`) phải tuân thủ nghiêm ngặt từ giai đoạn `Pre-Alpha Stabilization (M4.2)` cho đến `Release Candidate (M6)`.

---

## 1. Bảng Chỉ Tiêu Ngân Sách Hiệu Năng (`Performance Budget Matrix`)

| Chỉ Số Hiệu Năng (`Metric Name`) | Ngưỡng Ngân Sách (`Budget Threshold`) | Ngưỡng Cảnh Báo (`Warning Threshold`) | Phương Pháp Đo Đạc (`Measurement Method`) | Hành Động Khi Vượt Ngưỡng (`Violation Action`) |
| :--- | :---: | :---: | :--- | :--- |
| **1. Boot Time (`Thời gian khởi chạy game đến BootScene`)** | `< 0.2 giây` (`200 ms`) | `> 0.15 giây` (`150 ms`) | Đo từ lúc GDevelop khởi tạo đến event `OnFirstFrame` tại `BootScene`. | Tối ưu hóa tải tài nguyên, hoãn tải các âm thanh/sprite chưa dùng. |
| **2. JSON Parse Time (`Thời gian nạp 55 tệp Content JSON`)** | `< 0.1 giây` (`100 ms`) | `> 0.08 giây` (`80 ms`) | `ContentManagerSystem` timer đo tổng thời gian đọc và build `g_ContentRegistry`. | Gộp file index hoặc tối ưu hóa kích thước string JSON. |
| **3. RAM Content Registry (`Bộ nhớ chiếm dụng của g_ContentRegistry`)** | `< 5.0 MB` | `> 4.0 MB` | Đo thông qua GDevelop Profiler & Memory Inspector. | Cắt giảm các trường metadata dư thừa khi nạp vào runtime RAM. |
| **4. Active Draw Calls per Frame (`Số lệnh vẽ mỗi frame`)** | `< 250 Calls` | `> 200 Calls` | Đo tại `GreenhouseScene` khi trồng đầy đủ `500 chậu hoa`. | Kích hoạt Sprite Batching và Spatial Culling (`Screen Boundary Check`). |
| **5. Visible Objects on Screen (`Số đối tượng active trong camera`)**| `< 350 Objects` | `> 280 Objects` | Đo thông qua `Object.Count()` đối với các object đang hiển thị trên viewport. | Ẩn (`Hide/Disable`) các hoa, bụi cỏ, hoặc NPC nằm ngoài tầm nhìn (`Culling`). |
| **6. Stable Frame Rate (`Tốc độ khung hình tối thiểu`)** | `≥ 60 FPS` | `< 58 FPS` | Stress Test trồng 500 chậu hoa nở rộ (`Stage 3`), di chuyển camera liên tục trong `300 giây`. | Kiểm tra và tiêu diệt ngay các Event Sheet chạy `Every Frame` cho va chạm logic. |

---

## 2. Quy Tắc Giám Sát Hiệu Năng (`Performance Governance Rules`)

- **Rule P-001 (Zero Per-Frame Polling Mandate):** Nghiêm cấm mọi Event Sheet thực hiện quét toàn bộ danh sách đối tượng (`Check All Objects Every Frame`) để kiểm tra va chạm hay khoảng cách. Bắt buộc sử dụng kiến trúc định tuyến va chạm qua `InteractionSensorObject` (`ADR-003`).
- **Rule P-002 (Stress Test Fixture Gate):** Trước khi chốt bất kỳ bản build Alpha nào (`Alpha_Ready_Save.json`), QA phải chạy đĩa kiểm thử tải trọng cao (`StressTest.json` — 500 hoa nở rộ). Nếu FPS rớt xuống dưới `60 FPS` dù chỉ trong 5 giây, bản build bị từ chối đóng dấu nghiệm thu (`QA Block`).
- **Rule P-003 (Telemetry Performance Hooks):** Hệ thống Telemetry cục bộ (`Local Telemetry / Session Log`) tự động ghi nhận FPS trung bình (`Average FPS`) và Boot Time vào nhật ký mỗi phiên chơi để cung cấp bằng chứng (`Evidence-driven balancing`).
