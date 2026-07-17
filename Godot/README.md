# Plant Tales Godot Runtime

This is the new parallel Godot runtime for Plant Tales. The repository's `Source/`
directory remains the preserved GDevelop behavioral reference and is not converted or
edited by the Godot migration.

## M4.3A.2 content pipeline

- **Godot:** 4.7.1 Standard x86_64
- **Language:** GDScript
- **Renderer:** Compatibility
- **Main scene:** `scenes/boot/boot.tscn`
- **Current phase:** M4.3A.2 - Content Pipeline Parity

`Source/Content/` is the canonical authoring source. The committed
`Godot/data/content/` directory is a generated runtime copy for `res://` access.
Never manually edit generated runtime content; use the sync tool and review its Git
diff instead.

`ContentRegistry` verifies generated metadata, manifest ordering, destination hashes,
JSON parsing, minimal identity contracts, the evidence-supported canonical
`integer:1` schema representation (read as numeric `1` by Godot JSON), and a small
set of confirmed references. Full JSON Schema, asset,
semantic, economy, and gameplay validation remain offline-only.

Gameplay, save/load, telemetry, performance capture, and the Greenhouse vertical
slice are not implemented in this phase.

## Commands

```powershell
$editor = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64.exe"
$console = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64_console.exe"
$python = "C:\Users\leduc\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

& $python tools/sync_godot_content.py --sync
& $python tools/sync_godot_content.py --check
& $editor --editor --path "C:\LeDucLuong\Plant Tales\Godot"
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --editor --quit
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --quit-after 10
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --script res://tests/content_pipeline_test.gd
```

The metadata hash inventory proves source/destination synchronization consistency only;
it is not a cryptographic signature or anti-tampering mechanism.
