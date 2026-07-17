#!/usr/bin/env python3
"""CLI entry point for Plant Tales M4.2C-A Python benchmark evidence."""

from performance_core import REPORT_DIR, run_benchmark, write_json


def main():
    raw, summary = run_benchmark()
    write_json(REPORT_DIR / "performance_raw_samples.json", raw)
    write_json(REPORT_DIR / "performance_report.json", summary)
    print("Plant Tales M4.2C-A — Python data-pipeline benchmark")
    print(f"Status: {summary['m4_2c_a_status']} | Runtime: {summary['m4_2c_b_status']}")
    for name in ("manifest_read", "content_file_read", "content_json_parse", "registry_construction", "total_pipeline"):
        metric = summary["metrics"]["file_io_pipeline"][name]
        print(f"{name:<24} mean={metric['mean']:.4f}ms p95={metric['p95']:.4f}ms n={metric['sample_count']}")
    print(f"Raw evidence: {REPORT_DIR / 'performance_raw_samples.json'}")
    print(f"Summary:      {REPORT_DIR / 'performance_report.json'}")


if __name__ == "__main__":
    main()
