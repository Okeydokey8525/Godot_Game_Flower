# ADR-006: Migrate Runtime from GDevelop to Godot

**Status:** `Accepted`  
**Date:** `2026-07-17`  
**Deciders:** Game Director, Technical Director, Lead Gameplay Architect  
**Supersedes:** [ADR-004_Why_GDevelop_Engine.md](ADR-004_Why_GDevelop_Engine.md)

---

## Context

The Engine Reality Audit found that the repository currently contains a GDevelop 5
folder-project source: `Source/game.json`, layouts, objects, and external-event JSON.
No Godot project, Godot scene, or executable Godot script exists. GDevelop source is
therefore retained as the historical and behavioral reference, but it is no longer the
target production runtime.

The original decision in ADR-004 was appropriate for the project at the time. The
Technical Director has now approved a production-engine change to Godot. This is an
intentional runtime reimplementation, not a JSON format conversion or a search-and-
replace of engine terminology.

## Decision

Plant Tales will create a new runtime in parallel under `Godot/`.

- **Target production runtime:** Godot 4.7.1 Standard x86_64.
- **Implementation language:** GDScript.
- **Initial renderer:** Compatibility.
- **Initial target:** Windows desktop debug build.
- **Current runtime source:** GDevelop 5 folder-project source, preserved read-only.
- **Migration type:** Parallel runtime reimplementation.

The Godot project does not exist at acceptance of this ADR. Its first executable goal
is a minimal Greenhouse vertical slice, not full system or visual parity.

## Retained and rewritten boundaries

The canonical `Source/Content/` JSON, schemas, balance rules, economy targets, ROI
anchors, telemetry specifications, Python validation/simulation tools, design rules,
and save-data concepts remain valid where engine-independent. Schema v1.0.0-STABLE
and economy values remain frozen.

`Source/game.json`, `Source/Scenes/`, `Source/Objects/`, `Source/Core/`, and
`Source/Systems/` are GDevelop runtime assets. Godot must reimplement their behavior:
scene lifecycle, global state, content loading, input, interaction, time, flower
lifecycle, inventory, save/load, telemetry, debugging, and performance capture.

Existing GDevelop save fixtures are behavioral references only. Direct save import is
not required for the first Godot vertical slice.

## Canonical content strategy

`Source/Content/` remains the sole authoring source. A future deterministic process
will validate the manifest, file presence, ordered entries, and hashes before copying
to generated `Godot/data/content/`. Godot runtime code will read only the packaged
`res://data/content/` copy. Generated files must never be edited manually and may be
deleted and regenerated.

## Migration phases and validation gates

1. **M4.3A.0 — Engine Migration Governance:** record this decision and preserve legacy
   source.
2. **M4.3A.1 — Godot Bootable Skeleton:** create and run the minimal Godot project.
3. **M4.3A.2 — Content Pipeline Parity:** validate and load the 55-entry manifest into
   a Godot content registry.
4. **M4.3A.3 — Greenhouse Gameplay Vertical Slice:** demonstrate boot, registry,
   plant, water, grow, bloom, and harvest using canonical time rules.
5. **M4.3A.4 — Save/Load Runtime Parity:** persist and restore the vertical-slice
   flower state using a Godot-native versioned save.
6. **M4.3A.5 — Telemetry & Debug Evidence:** implement approved measurement-only
   telemetry and debug capture.
7. **M4.3A.6 — Runtime Performance Baseline:** collect real Godot profiler/debug-build
   evidence; only then may M4.2C-B Godot runtime validation resume.
8. **M4.3B–D:** migrate core systems, achieve content/system parity, then decide legacy
   retirement from approved parity evidence.

Each phase requires executable validation appropriate to its scope and must not expand
into unapproved gameplay, content, schema, or economy changes.

## No-delete period and rollback

No GDevelop source file may be moved, renamed, or deleted during M4.3A through M4.3C.
The migration uses isolated commits and a dedicated migration branch after the owner
verifies repository state. Rollback is performed by reverting or abandoning Godot
migration commits; it never requires deleting the preserved GDevelop reference.
Legacy retirement is a separate M4.3D decision after documented parity gates pass.

## Performance-validation transition

M4.2C-A remains `PASS` as approved Python reference evidence. M4.2C-B GDevelop
runtime profiling is cancelled because GDevelop is not the production target. M4.2C-B
Godot runtime evidence is `PENDING` until a runnable Godot vertical slice and validated
runtime instrumentation exist. Python timing and Python memory never substitute for
Godot FPS, frame time, boot/scene loading, draw calls, or runtime RAM.

## Risks and mitigations

- **Runtime rewrite cost:** migrate one validated vertical slice before broader system
  work; do not convert all external events together.
- **Behavior drift:** use GDevelop systems and reference saves as behavioral references,
  not executable compatibility promises.
- **Data duplication:** enforce deterministic manifest-ordered sync and hash checks.
- **Stale legacy conventions:** canonical `Time_Convention.md` overrides conflicting
  legacy comments.
- **Missing production assets:** use approved debug placeholders only; visual parity is
  out of scope.
- **Performance assumptions:** measure Godot only from a real debug/export build.

## Consequences

The project gains an explicit path to a Godot production runtime but accepts temporary
parallel-source maintenance. No Godot readiness, gameplay parity, save compatibility,
or runtime-performance claim follows from this governance decision alone.

## Known governance debt

`ADR-005` identifiers are duplicated in separate documentation directories. This is
recorded but not renumbered in M4.3A. A dedicated ADR-governance cleanup must resolve
the duplicate without breaking historical links.
