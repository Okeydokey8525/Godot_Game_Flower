# Designer Authoring & Verification Workflow (`M4.1B+ Quality Gate`)

**Target Audience:** Game Designers, Content Writers, and Narrative Artists  
**Goal:** Create, validate, and test new game content (`Flowers`, `NPCs`, `Dialogues`, `Quests`) without writing or touching any GDevelop code.

---

## 1. The 60-Second Content Authoring Workflow

### Step 1: Copy a Template
Open `Source/Content/Templates/` and copy the template matching your target content type:
- `flower_template.json`
- `npc_template.json`
- `dialogue_template.json`
- `quest_template.json`

### Step 2: Rename & Save into Target Folder
Save your copied file into the respective active folder under `Source/Content/`:
- Example: Save as `Source/Content/Flowers/sunflower.json`

### Step 3: Customize Parameters
Open your new JSON file in VS Code or any text editor and adjust fields:
```json
{
  "schema_version": 1,
  "id": "flower_sunflower",
  "display_name": "Golden Sunflower",
  "growth_time": 1800,
  "seed_item": "seed_sunflower",
  "yield_item": "flower_sunflower",
  "sprite": "flower_sunflower.png",
  "sell_price": 120
}
```

### Step 4: Register in Manifest
Open `Source/Content/content_manifest.json` and add your filename to the corresponding list:
```json
"flowers": [
  "white_lily.json",
  "sunflower.json"
]
```

### Step 5: Boot & Check Report (`Zero Code Touch`)
Launch the game prototype (`or check the validation logs`). The engine automatically:
1. Loads `sunflower.json` into memory (`g_ContentRegistry.flowers.flower_sunflower`).
2. Checks cross-references (`seed_sunflower`) and reports missing assets cleanly.
3. Outputs verification summary to `Source/Data/Reports/Content_Validation_Report.txt`.

---

## 2. Reading the Validation Report (`Instant Feedback`)
If your file has a typo (`e.g., duplicate ID or missing growth_time`), the validation report immediately highlights it:
```text
Content Validation Report
=========================
Errors: 1
Duplicate ID: flower_white_lily found in sunflower.json — SKIPPED
```
No game crashes. No developer assistance required. You fix the typo, hit save, and your content is live!
