# Quest Schema Validation Rules (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Target Schema:** [quest_schema.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/quest_schema.md)  
**Enforcement:** Evaluated by `ContentManagerSystem` during boot-up validation (`ValidateQuestDefinitions`).

---

## 1. Structural & Metadata Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_QST_001** | `schema_version` | MUST be `integer >= 1`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_QST_002** | `id` | MUST be non-empty string prefixed with `quest_`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_QST_003** | `display_name` | MUST be non-empty string. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_QST_004** | `author` | MUST be non-empty string. | `WARN` | Inject `"Design Team"`. |
| **VAL_QST_005** | `last_modified` | MUST be string matching `YYYY-MM-DD`. | `WARN` | Inject system date. |
| **VAL_QST_006** | `tags` | MUST be array containing >= 1 string. | `WARN` | Inject `["quest"]`. |

---

## 2. Gameplay & Objective Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_QST_101** | `title` | MUST be non-empty string. | `ERROR` | Log error: `"quest missing title"`; skip file. |
| **VAL_QST_102** | `steps` | MUST be array containing `>= 1` step objects. | `ERROR` | Log error: `"quest contains 0 steps"`; skip file. |
| **VAL_QST_103** | `steps[i].target_id` | Every step MUST define `target_id` and `count > 0`. | `ERROR` | Log error: `"invalid step definition"`; skip file. |
| **VAL_QST_104** | `completion` | MUST be object containing `npc_id` or `auto_complete = true`. | `ERROR` | Log error: `"missing completion condition"`; skip file. |
| **VAL_QST_105** | `rewards` | If present, MUST be array of reward objects. | `WARN` | Ignore malformed reward entries. |
| **VAL_QST_106** | `repeatable` | If present, MUST be boolean. | `WARN` | Reset to `false`. |
| **VAL_QST_107** | `dependencies` | If present, MUST be array of valid quest ID strings. | `WARN` | Ignore invalid dependency strings. |
