# Quest Schema Reference (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Associated Validation Rules:** [quest_validation.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/quest_validation.md)  
**Target Directory:** `Source/Content/Quests/*.json`

---

## 1. Structure Overview

Every quest definition describes a task, request, or long-term objective. `QuestSystem` reads this schema to track completion steps, evaluate shipping/harvest conditions, and grant rewards upon turn-in.

---

## 2. Common Metadata Fields (`Required on ALL Schemas`)

| Field Name | Type | Required? | Description | Example |
| :--- | :--- | :---: | :--- | :--- |
| **`schema_version`** | `integer` | ✅ **Yes** | Schema specification version integer (`>= 1`). | `1` |
| **`id`** | `string` | ✅ **Yes** | Unique lowercase identifier. MUST prefix with `quest_`. | `"quest_001_lily_request"` |
| **`display_name`** | `string` | ✅ **Yes** | Friendly quest title shown in journal / request board. | `"Greenhouse Restoration"` |
| **`author`** | `string` | ✅ **Yes** | Name of authoring designer or engineer. | `"Design Lead"` |
| **`last_modified`** | `string` | ✅ **Yes** | Date string formatted as `YYYY-MM-DD`. | `"2026-07-17"` |
| **`tags`** | `array of strings` | ✅ **Yes** | Categorical search labels. | `["tutorial", "starter"]` |

---

## 3. Gameplay Fields

### Required Fields
| Field Name | Type | Description | Valid Rules |
| :--- | :--- | :--- | :--- |
| **`title`** | `string` | UI display title header. | MUST be non-empty string |
| **`steps`** | `array of objects` | Ordered list of objective steps (`e.g., [{"type": "Harvest", "target_id": "flower_white_lily", "count": 1}]`). | MUST contain `>= 1` step object |
| **`completion`** | `object` | Turn-in requirements (`e.g., {"npc_id": "npc_thomas", "dialogue_on_complete": "dialogue_quest001_done"}`). | MUST contain `"npc_id"` or `"auto_complete"` |

### Optional Fields
| Field Name | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **`rewards`** | `array of objects` | `[]` | Items/gold granted upon quest completion (`e.g., [{"gold": 150}, {"item_id": "seed_rose", "count": 2}]`). |
| **`repeatable`** | `boolean` | `false` | If `true`, quest resets daily/weekly for re-completion. |
| **`season`** | `string` | `"All"` | Season prerequisite (`"Spring"`, `"Summer"`, `"Autumn"`, `"Winter"`, or `"All"`). |
| **`dependencies`** | `array of strings` | `[]` | Prerequisite quest IDs that must be completed before accepting (`e.g., ["quest_001_lily_request"]`). |
