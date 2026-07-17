# Plant Tales Godot Runtime

This is the parallel Godot runtime for Plant Tales. `Source/` remains the preserved
GDevelop behavioral reference; it is not converted or edited by this migration.

## M4.3A.3 Greenhouse Gameplay Vertical Slice

- **Godot:** 4.7.1 Standard x86_64 / GDScript / Compatibility renderer
- **Main scene:** `scenes/boot/boot.tscn`
- **Flow:** Boot → ContentRegistry → Greenhouse → White Lily lifecycle
- **Canonical data:** `Source/Content/` authors; committed `data/content/` runs under `res://`.

### M4.3A.3_VERTICAL_SLICE_RULE

This is **not final production farming design**. One plot supports only:

```text
EMPTY → PLANTED_DRY → GROWING → BLOOMED → EMPTY after harvest
```

Planting is dry and cannot grow. One water action enables growth for the entire
lifecycle. There is no moisture evaporation, repeat watering, weather effect, seed
consumption, stamina, inventory result, gold, quest, or economy update.

`GameClock` starts at Day 1, 06:00. Normal gameplay advances at 10 gameplay minutes
per real second. White Lily reads canonical `growth_time: 1080`, so normal bloom is
108 real seconds. `Debug: Advance Time` is visible only in debug builds and never
changes canonical clock speed or content data.

`GameClock` owns time; `PlantingPlot` owns one `FlowerInstance`; `Greenhouse` owns UI
coordination. Direct local signals are used—there is no global EventBus in this slice.

## Commands

```powershell
$editor = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64.exe"
$console = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64_console.exe"
$python = "C:\Users\leduc\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

& $python tools/sync_godot_content.py --check
& $editor --editor --path "C:\LeDucLuong\Plant Tales\Godot"
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --editor --quit
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --quit-after 30
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --script res://tests/greenhouse_vertical_slice_test.gd
```

ContentRegistry still owns validated definitions only. Full schema, assets, economy,
and gameplay parity remain outside this vertical slice.
