#!/usr/bin/env python3
"""M4.2B economy report.  Uses the shared authoritative simulation core."""

from simulation_core import (
    NORMALIZED_ROI_LOWER_ANCHOR, NORMALIZED_ROI_UPPER_ANCHOR, REPORT_DIR,
    SEASON_TARGETS, compute_roi_rows, load_content, simulate_economy,
    validate_content, write_json,
)


def main():
    flowers, seeds, _quests = load_content()
    rows = compute_roi_rows(flowers, seeds)
    simulation = simulate_economy(flowers, seeds)
    validation = validate_content(flowers, seeds)
    autumn = simulation["seasonal_net_gold"]["Autumn"]
    payload = {
        "sprint": "M4.2B",
        "data_source": "Deterministic automated simulation (not human playtest)",
        "simulation_authority": "scratch/simulation_core.py",
        "game_minutes_per_day": 1440,
        "normalized_roi_score": {
            "method": "fixed_anchor_v1",
            "lower_anchor": NORMALIZED_ROI_LOWER_ANCHOR,
            "upper_anchor": NORMALIZED_ROI_UPPER_ANCHOR,
            "formula": "clamp(100 * (roi_day - lower_anchor) / (upper_anchor - lower_anchor), 0, 100)",
        },
        "flowers": rows,
        "seasonal_net_gold": simulation["seasonal_net_gold"],
        "autumn_target": SEASON_TARGETS["Autumn"],
        "autumn_status": "PASS" if autumn >= SEASON_TARGETS["Autumn"][0] else "FAIL",
        "behavioral_kpis": {key: value for key, value in simulation.items() if key not in {"events", "seasonal_net_gold"}},
        "content_validation": validation,
    }
    write_json(REPORT_DIR / "economy_roi_matrix.json", payload)
    validation_lines = [
        "Plant Tales M4.2B Content Validation",
        f"Status: {validation['status']}",
        f"Flowers checked: {len(flowers)}",
        f"Seeds checked: {len(seeds)}",
        f"Errors: {len(validation['errors'])}",
        f"Warnings: {len(validation['warnings'])}",
    ] + validation["errors"] + validation["warnings"]
    (REPORT_DIR / "Content_Validation_Report.txt").write_text(
        "\n".join(validation_lines) + "\n", encoding="utf-8"
    )
    print("M4.2B economy validation — shared deterministic simulation")
    print(f"Normalized ROI fixed anchors: {NORMALIZED_ROI_LOWER_ANCHOR:g}..{NORMALIZED_ROI_UPPER_ANCHOR:g} G/day")
    for season, value in simulation["seasonal_net_gold"].items():
        low, high = SEASON_TARGETS[season]
        status = "PASS" if low <= value <= high else ("LOW" if value < low else "HIGH")
        print(f"{season:<6} {value:>8.2f} G  target [{low}, {high}]  {status}")
    print(f"Autumn KPI: {payload['autumn_status']}")
    print(f"Content validation: {validation['status']} ({len(validation['warnings'])} warning(s))")


if __name__ == "__main__":
    main()
