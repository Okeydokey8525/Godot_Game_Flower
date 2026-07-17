### 📋 [AI HANDOFF PROTOCOL REPORT]
**Agent Executing:** [Tên AI Agent: Antigravity / Codex / Claude / ChatGPT]
**Task Title:** [Tên nhiệm vụ vừa hoàn thành]
**Execution Status:** `SUCCESS` / `PARTIAL` / `BLOCKED_NEED_DIRECTOR`

#### 1. Executive Summary
- [Tóm tắt gọn gàng 2-3 câu về những gì đã thực thi và hoàn thành trong phiên làm việc]

#### 2. Files Created / Modified
- `[NEW]` [Source/path/to/file.json](file:///path/to/file) *(Giải thích ngắn vai trò)*
- `[MODIFY]` [Source/path/to/file.json](file:///path/to/file) *(Giải thích những thay đổi chính)*

#### 3. Architecture & Schema Impact
- **Database / Schema Changes:** [Khung mô tả thay đổi field tĩnh hoặc `None`]
- **Persistence / Save Changes:** [Khung mô tả thêm field save/migration hoặc `None`]
- **Event Bus Signals Added:** `[SignalNamePastTense]` / `None`

#### 4. Authoritative Registry Additions (`New IDs`)
- `id_key`: `id_value`

#### 5. Breaking Changes & Compatibility Warnings
- `None` / `[Ghi rõ chi tiết nếu có breaking change]`

#### 6. Risk Level Assessment
- `LOW` *(Chỉ thêm logic độc lập / tài liệu)* / `MEDIUM` / `HIGH` / `CRITICAL`

#### 7. Architecture Decision Log (`ADR — Decision Log`) ⭐
- **AD-XXX:** `[Tên quyết định kỹ thuật vừa đưa ra]`
  - **Reason:** `[Lý do kỹ thuật WHY]`
  - **Trade-off:** `[Sự đánh đổi về hiệu năng / bộ nhớ / độ phức tạp]`

#### 8. Deferred Decisions (`Quyết định hoãn lại`)
- **Deferred Feature:** `[Tính năng tạm gác]` (`Reason & Target Milestone`)

#### 9. Technical Debt Register (`Sổ đăng ký nợ kỹ thuật`)
- **Known Debt:** `[Tên khoản nợ kỹ thuật chấp nhận tạm thời]` (`Status & Target Fix Milestone`)

#### 10. Architecture Compliance Score (`Tự chấm điểm tuân thủ`)
- **Overall Architecture Score:** `100% Compliance` (Coding, Folder, Data, AI, QA, Module)

#### 11. Time & Dependency Impact
- **Estimated Review Time:** `X min` | **Affected Modules:** `[...]`

#### 12. Rollback Strategy (`Phương án khẩn cấp khi hỏng`)
- **Rollback Steps:** `1. Delete new file -> 2. Restore JSON -> 3. Revert git commit`

#### 13. Next Recommended Task for Subsequent AI Agent
- **Priority Next Step:** [Chỉ rõ chính xác file và nhiệm vụ tiếp theo cần làm để AI sau bắt tay vào ngay]
- **Key Constraints to Watch:** [Lưu ý kỹ thuật đặc biệt dành cho AI nhận ca tiếp theo]
