# M4.2B Closure Checklist

- [x] Establish canonical 1,440-minute game-day convention.
- [x] Migrate White Lily to `growth_time` without changing its value.
- [x] Replace EOS acceptance logic with fixed-anchor normalized ROI scoring.
- [x] Keep raw ROI/day alongside the normalized score.
- [x] Use one deterministic simulation core for economy and telemetry.
- [x] Model harvest cash flow rather than amortized daily income.
- [x] Remove unsupported random festival income from the simulator.
- [x] Add sleep-gold, crop-age, harvest-wait, and money-sink telemetry.
- [x] Mark inventory-full frequency as `not_observable`, not zero.
- [x] Validate 50 deterministic runs, JSON parsing, and content margins.

**M4.2B recommendation:** PASS.

## M4.2C-A

- [x] Produce reproducible Python raw samples for content and save pipelines.
- [x] Separate Python memory evidence from GDevelop runtime RAM.
- [x] Classify `save_slot_01.json` and reference fixtures.
- [x] Clarify runtime-only performance-budget measurement points.
- [x] Preserve Economy Freeze and Content JSON integrity.
- [ ] M4.2C-B GDevelop runtime profiling — pending executable runtime/profiler.

**M4.2C status:** PARTIALLY COMPLETE (`M4.2C-A PASS`; `M4.2C-B PENDING`).

> **M4.3A.0 migration update (authoritative):** The unchecked GDevelop runtime
> profiling item above is cancelled by ADR-006. M4.2C-B Godot runtime profiling is
> pending M4.3A.3 through M4.3A.6; M4.2C remains PARTIALLY COMPLETE.

## M4.3 Godot Runtime Migration

- [x] M4.3A.0 Engine Migration Governance.
- [ ] M4.3A.1 Godot Bootable Skeleton.
- [ ] M4.3A.2 Content Pipeline Parity.
- [ ] M4.3A.3 Greenhouse Gameplay Vertical Slice.
- [ ] M4.3A.4 Save/Load Runtime Parity.
- [ ] M4.3A.5 Telemetry & Debug Evidence.
- [ ] M4.3A.6 Runtime Performance Baseline.
- [ ] M4.3B Core-System Migration.
- [ ] M4.3C Content/System Parity.
- [ ] M4.3D Legacy Retirement Decision.

**M4.3A.0 status:** COMPLETE — ADR-006 accepted; no Godot implementation files
created; GDevelop source preserved.
