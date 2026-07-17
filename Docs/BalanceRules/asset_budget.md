# 🎨 Asset Budget & Content Ceiling Enforcement (`Soft & Hard Limits`)

Tài liệu này xác lập **Khung Ngân sách Tài nguyên (`Asset Budget & Production Ceilings`)** theo cơ chế 2 tầng: **Ngưỡng Mềm (`Soft Limit — Warning Threshold`)** và **Ngưỡng Cứng (`Hard Limit — Merge Block / Error Threshold`)**. Để tránh hiện tượng phình to không kiểm soát (`Scope Creep / Asset Bloat`) và gây bất ngờ khi merge commit trước Alpha, động cơ kiểm định (`Automated Content Audit — M4.1D / M4.2A.0`) sẽ giám sát chặt chẽ số lượng tệp của từng hạng mục.

---

## 1. Bảng Ngân Sách Tài Nguyên Khóa Trước Alpha (`Soft & Hard Limits Table`)

| Hạng Mục (`Category`) | Ngưỡng Mềm (`Soft Limit`) | Ngưỡng Cứng (`Hard Limit`) | Số Lượng Hiện Tại (`Current Count`) | Trạng Thái Kiểm Định (`Audit Status`) | Hành Động Hệ Thống (`System Enforcement Action`) |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **Flowers (`flower_*.json`)** | `10` | `12` | `12` | 🟡 **`SOFT LIMIT EXCEEDED / HARD LOCKED (100%)`** | `< 10`: SAFE <br> `10~12`: `[WARNING]` Bắt đầu cảnh báo chạm trần ngân sách hoa. <br> `> 12`: `[CRITICAL AUDIT ERROR]` Block merge, yêu cầu duyệt từ Lead GD. |
| **NPC Portraits & Data (`npc_*.json`)** | `3` | `4` | `4` | 🟡 **`SOFT LIMIT EXCEEDED / HARD LOCKED (100%)`** | `3~4`: `[WARNING]` Cảnh báo số lượng NPC cận kề giới hạn Alpha. <br> `> 4`: `[CRITICAL AUDIT ERROR]` Block merge ngay lập tức. |
| **Dialogues (`dialogue_*.json`)** | `6` | `8` | `4` | 🟢 `SAFE (50%)` | `6~8`: `[WARNING]` Cảnh báo cây hội thoại phức tạp. <br> `> 8`: Block merge. |
| **Quests (`quest_*.json`)** | `12` | `15` | `15` | 🟡 **`SOFT LIMIT EXCEEDED / HARD LOCKED (100%)`** | `12~15`: `[WARNING]` Cảnh báo số lượng nhiệm vụ theo mùa. <br> `> 15`: Block merge. |
| **Items / Seeds (`seed_*, tool_*`)** | `12` | `15` | `13` | 🟡 `SOFT LIMIT EXCEEDED (86%)` | `12~15`: `[WARNING]` Cảnh báo Satchel item đa dạng. <br> `> 15`: Block merge. |
| **Weather Profiles (`weather_*.json`)** | `4` | `5` | `3` | 🟢 `SAFE (60%)` | `4~5`: `[WARNING]` Cảnh báo hồ sơ thời tiết. <br> `> 5`: Block merge. |
| **Season Profiles (`season_*.json`)** | `4` | `4` | `4` | 🟡 **`HARD LOCKED (100% — 4 Mùa)`** | `> 4`: `[CRITICAL AUDIT ERROR]` Cấm tuyệt đối thêm mùa thứ 5! |
| **UI Icons & Sprites (`Assets/UI/`)** | `30` | `40` | `24` | 🟢 `SAFE (60%)` | `30~40`: `[WARNING]` Cảnh báo bộ nhớ sprite UI phình to. <br> `> 40`: Block merge. |
| **Tile Sets & Buildings (`Assets/Tiles/`)**| `4` / `8` | `5` / `10` | `3` / `6` | 🟢 `SAFE` | `[WARNING]` Khi vượt Soft Limit; `[ERROR]` Khi vượt Hard Limit. |

---

## 2. Quy Tắc Thực Thi 2 Tầng (`Soft vs Hard Limit Enforcement`)

- **Rule B-001 (Soft Limit Early Warning):** Khi `ContentManagerSystem` nạp chỉ mục từ `content_manifest.json`, nếu số phần tử của nhóm đạt hoặc vượt `Soft Limit` (`>= Soft Limit` nhưng `<= Hard Limit`), hệ thống ghi log cảnh báo màu vàng vào `Content_Validation_Report.txt`:
  ```text
  [BUDGET WARNING — SOFT LIMIT EXCEEDED] Group 'flowers' count (12) has reached the Soft Limit (10). Prepare for feature freeze or request budget revision!
  ```
- **Rule B-002 (Hard Limit Merge Block):** Nếu số phần tử vượt quá `Hard Limit` (`> Hard Limit`), hệ thống phát lỗi nghiêm trọng màu đỏ (`CRITICAL AUDIT ERROR`) và từ chối đóng dấu `SUCCESS_DATA_DRIVEN`:
  ```text
  [BUDGET BLOCK — HARD LIMIT VIOLATION] Group 'flowers' count (13) exceeds Hard Limit (12). Merge blocked! Technical Director explicit override required.
  ```
- **Rule B-003 (AI Generation Protection):** Mọi công cụ AI hỗ trợ (`Codex`, `Antigravity`, `ChatGPT`) trước khi đề xuất tạo thêm file mới phải đọc bảng Soft & Hard Limit này. Nếu hạng mục đã chạm `Soft Limit`, AI phải chủ động cảnh báo người dùng. Nếu chạm `Hard Limit`, AI phải từ chối tạo thêm tệp mới.
