# Architecture Decision Records (ADR Repository)

**Kho lưu trữ các quyết định kiến trúc cốt lõi, hồ sơ lý do (`WHY`) đằng sau các lựa chọn kỹ thuật tối cao cho dự án Plant Tales.**

---

## 1. Mục Đích & Triết Lý Kho ADR (`Why ADR?`)

Nếu **Production Bible (`Docs/07_Production_Bible/`)** trả lời câu hỏi **"Luật là gì?"** (*What rules must we follow?*), thì **ADR Repository (`Docs/09_Architecture_Decisions/`)** trả lời câu hỏi sâu sắc nhất của kỹ thuật: **"Tại sao luật đó tồn tại?"** (*Why did we choose this architecture over the alternatives?*).

Trong một dự án kéo dài nhiều năm hoặc luân chuyển qua nhiều lập trình viên và AI Agent (`Codex`, `Claude`, `ChatGPT`, `Antigravity`), khi đối diện với một thiết kế có vẻ phức tạp, con người và AI thường có thói quen thắc mắc: *"Ủa sao hồi đó lại thiết kế cồng kềnh thế này? Hay mình đập đi làm lại cho nhanh?"*.
Kho ADR sinh ra để ngăn chặn sự phá vỡ kiến trúc đó. Trước khi có ý định thay đổi hay đập bỏ bất kỳ hệ thống cốt lõi nào, AI và lập trình viên **buộc phải đọc hồ sơ ADR tương ứng** để hiểu trọn vẹn những bài toán khắc nghiệt, các phương án đã từng thử, sự đánh đổi (`Trade-offs`) và hậu quả chấp nhận (`Consequences`) lúc ban đầu.

---

## 2. Chuẩn Đặt Tên & Vòng Đời ADR (`ADR Lifecycle & Naming`)

### Chuẩn Đặt Tên File (`Naming Convention`)
Mọi hồ sơ ADR mới được tạo trong thư mục này buộc phải tuân thủ định dạng:
`ADR-XXX_Short_Descriptive_Title.md` *(Trong đó `XXX` là số thứ tự 3 chữ số bắt đầu từ `001`)*.

### Trạng Thái Quyết Định (`Status Hierarchy`)
- 🟢 **Accepted:** Quyết định đã được phê duyệt chính thức và đang áp dụng trên toàn bộ codebase (`Authoritative Law`).
- 🟡 **Proposed:** Quyết định đang được đề xuất, trong giai đoạn đánh giá rủi ro và thảo luận.
- 🔴 **Rejected:** Quyết định đã bị bác bỏ sau khi đánh giá (vẫn lưu lại hồ sơ để tương lai không phạm phải sai lầm tương tự).
- ⚪ **Deprecated / Superseded:** Quyết định cũ đã được thay thế bởi một bản ADR mới (lưu kèm link trỏ tới ADR mới).

---

## 3. Danh Mục Quyết Định Kiến Trúc (`Authoritative ADR Registry`)

Dưới đây là bảng tổng hợp các quyết định kiến trúc tối cao đã được ban hành và bảo chứng cho dự án Plant Tales:

| Mã ADR (`ID`) | Tên Quyết Định (`Decision Title`) | Phạm Vi Ảnh Hưởng (`Impact Area`) | Trạng Thái (`Status`) | Ngày Ban Hành (`Date`) |
| :---: | --- | --- | :---: | :---: |
| [ADR-001](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-001_Data_Driven_Architecture.md) | **Adopt Static Data-Driven Architecture vs Hardcoded Logic** | Toàn bộ `Static Database` (`03_Data_Architecture`) & `GameManager` | `Accepted` | `2026-07-16` |
| [ADR-002](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-002_Milestone_Driven_Roadmap.md) | **Adopt Milestone-Driven Execution over Calendar-Days** | Roadmap, Delivery Gates & QA Pipeline (`08_Prototype_Roadmap`) | `Accepted` | `2026-07-16` |
| [ADR-003](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-003_Strict_Module_Contracts.md) | **Adopt Strict Module Contracts & Global Signal Bus** | Event Bus, Ranh giới 8 Core Modules (`10_Module_Architecture`) | `Accepted` | `2026-07-16` |
| [ADR-004](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-004_Why_GDevelop_Engine.md) | **Adopt GDevelop 5 Engine vs Unity, Godot, or Unreal** | Historical engine-platform selection | `Superseded by ADR-006` | `2026-07-16` |
| [ADR-005](file:///c:/LeDucLuong/Plant%20Tales/Docs/09_Architecture_Decisions/ADR-005_Data_First_Gameplay.md) | **Adopt Data-First Gameplay Execution vs Hardcoded Logic** | Identity-agnostic event execution across all 8 modules | `Accepted` | `2026-07-16` |
| [ADR-006](ADR-006_Migrate_Runtime_From_GDevelop_To_Godot.md) | **Migrate Runtime from GDevelop to Godot** | Parallel runtime reimplementation and migration governance | `Accepted` | `2026-07-17` |

---

## 3.1 Known Governance Debt

`ADR-005` is duplicated: this registry owns `ADR-005_Data_First_Gameplay.md`, while
`Docs/Architecture/ADR-005_Dependency_Rules.md` uses the same identifier in a
separate directory. The duplication is recorded as governance debt. Historical ADRs
must not be renumbered during M4.3A; a dedicated ADR-governance cleanup will decide
the remediation. ADR-006 is the next unique identifier in this registry.

---

## 4. Quy Trình Ban Hành ADR Mới (`How to Add an ADR`)

Khi một lập trình viên hoặc AI Agent đối diện với một bài toán yêu cầu thay đổi kiến trúc, thêm Singleton mới hoặc chỉnh sửa ranh giới Module, quy trình 4 bước bắt buộc sau phải diễn ra:
1. **Dùng biểu mẫu chuẩn:** Copy mẫu từ [Docs/Templates/ADR_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/ADR_Template.md).
2. **Soạn thảo đầy đủ 6 phần:** `Title/Status`, `Context & Problem`, `Decision`, `Alternatives Considered`, `Trade-offs`, `Consequences (Positive/Negative/Risks)`.
3. **Trình Technical Director duyệt:** Chỉ khi chuyển trạng thái sang `Accepted` mới được phép bắt tay viết code thực thi.
4. **Cập nhật Bảng Registry:** Ghi thêm mã `ADR-XXX` mới vào bảng tại tài liệu `README.md` này.
