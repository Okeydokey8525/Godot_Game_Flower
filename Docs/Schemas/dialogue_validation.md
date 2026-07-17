# Dialogue Schema Validation Rules (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Target Schema:** [dialogue_schema.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/dialogue_schema.md)  
**Enforcement:** Evaluated by `ContentManagerSystem` during boot-up validation (`ValidateDialogueDefinitions`).

---

## 1. Structural & Metadata Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_DLG_001** | `schema_version` | MUST be `integer >= 1`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_DLG_002** | `id` | MUST be non-empty string prefixed with `dialogue_`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_DLG_003** | `display_name` | MUST be non-empty string. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_DLG_004** | `author` | MUST be non-empty string. | `WARN` | Inject `"Narrative Team"`. |
| **VAL_DLG_005** | `last_modified` | MUST be string matching `YYYY-MM-DD`. | `WARN` | Inject system date. |
| **VAL_DLG_006** | `tags` | MUST be array containing >= 1 string. | `WARN` | Inject `["dialogue"]`. |

---

## 2. Gameplay & Line Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_DLG_101** | `speaker` | MUST be non-empty string prefixed with `npc_`. | `ERROR` | Log error: `"invalid speaker reference"`; skip file. |
| **VAL_DLG_102** | `lines` | MUST be array containing `>= 1` line objects. | `ERROR` | Log error: `"dialogue contains 0 lines"`; skip file. |
| **VAL_DLG_103** | `lines[i].text` | Every line object MUST have non-empty `"text"` string. | `ERROR` | Log error: `"dialogue line missing text"`; skip file. |
| **VAL_DLG_104** | `conditions` | If present, MUST be array of condition objects. | `WARN` | Ignore invalid conditions. |
| **VAL_DLG_105** | `next` | If present, MUST be string. | `WARN` | Reset to `""`. |
| **VAL_DLG_106** | `rewards` | If present, MUST be array of reward objects (`item_id, count`). | `WARN` | Ignore malformed reward entries. |
