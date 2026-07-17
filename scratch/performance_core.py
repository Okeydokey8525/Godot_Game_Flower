#!/usr/bin/env python3
"""Reproducible Python-only performance evidence for Plant Tales M4.2C-A.

This module deliberately does not measure GDevelop runtime performance.  It measures
the frozen data pipeline and representative save JSON with Python only.
"""

from __future__ import annotations

import hashlib
import json
import math
import platform
import subprocess
import sys
import time
import tracemalloc
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from statistics import fmean, median

PROJECT_ROOT = Path(__file__).resolve().parents[1]
CONTENT_DIR = PROJECT_ROOT / "Source" / "Content"
MANIFEST_PATH = CONTENT_DIR / "content_manifest.json"
SAVE_PATH = PROJECT_ROOT / "Source" / "Data" / "Saves" / "save_slot_01.json"
REPORT_DIR = PROJECT_ROOT / "Source" / "Data" / "Reports"
BENCHMARK_VERSION = "1.0.0"
IN_MEMORY_WARMUPS = 50
IN_MEMORY_ITERATIONS = 500
FILE_IO_WARMUPS = 20
FILE_IO_ITERATIONS = 100

FOLDER_MAPPING = {
    "flowers": "Flowers", "npcs": "NPCs", "dialogues": "Dialogues",
    "quests": "Quests", "items": "Items", "weather": "Weather", "seasons": "Seasons",
}


def ms_since(start_ns: int) -> float:
    return (time.perf_counter_ns() - start_ns) / 1_000_000


def measure(callable_):
    start = time.perf_counter_ns()
    value = callable_()
    return value, ms_since(start)


def percentile(samples, fraction: float) -> float:
    ordered = sorted(samples)
    return ordered[max(0, math.ceil(len(ordered) * fraction) - 1)]


def summarize(samples, unit="ms"):
    return {
        "sample_count": len(samples),
        "mean": round(fmean(samples), 6),
        "median": round(median(samples), 6),
        "p95": round(percentile(samples, 0.95), 6),
        "minimum": round(min(samples), 6),
        "maximum": round(max(samples), 6),
        "unit": unit,
    }


def deep_size(value, seen=None):
    """Approximate Python object graph size; deliberately not a runtime-RAM proxy."""
    if seen is None:
        seen = set()
    object_id = id(value)
    if object_id in seen:
        return 0
    seen.add(object_id)
    size = sys.getsizeof(value)
    if isinstance(value, dict):
        size += sum(deep_size(key, seen) + deep_size(item, seen) for key, item in value.items())
    elif isinstance(value, (list, tuple, set, frozenset)):
        size += sum(deep_size(item, seen) for item in value)
    return size


def read_manifest_bytes():
    return MANIFEST_PATH.read_bytes()


def parse_manifest(manifest_bytes):
    return json.loads(manifest_bytes)


def discover_paths(manifest):
    entries, duplicates, missing = [], [], []
    seen = set()
    for category, filenames in manifest["content_groups"].items():
        folder = FOLDER_MAPPING[category]
        for filename in filenames:
            path = CONTENT_DIR / folder / filename
            key = str(path.relative_to(PROJECT_ROOT)).replace("\\", "/")
            if key in seen:
                duplicates.append(key)
            seen.add(key)
            if not path.exists():
                missing.append(key)
            entries.append((category, path))
    return entries, duplicates, missing


def read_content_bytes(entries):
    return [(category, path, path.read_bytes()) for category, path in entries]


def parse_content(content_bytes):
    return [(category, path, json.loads(raw)) for category, path, raw in content_bytes]


def build_registry(parsed_entries):
    registry = {category: {} for category in FOLDER_MAPPING}
    duplicate_ids = []
    for category, path, data in parsed_entries:
        entry_id = data.get("id", path.name)
        if entry_id in registry[category]:
            duplicate_ids.append(f"{category}:{entry_id}")
        registry[category][entry_id] = data
    return registry, duplicate_ids


