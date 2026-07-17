# Plant Tales Godot Runtime

This directory is the new parallel Godot runtime for Plant Tales. The existing
`Source/` directory remains the preserved GDevelop behavioral reference and must not
be converted or edited as part of M4.3A.1.

## Runtime foundation

- **Godot:** 4.7.1 Standard x86_64
- **Language:** GDScript
- **Renderer:** Compatibility
- **Main scene:** `scenes/boot/boot.tscn`
- **Current phase:** M4.3A.1 — Godot Bootable Skeleton

This phase proves only project configuration, AppState autoload initialization, and
the Boot scene. Content loading, gameplay, save/load, telemetry, performance capture,
and the Greenhouse vertical slice are not implemented.

`Source/Content/` remains canonical but has not been synchronized into this Godot
project. Do not manually copy or edit canonical content during this phase.

## Commands

```powershell
$editor = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64.exe"
$console = "C:\Tools\Godot\4.7.1\Godot_v4.7.1-stable_win64.exe\Godot_v4.7.1-stable_win64_console.exe"

& $editor --editor --path "C:\LeDucLuong\Plant Tales\Godot"
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --editor --quit
& $console --headless --path "C:\LeDucLuong\Plant Tales\Godot" --quit-after 10
```
