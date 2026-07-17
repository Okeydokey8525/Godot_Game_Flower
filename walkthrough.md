# Plant Tales — M4.2B Economy Validation Technical Report

**Decision:** PASS  
**Evidence type:** 50 deterministic automated simulations; not human playtests.  
**Simulation authority:** `scratch/simulation_core.py`

## Executive summary

M4.2B closes the three Conditional Acceptance issues without touching GDevelop
gameplay logic or changing economy prices. The project now has one canonical time
convention, a fixed-anchor normalized ROI score that does not depend on the best
current crop, and one shared simulation model consumed by both economy validation
and telemetry generation.

## Exact files modified

- `Docs/Architecture/Time_Convention.md`
- `Docs/Architecture/Content_Authoring_Guide.md`
- `Docs/Schemas/flower_schema.md`
- `Docs/01_Game_Design/05_Growth_System.md`
- `Docs/BalanceRules/economy_balance.md`
- `Docs/BalanceRules/flower_balance.md`
- `Source/Content/Flowers/white_lily.json`
- `scratch/simulation_core.py`
- `scratch/run_economy_validation.py`
- `scratch/run_telemetry_sim.py`
- `Source/Data/Reports/economy_roi_matrix.json`
- `Source/Data/Reports/session_telemetry.jsonl`
- `Source/Data/Reports/Content_Validation_Report.txt`
- `walkthrough.md`
- `task.md`

## Canonical time convention

The authoritative definition is [Docs/Architecture/Time_Convention.md](Docs/Architecture/Time_Convention.md): one game day is 1,440 gameplay minutes from 06:00 to the next 06:00; active simulation advances 10 gameplay minutes per real second; `growth_time` is elapsed minutes from planting to Bloom; and `growth_days = growth_time / 1440` without a minimum-day clamp.

White Lily was normalized from legacy `growth_time_minutes` to canonical
`growth_time`, preserving its value of 1,080. M4.2B tooling reads the legacy alias
only for backward compatibility during migration.

## ROI methodology

Raw profit, ROI, ROI/day, ROI/stamina, and ROI/tile remain in the matrix. EOS is
deprecated because it changed every crop's score when the best crop changed.

The new Fixed-Anchor Normalized ROI Score is:

```text
clamp(100 × (ROI/day − 10) / (95 − 10), 0, 100)
```

The fixed anchors (10 and 95 G/day) are versioned policy constants in
`Docs/BalanceRules/economy_balance.md`; they are not calculated from the active
flower dataset. This makes the normalized score stable while keeping ROI/day visible
for designers.

## Unified simulation and Autumn KPI

Both `run_economy_validation.py` and `run_telemetry_sim.py` call the same shared
core. It simulates seed purchases, actual maturity, harvest events, crop-sale wallet
income, and sleep. It does not amortize crop revenue, does not invent festival
income, and does not use quest rewards as an assumed Autumn subsidy.

| Season | Mean net gold | Target | Status |
| --- | ---: | ---: | --- |
| Spring | 2,863.80 | 1,500–3,500 | PASS |
| Summer | 7,909.80 | 4,000–8,000 | PASS |
| Autumn | 14,210.10 | 9,000–16,000 | PASS |
| Winter | 15,085.32 | 15,000–25,000 | PASS |

The old M4.2B result was 8,811 G and the previous telemetry-derived result was
9,099 G. Those numbers came from independent models. The new authoritative result
is 14,210.10 G; no JSON economy adjustment was necessary.

## New telemetry KPI outputs

- Gold held before sleep — Day 1: 155.66 average / 155 median; Day 5: 579.40 / 555.5; Day 10: 1,123.64 / 1,130.
- Crop age at harvest — 1,650.16 minutes average; 1,440 median.
- Harvest-ready wait — 167.40 minutes average; 120 median.
- Money earned: 3,134,814 G; money spent: 1,131,458 G; sink ratio: 0.3609.
- Spending breakdown: seeds 1,131,458 G; tools/shop/festival/upgrades/other 0 G because no authoritative transaction exists for them.
- Inventory full frequency: `null`, `not_observable`. No authoritative stack-capacity rule or `InventoryFull` event exists.

## Validation and regression status

- Economy validation: PASS.
- Telemetry simulation: PASS; 73,730 records written.
- Content validation: PASS; 12 flowers and 12 seeds checked; zero errors and warnings.
- JSON parse regression: PASS for all files under `Source/Content`.
- Deterministic regression: PASS; two independent 50-run executions produced identical seasonal results and events.

## Remaining limitations and risk

This evidence validates the data-driven automated model, not live player behavior.
Inventory-full frequency remains intentionally unobservable until a future,
post-freeze architecture decision defines capacity/stacking and emits an event.
Winter passes with only 85.32 G headroom above its lower target; future content or
behavior-model changes should rerun the complete deterministic suite.

`Source/Data/Static/flower_catalog.json` retains a separate legacy field naming
scheme and is not read by the M4.2B manifest-driven simulation. It was deliberately
left unchanged to avoid expanding this economy-validation sprint; it should be
reconciled only in a separately approved data-migration task.

---

# M4.2C-A Performance Validation Addendum

M4.2C-A is **PASS** for reproducible Python data-pipeline and save JSON benchmarks.
Raw samples and summaries are available in `Source/Data/Reports/performance_*`.
M4.2C-B is **PENDING** because no GDevelop runtime/profiler evidence exists; no FPS,
frame-time, draw-call, runtime-RAM, boot, scene-load, or stress-scenario metric was
claimed as measured. Overall M4.2C is **PARTIALLY COMPLETE**.

---

# M4.3A.0 Engine Migration Governance

**Current runtime source:** GDevelop 5 folder-project source, preserved as a
read-only behavioral reference.  
**Target production runtime:** Godot 4.7.1 Standard x86_64, GDScript, Compatibility
renderer, Windows desktop debug build.  
**Migration type:** Parallel runtime reimplementation; not automatic conversion.  
**Godot implementation status:** Not started.

ADR-006 supersedes ADR-004 without rewriting its historical reasoning. `Source/`
remains untouched. Canonical content stays in `Source/Content/`; a later deterministic
validated sync will generate `Godot/data/content/` for `res://` access. Existing
GDevelop saves remain behavioral fixtures only, and no production visual/audio assets
are currently available; debug placeholders are approved for the first vertical slice.

M4.2C-A remains PASS as Python reference evidence. M4.2C-B GDevelop profiling is
cancelled; M4.2C-B Godot profiling is pending a runnable vertical slice and validated
runtime instrumentation.