def validate_registry(registry, missing_paths, duplicate_paths, duplicate_ids):
    """Invoke the existing M4.2B data validator without writing its reports."""
    sys.path.insert(0, str(PROJECT_ROOT / "scratch"))
    from simulation_core import validate_content

    flowers = registry["flowers"]
    seeds = {item_id: item for item_id, item in registry["items"].items() if item.get("item_type") == "Seed"}
    economy_validation = validate_content(flowers, seeds)
    errors = list(economy_validation["errors"])
    if missing_paths:
        errors.extend(f"missing manifest path: {path}" for path in missing_paths)
    if duplicate_paths:
        errors.extend(f"duplicate manifest path: {path}" for path in duplicate_paths)
    if duplicate_ids:
        errors.extend(f"duplicate registry id: {entry}" for entry in duplicate_ids)
    return {"status": "PASS" if not errors else "FAIL", "errors": errors, "warnings": economy_validation["warnings"]}


def pipeline_once():
    timings = {}
    manifest_bytes, timings["manifest_read"] = measure(read_manifest_bytes)
    manifest, timings["manifest_parse"] = measure(lambda: parse_manifest(manifest_bytes))
    discovery, timings["content_path_discovery"] = measure(lambda: discover_paths(manifest))
    entries, duplicate_paths, missing_paths = discovery
    content_bytes, timings["content_file_read"] = measure(lambda: read_content_bytes(entries))
    parsed_entries, timings["content_json_parse"] = measure(lambda: parse_content(content_bytes))
    registry_result, timings["registry_construction"] = measure(lambda: build_registry(parsed_entries))
    registry, duplicate_ids = registry_result
    validation, timings["content_validation"] = measure(
        lambda: validate_registry(registry, missing_paths, duplicate_paths, duplicate_ids)
    )
    timings["total_pipeline"] = sum(timings.values())
    return timings, {"manifest": manifest, "entries": entries, "content_bytes": content_bytes,
                     "parsed_entries": parsed_entries, "registry": registry, "validation": validation,
                     "missing_paths": missing_paths, "duplicate_paths": duplicate_paths,
                     "duplicate_ids": duplicate_ids}


def in_memory_once(cached_manifest_bytes, cached_content_bytes):
    timings = {}
    manifest, timings["manifest_parse"] = measure(lambda: parse_manifest(cached_manifest_bytes))
    discovery, timings["content_path_discovery"] = measure(lambda: discover_paths(manifest))
    entries, duplicate_paths, missing_paths = discovery
    parsed_entries, timings["content_json_parse"] = measure(lambda: parse_content(cached_content_bytes))
    registry_result, timings["registry_construction"] = measure(lambda: build_registry(parsed_entries))
    registry, duplicate_ids = registry_result
    validation, timings["content_validation"] = measure(
        lambda: validate_registry(registry, missing_paths, duplicate_paths, duplicate_ids)
    )
    timings["total_pipeline"] = sum(timings.values())
    return timings, {"manifest": manifest, "entries": entries, "parsed_entries": parsed_entries,
                     "registry": registry, "validation": validation}


def memory_probe(cached_content_bytes):
    tracemalloc.start()
    parsed_entries = parse_content(cached_content_bytes)
    registry, _ = build_registry(parsed_entries)
    current, peak = tracemalloc.get_traced_memory()
    tracemalloc.stop()
    return {
        "parsed_python_object_deep_size_bytes": deep_size(parsed_entries),
        "registry_python_deep_size_bytes": deep_size(registry),
        "tracemalloc_current_bytes": current,
        "tracemalloc_peak_bytes": peak,
    }


def save_classification():
    save = json.loads(SAVE_PATH.read_bytes())
    flowers = save.get("modules_state", {}).get("flower_instances", [])
    day = save.get("world_state", {}).get("current_day")
    return {
        "path": str(SAVE_PATH.relative_to(PROJECT_ROOT)).replace("\\", "/"),
        "classification": "early_game_minimal_runtime_save",
        "structurally_representative": True,
        "volume_representative": False,
        "reason": f"Day {day}, {len(flowers)} saved flower instances, and a small two-slot inventory.",
        "fixtures": {
            "Source/Data/ReferenceSaves/Alpha_Ready_Save.json": "reference_milestone_fixture",
            "Source/Data/ReferenceSaves/StressTest.json": "test_fixture",
        },
    }


