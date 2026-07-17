# NPC Schema Reference (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Associated Validation Rules:** [npc_validation.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/npc_validation.md)  
**Target Directory:** `Source/Content/NPCs/*.json`

---

## 1. Structure Overview

Every NPC definition defines a character living in the village or visiting the greenhouse. `NPCSystem` reads this schema to initialize portraits, coordinates, dialogue entry points, and gift preferences.

---

## 2. Common Metadata Fields (`Required on ALL Schemas`)

| Field Name | Type | Required? | Description | Example |
| :--- | :--- | :---: | :--- | :--- |
| **`schema_version`** | `integer` | ✅ **Yes** | Schema specification version integer (`>= 1`). | `1` |
| **`id`** | `string` | ✅ **Yes** | Unique lowercase identifier. MUST prefix with `npc_`. | `"npc_thomas"` |
| **`display_name`** | `string` | ✅ **Yes** | Friendly full name displayed in dialogue boxes. | `"Thomas the Elder"` |
| **`author`** | `string` | ✅ **Yes** | Name of authoring designer or engineer. | `"Narrative Designer"` |
| **`last_modified`** | `string` | ✅ **Yes** | Date string formatted as `YYYY-MM-DD`. | `"2026-07-17"` |
| **`tags`** | `array of strings` | ✅ **Yes** | Categorical search labels. | `["elder", "tutorial"]` |

---

## 3. Gameplay Fields

### Required Fields
| Field Name | Type | Description | Valid Rules |
| :--- | :--- | :--- | :--- |
| **`portrait`** | `string` | Filename of default dialogue portrait image. | MUST be an existing resource (`e.g., "portrait_thomas_normal.png"`) |
| **`default_schedule`** | `object` | Key-value mapping of hour/location schedule. | At minimum MUST contain `"default"` point (`e.g., {"default": {"x": 416, "y": 192, "scene": "GreenhouseScene"}}`) |
| **`dialogue_root`** | `string` | ID of the initial dialogue definition file to trigger on interaction. | MUST match a dialogue ID (`e.g., "dialogue_thomas_intro"`) |

### Optional Fields
| Field Name | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **`likes`** | `array of strings` | `[]` | List of item/flower IDs awarded `+2` relationship points when gifted. |
| **`dislikes`** | `array of strings` | `[]` | List of item IDs that lower relationship `-1` point when gifted. |
| **`birthday`** | `string` | `""` | Season and day (`e.g., "Spring 4"`). Gifting on birthday yields `3x` points. |
| **`relationship_events`** | `array of objects` | `[]` | List of cutscene triggers at specific heart levels (`e.g., [{"hearts": 2, "dialogue_id": "dialogue_thomas_heart2"}]`). |
