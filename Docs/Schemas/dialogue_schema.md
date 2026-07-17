# Dialogue Schema Reference (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Associated Validation Rules:** [dialogue_validation.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/dialogue_validation.md)  
**Target Directory:** `Source/Content/Dialogues/*.json`

---

## 1. Structure Overview

Every dialogue definition defines a conversation tree or single line exchange spoken by an NPC. `DialogueSystem` reads this schema to display typewriter text, check branching conditions, and emit state transition triggers.

---

## 2. Common Metadata Fields (`Required on ALL Schemas`)

| Field Name | Type | Required? | Description | Example |
| :--- | :--- | :---: | :--- | :--- |
| **`schema_version`** | `integer` | ✅ **Yes** | Schema specification version integer (`>= 1`). | `1` |
| **`id`** | `string` | ✅ **Yes** | Unique lowercase identifier. MUST prefix with `dialogue_`. | `"dialogue_thomas_intro"` |
| **`display_name`** | `string` | ✅ **Yes** | Friendly descriptive title. | `"Thomas Tutorial Intro"` |
| **`author`** | `string` | ✅ **Yes** | Name of authoring designer or engineer. | `"Narrative Team"` |
| **`last_modified`** | `string` | ✅ **Yes** | Date string formatted as `YYYY-MM-DD`. | `"2026-07-17"` |
| **`tags`** | `array of strings` | ✅ **Yes** | Categorical labels. | `["tutorial", "intro"]` |

---

## 3. Gameplay Fields

### Required Fields
| Field Name | Type | Description | Valid Rules |
| :--- | :--- | :--- | :--- |
| **`speaker`** | `string` | ID of the NPC speaking these lines. | MUST exactly match an NPC ID (`e.g., "npc_thomas"`) |
| **`lines`** | `array of objects` | Ordered sequence of dialogue line nodes. | MUST contain `>= 1` line object (`each having "text" string`) |

### Optional Fields (`Root & Line Level`)
| Field Name | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **`conditions`** | `array of objects` | `[]` | Prerequisites to trigger this dialogue (`e.g., [{"ftue_state": "STATE_0_GREETING"}]`). |
| **`next`** | `string` | `""` | ID of the next dialogue tree or state to chain immediately after the last line. |
| **`rewards`** | `array of objects` | `[]` | Items/gold awarded when dialogue finishes (`e.g., [{"item_id": "seed_white_lily", "count": 10}]`). |
| **`flags`** | `array of strings` | `[]` | Global state flags set when completed (`e.g., ["tutorial_seed_received"]`). |