def save_benchmarks():
    for _ in range(FILE_IO_WARMUPS):
        SAVE_PATH.read_bytes()
    file_samples = []
    for _ in range(FILE_IO_ITERATIONS):
        _, elapsed = measure(SAVE_PATH.read_bytes)
        file_samples.append(elapsed)

    save_bytes = SAVE_PATH.read_bytes()
    save_object = json.loads(save_bytes)
    for _ in range(IN_MEMORY_WARMUPS):
        json.loads(save_bytes)
        json.dumps(save_object, ensure_ascii=False, separators=(",", ":"))
    parse_samples, serialize_samples, deserialize_samples = [], [], []
    serialized_bytes = b""
    for _ in range(IN_MEMORY_ITERATIONS):
        parsed, elapsed = measure(lambda: json.loads(save_bytes))
        parse_samples.append(elapsed)
        serialized, elapsed = measure(lambda: json.dumps(parsed, ensure_ascii=False, separators=(",", ":")))
        serialize_samples.append(elapsed)
        serialized_bytes = serialized.encode("utf-8")
        _, elapsed = measure(lambda: json.loads(serialized))
        deserialize_samples.append(elapsed)
    return {
        "classification": save_classification(),
        "disk_byte_size": len(save_bytes),
        "utf8_serialized_byte_size": len(serialized_bytes),
        "samples": {
            "save_file_read": file_samples,
            "save_json_parse": parse_samples,
            "save_json_serialization": serialize_samples,
            "save_json_deserialization": deserialize_samples,
        },
        "checksum_validation": {
            "status": "NOT_OBSERVABLE",
            "reason": "No executable checksum algorithm exists; SaveManager contains only a design comment.",
        },
    }


