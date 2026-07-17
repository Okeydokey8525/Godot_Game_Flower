# Plant Tales Time Convention

**Status:** Canonical for Schema v1.0.0-STABLE and M4.2B balance tooling  
**Version:** 1.0.0  
**Last updated:** 2026-07-17

This is the sole authority for time storage, conversion, and balance calculations.
Older documents may describe pacing in days; they must link here rather than define
an alternative conversion.

## Canonical units

- One game day is **1,440 gameplay minutes**.
- A day begins at **06:00** and ends immediately before **06:00** the next day.
- While the simulation is active and unpaused, one real second advances **10 gameplay minutes**.
- `growth_time` is an integer count of gameplay minutes from planting to Bloom.
- `growth_days = growth_time / 1440`. It is a decimal calculation and is never
  clamped to a minimum of one day.

## Examples

| Flower | `growth_time` | Elapsed game time | `growth_days` |
| --- | ---: | --- | ---: |
| White Lily | 1,080 | 18 hours | 0.75 |
| Daisy | 1,440 | 24 hours | 1.00 |
| Moonlight Orchid | 2,880 | 48 hours | 2.00 |
| Sacred Water Lotus | 2,880 | 48 hours | 2.00 |

`growth_time` is elapsed time, not a count of sleeps or calendar labels. A crop
ready before the player sleeps may be harvested that day; a wallet simulation must
credit its sale only at harvest, not incrementally during growth.

## Schema compatibility and migration

New and migrated flower definitions must use `growth_time`. M4.2B validation
tooling continues to read the legacy alias `growth_time_minutes` as a fallback so
old data remains readable during migration. White Lily was migrated from
`growth_time_minutes: 1080` to `growth_time: 1080` without changing its value.

The live content schema remains v1.0.0-STABLE; this is a field normalization, not
a schema expansion.
