# Studio Templates Repository (`Docs/Templates/`)

**Bộ biểu mẫu chuẩn hóa chính thức dành cho con người và AI Agents trong toàn bộ chu trình phát triển Plant Tales.**

---

## 1. Mục Đích & Triết Lý Biểu Mẫu (`Why Templates?`)

Để đảm bảo tính nhất quán tuyệt đối khi dự án được thực thi bởi nhiều kỹ sư và các AI Agent khác nhau (`Codex`, `Claude`, `ChatGPT`, `Antigravity`), **mọi tài liệu mới sinh ra trong dự án BUỘC PHẢI dựa trên biểu mẫu có sẵn trong thư mục này**.

Việc chuẩn hóa biểu mẫu giúp:
- Ngăn chặn tình trạng AI tự do phóng tác cấu trúc tài liệu.
- Giảm thiểu thời gian viết báo cáo, tập trung vào nội hàm kỹ thuật.
- Tạo đường ống tự động kiểm định (`Automated Auditing`) cho các công cụ CI/CD tương lai.

---

## 2. Danh Mục Biểu Mẫu Chuẩn (`Master Template Directory`)

| Tên Biểu Mẫu (`Template Name`) | File Đường Dẫn (`Path`) | Sử Dụng Khi Nào (`When To Use?`) |
| --- | --- | --- |
| **ADR Template** | [ADR_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/ADR_Template.md) | Khi ban hành một quyết định kiến trúc mới tại `Docs/09_Architecture_Decisions/`. |
| **Module Contract Template** | [Module_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/Module_Template.md) | Khi khai báo và mở rộng một Core Module mới (`10_Module_Architecture.md`). |
| **Feature Request Template** | [Feature_Request_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/Feature_Request_Template.md) | Khi Game Designer đề xuất một tính năng gameplay hoặc UI mới. |
| **Handoff Protocol Template**| [Handoff_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/Handoff_Template.md) | Khi AI Agent hoặc kỹ sư hoàn thành một task và nộp báo cáo chuyển ca. |
| **Bug Report Template** | [Bug_Report_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/Bug_Report_Template.md) | Khi phát hiện và báo cáo một lỗi kỹ thuật (`BR-XXX`). |
| **Pull Request Template** | [PR_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/PR_Template.md) | Khi nộp một nhánh code lên repository chuẩn bị merge (`Exit Gate`). |
| **New System Template** | [New_System_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/New_System_Template.md) | Khi tạo mới một Event Sheet hệ thống trong `Source/Systems/`. |
| **New Database Template** | [New_Database_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/New_Database_Template.md) | Khi khai báo cấu trúc Schema JSON tĩnh mới tại `03_Data_Architecture.md`. |
| **Event Sheet Template** | [Event_Template.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Templates/Event_Template.md) | Khi xây dựng các khối sự kiện GDevelop (Header comment, Signal, Pool hook). |
