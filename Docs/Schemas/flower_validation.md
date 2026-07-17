# Flower Schema Validation Rules (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Target Schema:** [flower_schema.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/flower_schema.md)  
**Enforcement:** Evaluated by `ContentManagerSystem` during boot-up validation (`ValidateFlowerDefinitions`).

---

## 1. Structural & Type Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_FLW_001** | `schema_version` | MUST be `integer >= 1`. | `ERROR` | Log error string to console; skip file from `g_ContentRegistry`. |
| **VAL_FLW_002** | `id` | MUST be non-empty string prefixed with `flower_` and matching filename prefix. | `ERROR` | Log error string to console; skip file from `g_ContentRegistry`. |
| **VAL_FLW_003** | `display_name` | MUST be non-empty string. | `ERROR` | Log error string to console; skip file from `g_ContentRegistry`. |
| **VAL_FLW_004** | `author` | MUST be non-empty string. | `WARN` | Inject `"Unknown"` as default author. |
| **VAL_FLW_005** | `last_modified` | MUST be string matching `YYYY-MM-DD` regex. | `WARN` | Inject current system date. |
| **VAL_FLW_006** | `tags` | MUST be an array containing at least 1 string tag. | `WARN` | Inject `["flower"]` as default tag. |

---

## 2. Gameplay & Numeric Rules

| Rule ID | Field | Condition / Assertion | Error Severity | Engine Behavior if Failed |
| :---: | :--- | :--- | :---: | :--- |
| **VAL_FLW_101** | `growth_time` | MUST be `integer > 0`. | `ERROR` | Log error: `"flower growth_time must be > 0"`; skip file. |
| **VAL_FLW_102** | `seed_item` | MUST be non-empty string prefixed with `seed_`. | `ERROR` | Log error: `"invalid seed_item reference"`; skip file. |
| **VAL_FLW_103** | `yield_item` | MUST be non-empty string (`item ID or flower ID`). | `ERROR` | Log error: `"invalid yield_item reference"`; skip file. |
| **VAL_FLW_104** | `sprite` | MUST be non-empty string ending in `.png`. | `ERROR` | Log error: `"missing sprite definition"`; skip file. |
| **VAL_FLW_105** | `sell_price` | If present, MUST be `integer >= 0`. | `WARN` | Clamp negative numbers to `0`. |
| **VAL_FLW_106** | `rarity` | If present, MUST be one of `["Common", "Uncommon", "Rare", "Legendary"]`. | `WARN` | Fallback to `"Common"`. |
| **VAL_FLW_107** | `favorite_season` | If present, MUST be one of `["Spring", "Summer", "Autumn", "Winter", "All"]`. | `WARN` | Fallback to `"All"`. |
