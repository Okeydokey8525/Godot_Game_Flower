# NPC Schema Validation Rules (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Target Schema:** [npc_schema.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/npc_schema.md)  
**Enforcement:** Evaluated by `ContentManagerSystem` during boot-up validation (`ValidateNPCDefinitions`).

---

## 1. Structural & Metadata Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_NPC_001** | `schema_version` | MUST be `integer >= 1`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_NPC_002** | `id` | MUST be non-empty string prefixed with `npc_`. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_NPC_003** | `display_name` | MUST be non-empty string. | `ERROR` | Log error; skip file from `g_ContentRegistry`. |
| **VAL_NPC_004** | `author` | MUST be non-empty string. | `WARN` | Inject `"Narrative Team"`. |
| **VAL_NPC_005** | `last_modified` | MUST be string matching `YYYY-MM-DD`. | `WARN` | Inject system date. |
| **VAL_NPC_006** | `tags` | MUST be array containing >= 1 string. | `WARN` | Inject `["npc"]`. |

---

## 2. Gameplay & Reference Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_NPC_101** | `portrait` | MUST be non-empty string ending in `.png`. | `ERROR` | Log error: `"missing portrait definition"`; skip file. |
| **VAL_NPC_102** | `default_schedule` | MUST be object containing `"default"` sub-object with `x, y, scene`. | `ERROR` | Log error: `"npc missing default_schedule coordinates"`; skip file. |
| **VAL_NPC_103** | `dialogue_root` | MUST be non-empty string prefixed with `dialogue_`. | `ERROR` | Log error: `"missing dialogue_root reference"`; skip file. |
| **VAL_NPC_104** | `likes` | If present, MUST be array of strings. | `WARN` | Ignore invalid entries or reset to `[]`. |
| **VAL_NPC_105** | `dislikes` | If present, MUST be array of strings. | `WARN` | Ignore invalid entries or reset to `[]`. |
| **VAL_NPC_106** | `birthday` | If present, MUST match `"(Spring|Summer|Autumn|Winter) [1-9][0-9]*"` regex. | `WARN` | Reset to `""`. |
