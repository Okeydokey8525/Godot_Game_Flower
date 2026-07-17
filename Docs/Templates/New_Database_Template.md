# Static JSON Schema Specification: `Source/Data/Static/[schema_name].json`

**Schema Name:** `[schema_name]`
**Authoritative Owner Module:** `Core Module XX — [Module Name]`
**Version:** `1.0.0`

---

## 1. JSON Schema Structure (`Strict Data Boundary`)
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "[SchemaTitle]",
  "type": "object",
  "required": ["id", "name", "category"],
  "properties": {
    "id": {
      "type": "string",
      "pattern": "^[a-z0-9_]+$",
      "description": "Unique identifier in snake_case"
    },
    "name": {
      "type": "string",
      "description": "Display name localization key or string"
    },
    "category": {
      "type": "string",
      "enum": ["seed", "flower", "tool", "key"]
    }
  }
}
```

---

## 2. Validation & Registration Protocol
- [ ] ID tuân thủ tuyệt đối định dạng `snake_case` không khoảng trắng, không ký tự đặc biệt.
- [ ] Đã đăng ký vào bảng `Master Ownership Matrix` tại `10_Module_Architecture.md`.
- [ ] Đã kiểm thử cú pháp JSON không có dấu phẩy thừa (`Trailing Comma verification`).
