# Flower Schema Reference (`v1.0.0`)

**Status:** Approved (`Sprint M4.1B`)  
**Associated Validation Rules:** [flower_validation.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/Schemas/flower_validation.md)  
**Target Directory:** `Source/Content/Flowers/*.json`

---

## 1. Structure Overview

Every flower definition describes a growable crop in Plant Tales. When a seed is planted, `FlowerSystem` reads this schema to determine growth duration, sprite rendering, and harvest rewards.

Time storage and conversions are governed solely by the [Time Convention](../Architecture/Time_Convention.md). `growth_time_minutes` is a legacy read-compatibility alias, not a schema field for new content.

---

## 2. Common Metadata Fields (`Required on ALL Schemas`)

| Field Name | Type | Required? | Description | Example |
| :--- | :--- | :---: | :--- | :--- |
| **`schema_version`** | `integer` | ✅ **Yes** | Schema specification version integer (`>= 1`). | `1` |
| **`id`** | `string` | ✅ **Yes** | Unique lowercase identifier. MUST prefix with `flower_`. | `"flower_white_lily"` |
| **`display_name`** | `string` | ✅ **Yes** | Friendly name shown in tooltips, satchel, and UI. | `"White Lily"` |
| **`author`** | `string` | ✅ **Yes** | Name of authoring designer or engineer. | `"Designer"` |
| **`last_modified`** | `string` | ✅ **Yes** | Date string formatted as `YYYY-MM-DD`. | `"2026-07-17"` |
| **`tags`** | `array of strings` | ✅ **Yes** | Categorical search labels for grouping and AI filtering. | `["spring", "starter"]` |

---

## 3. Gameplay Fields

### Required Fields
| Field Name | Type | Description | Valid Range / Rules |
| :--- | :--- | :--- | :--- |
| **`growth_time`** | `integer` | Total game simulation minutes needed from sprout to full bloom (`Bloom`). | `> 0` (`e.g., 1080 for 18h, 1440 for 24h`) |
| **`seed_item`** | `string` | ID of the seed item required to plant this flower. | MUST exactly match an item ID (`e.g., "seed_white_lily"`) |
| **`yield_item`** | `string` | ID of the item granted to inventory when harvested. | MUST match an item ID or self ID (`e.g., "flower_white_lily"`) |
| **`sprite`** | `string` | Filename of the fully grown (`Bloom`) sprite asset. | MUST be an existing resource (`e.g., "flower_white_lily.png"`) |

### Optional Fields
| Field Name | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **`description`** | `string` | `""` | Lore / satchel description string displayed when examined. |
| **`rarity`** | `string` | `"Common"` | Tier classification: `"Common"`, `"Uncommon"`, `"Rare"`, `"Legendary"`. |
| **`sell_price`** | `integer` | `0` | Direct gold value when shipped via `ShippingBinObject`. |
| **`festival_bonus`** | `integer` | `0` | Extra bonus gold awarded if harvested or shipped during village festivals. |
| **`favorite_season`** | `string` | `"All"` | Optimal growing season (`"Spring"`, `"Summer"`, `"Autumn"`, `"Winter"`, or `"All"`). |
