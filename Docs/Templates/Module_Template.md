# Core Module XX: [Module Name] (`Short Subtitle`)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        [MODULE NAME] CONTRACT                          │
├────────────────────────────────────────────────────────────────────────┤
│ Purpose: [Mô tả gọn 1 câu về sứ mệnh chính của module này]             │
└────────────────────────────────────────────────────────────────────────┘
```

- **1. Purpose:** [Vai trò cốt lõi và sứ mệnh của module trong hệ sinh thái Plant Tales].
- **2. Responsibilities:**
  - [Trách nhiệm 1]
  - [Trách nhiệm 2]
  - [Trách nhiệm 3]
- **3. Owns (`Data Schemas & Instances`):**
  - Cấu trúc tĩnh: `[SchemaName]` (`key_1`, `key_2`, `key_3`).
  - Đối tượng runtime: `[InstanceName]` (`prop_1`, `prop_2`).
- **4. Reads (`Read-only from upstream`):**
  - `[OtherModule.property_or_api]`
- **5. Writes (`Strictly self-owned only`):**
  - [Các thuộc tính độc quyền mà module được phép ghi].
- **6. Publishes (`Signal Bus Events Emitted`):**
  - `[SignalNamePastTense] (param_1, param_2)`
- **7. Consumes (`Signal Bus Events Listened`):**
  - `[ExternalSignalName]` ➔ [Hành vi xử lý đáp trả].
- **8. Dependencies:**
  - **Upstream (`Phụ thuộc vào`):** `[UpstreamModules]`
  - **Downstream (`Được phụ thuộc bởi`):** `[DownstreamModules]`
- **9. Public API (`External Callable Functions`):**
  - `[ModuleName]_Function(param)` ➔ ReturnType.
- **10. Forbidden (`Absolute Red Lines`):**
  - ❌ [Giới hạn đỏ 1: cấm vi phạm sở hữu chéo].
  - ❌ [Giới hạn đỏ 2: cấm frame polling nặng].
- **11. Performance Budget:**
  - **CPU Frame Time:** `< X.X ms` runtime.
  - **RAM Allocation:** `< XX MB`.
- **12. Lifecycle:**
  - **Boot:** [Hành vi khởi tạo tĩnh].
  - **Scene Load:** [Hành vi nạp scene & phân bổ instance].
  - **Save Hook:** [Hành vi cung cấp DTO cho SaveManager].
- **13. AI Extension Rules:**
  - [Quy định cụ thể cách AI mở rộng module này an toàn].