def sha256(path: Path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def frozen_snapshot():
    content_files = sorted(path for path in CONTENT_DIR.rglob("*.json"))
    entries = [{"path": str(path.relative_to(PROJECT_ROOT)).replace("\\", "/"), "sha256": sha256(path)} for path in content_files]
    anchors = PROJECT_ROOT / "Docs" / "BalanceRules" / "economy_balance.md"
    aggregate = hashlib.sha256("".join(f"{entry['path']}:{entry['sha256']}\n" for entry in entries).encode()).hexdigest()
    return {
        "content_json_aggregate_sha256": aggregate,
        "content_json_file_count": len(entries),
        "economy_balance_sha256": sha256(anchors),
        "method": "SHA-256 snapshot; benchmark opens frozen files read-only.",
    }


def git_commit():
    try:
        result = subprocess.run(["git", "rev-parse", "HEAD"], cwd=PROJECT_ROOT, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except Exception:
        return "unavailable: git metadata not readable in current workspace"


def environment_metadata(manifest):
    game = json.loads((PROJECT_ROOT / "Source" / "game.json").read_bytes())
    cpu = platform.processor() or "unavailable"
    return {
        "run_id": f"m4_2c_a_{datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')}",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "benchmark_version": BENCHMARK_VERSION,
        "project_version": game["properties"].get("version", "unavailable"),
        "schema_version": "1.0.0-STABLE",
        "git_commit": git_commit(),
        "python_version": sys.version,
        "operating_system": platform.platform(),
        "cpu": cpu,
        "system_ram": "unavailable: sandbox does not expose reliable hardware metadata",
        "architecture": platform.machine() or "unavailable",
        "gdevelop_project_format": game.get("gdVersion", "unavailable"),
        "gdevelop_installed_version": "unavailable: no runtime/editor executable detected",
        "content_manifest_entry_count": sum(len(values) for values in manifest["content_groups"].values()),
        "content_manifest_version": manifest.get("manifest_version"),
        "working_directory": str(PROJECT_ROOT),
        "os_cache_state": "uncontrolled",
    }


def run_benchmark():
    initial_snapshot = frozen_snapshot()
    first_timings, initial = pipeline_once()
    cached_manifest_bytes = read_manifest_bytes()
    cached_content_bytes = read_content_bytes(initial["entries"])

    for _ in range(FILE_IO_WARMUPS - 1):
        pipeline_once()
    file_samples = defaultdict(list)
    for _ in range(FILE_IO_ITERATIONS):
        timings, _ = pipeline_once()
        for metric, value in timings.items():
            file_samples[metric].append(value)

    for _ in range(IN_MEMORY_WARMUPS):
        in_memory_once(cached_manifest_bytes, cached_content_bytes)
    memory_samples = defaultdict(list)
    in_memory_samples = defaultdict(list)
    for _ in range(IN_MEMORY_ITERATIONS):
        timings, _ = in_memory_once(cached_manifest_bytes, cached_content_bytes)
        for metric, value in timings.items():
            in_memory_samples[metric].append(value)
        probe = memory_probe(cached_content_bytes)
        for metric, value in probe.items():
            memory_samples[metric].append(value)

    save = save_benchmarks()
    final_snapshot = frozen_snapshot()
    content_raw_bytes = sum(len(raw) for _, _, raw in cached_content_bytes)
    all_content_json = [path for path in CONTENT_DIR.rglob("*.json")]
    templates = [path for path in all_content_json if "Templates" in path.parts]
    raw = {
        "metadata": environment_metadata(initial["manifest"]),
        "benchmark_configuration": {
            "file_io_warmups": FILE_IO_WARMUPS,
            "file_io_iterations": FILE_IO_ITERATIONS,
            "in_memory_warmups": IN_MEMORY_WARMUPS,
            "in_memory_iterations": IN_MEMORY_ITERATIONS,
            "timer": "time.perf_counter_ns",
            "file_io_cache_claim": "No cold-cache claim; OS cache state is uncontrolled.",
        },
        "content_inventory": {
            "manifest_entries": len(initial["entries"]),
            "content_json_count": len(initial["entries"]),
            "additional_manifest_file_count": 1,
            "raw_json_bytes": content_raw_bytes,
            "templates_excluded": True,
            "template_json_count_excluded": len(templates),
            "missing_paths": initial["missing_paths"],
            "duplicate_manifest_paths": initial["duplicate_paths"],
            "duplicate_registry_ids": initial["duplicate_ids"],
            "frozen_manifest_order": [str(path.relative_to(PROJECT_ROOT)).replace("\\", "/") for _, path in initial["entries"]],
        },
        "content_validation": initial["validation"],
        "samples": {
            "file_io_pipeline": dict(file_samples),
            "in_memory_pipeline": dict(in_memory_samples),
            "memory": dict(memory_samples),
            "save": save["samples"],
        },
        "save": {key: value for key, value in save.items() if key != "samples"},
        "freeze_integrity": {
            "before": initial_snapshot,
            "after": final_snapshot,
            "unchanged_during_benchmark": initial_snapshot == final_snapshot,
        },
    }
    summary = {
        "metadata": raw["metadata"],
        "evidence_classification": {
            "data_pipeline": "PYTHON_BENCHMARK",
            "memory": "PYTHON_BENCHMARK",
            "save_load": "PYTHON_BENCHMARK",
            "static_analysis": "STATIC_ANALYSIS",
            "gdevelop_runtime": "NOT_MEASURED",
        },
        "m4_2c_a_status": "PASS",
        "m4_2c_a_reason": "Reproducible raw Python benchmark evidence and validation artifacts were produced. It does not certify GDevelop runtime targets.",
        "m4_2c_b_status": "PENDING",
        "m4_2c_b_reason": "No executable GDevelop runtime or profiler evidence is available.",
        "overall_m4_2c_status": "PARTIALLY_COMPLETE",
        "content_inventory": raw["content_inventory"],
        "content_validation": raw["content_validation"],
        "metrics": {
            "file_io_pipeline": {metric: summarize(samples) for metric, samples in file_samples.items()},
            "in_memory_pipeline": {metric: summarize(samples) for metric, samples in in_memory_samples.items()},
            "memory": {metric: summarize(samples, "bytes") for metric, samples in memory_samples.items()},
            "save": {metric: summarize(samples) for metric, samples in save["samples"].items()},
            "save_disk_byte_size": {"value": save["disk_byte_size"], "unit": "bytes"},
            "save_utf8_serialized_byte_size": {"value": save["utf8_serialized_byte_size"], "unit": "bytes"},
            "gdevelop_runtime_registry_ram": {"status": "NOT_MEASURED", "reason": "Python memory is not GDevelop/JavaScript runtime memory."},
            "checksum_validation": save["checksum_validation"],
        },
        "freeze_integrity": raw["freeze_integrity"],
        "limitations": [
            "Python object memory is not equivalent to GDevelop/JavaScript runtime memory.",
            "Python pipeline timing is supporting evidence only and does not substitute for ContentManagerSystem runtime timing.",
            "No file-I/O result is labelled as cold-cache because OS cache control is unavailable.",
        ],
    }
    return raw, summary


def write_json(path: Path, payload):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
