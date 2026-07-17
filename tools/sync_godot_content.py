"""Deterministically sync canonical Plant Tales content into the Godot runtime."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import sys
import uuid
from pathlib import Path

TOOL_VERSION = "1.0.0"
EXIT_USAGE, EXIT_SOURCE, EXIT_MISMATCH, EXIT_FILESYSTEM = 1, 2, 3, 4
PROJECT_ROOT = Path(__file__).resolve().parents[1]
SOURCE_ROOT = PROJECT_ROOT / "Source" / "Content"
DATA_ROOT = PROJECT_ROOT / "Godot" / "data"
DESTINATION_ROOT = DATA_ROOT / "content"
MANIFEST_NAME = "content_manifest.json"
METADATA_NAME = "content_sync_metadata.json"
CATEGORY_DIRS = {
    "flowers": "Flowers", "npcs": "NPCs", "dialogues": "Dialogues",
    "quests": "Quests", "items": "Items", "weather": "Weather", "seasons": "Seasons",
}
PREFIXES = {
    "flowers": ("flower_",), "npcs": ("npc_",), "dialogues": ("dialogue_",),
    "quests": ("quest_",), "weather": ("weather_",), "seasons": ("season_",),
    "items": ("seed_", "tool_"),
}


class SyncError(Exception):
    pass


class FilesystemSyncError(SyncError):
    pass


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def read_json(path: Path) -> tuple[bytes, object]:
    try:
        raw = path.read_bytes()
        return raw, json.loads(raw.decode("utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as error:
        raise SyncError(f"invalid UTF-8 JSON: {path}: {error}") from error


def safe_filename(value: object, category: str) -> str:
    if not isinstance(value, str) or not value or value in {".", ".."}:
        raise SyncError(f"{category}: manifest filename must be a non-empty string")
    if "/" in value or "\\" in value or ".." in value or Path(value).name != value:
        raise SyncError(f"{category}: unsafe manifest filename {value!r}")
    if not value.endswith(".json"):
        raise SyncError(f"{category}: manifest filename must end with .json: {value!r}")
    return value


def validate_identity(category: str, payload: object, logical_path: str) -> tuple[str, object]:
    if not isinstance(payload, dict):
        raise SyncError(f"{logical_path}: JSON root must be an object")
    content_id = payload.get("id")
    if not isinstance(content_id, str) or not content_id:
        raise SyncError(f"{logical_path}: missing non-empty id")
    if not content_id.startswith(PREFIXES[category]):
        raise SyncError(f"{logical_path}: id {content_id!r} does not match {category} convention")
    if category == "dialogues":
        if not isinstance(payload.get("lines"), list) or not payload["lines"]:
            raise SyncError(f"{logical_path}: dialogue requires non-empty lines")
    elif category == "quests":
        if not isinstance(payload.get("title"), str) or not payload["title"]:
            raise SyncError(f"{logical_path}: quest requires non-empty title")
    elif not isinstance(payload.get("display_name"), str) or not payload["display_name"]:
        raise SyncError(f"{logical_path}: missing non-empty display_name")
    schema_version = payload.get("schema_version")
    if type(schema_version) is not int or schema_version != 1:
        raise SyncError(f"{logical_path}: unsupported schema_version representation {schema_version!r}")
    return content_id, schema_version


def build_inventory() -> tuple[dict, list[dict], dict]:
    manifest_path = SOURCE_ROOT / MANIFEST_NAME
    manifest_bytes, manifest = read_json(manifest_path)
    if not isinstance(manifest, dict) or not isinstance(manifest.get("content_groups"), dict):
        raise SyncError("manifest must contain object content_groups")
    groups = manifest["content_groups"]
    if list(groups.keys()) != list(CATEGORY_DIRS.keys()):
        raise SyncError("manifest categories must match the canonical ordered category contract")
    entries: list[dict] = []
    seen_paths, seen_ids = set(), set()
    category_counts, schema_inventory = {}, {"integer_values": set(), "string_values": set(), "missing": 0}
    for category, directory in CATEGORY_DIRS.items():
        filenames = groups.get(category)
        if not isinstance(filenames, list):
            raise SyncError(f"{category}: manifest group must be an array")
        category_counts[category] = len(filenames)
        for filename_value in filenames:
            filename = safe_filename(filename_value, category)
            logical_path = f"{directory}/{filename}"
            if logical_path in seen_paths:
                raise SyncError(f"duplicate manifest path: {logical_path}")
            seen_paths.add(logical_path)
            source_path = SOURCE_ROOT / directory / filename
            raw, payload = read_json(source_path)
            content_id, version = validate_identity(category, payload, logical_path)
            if content_id in seen_ids:
                raise SyncError(f"duplicate content id: {content_id}")
            seen_ids.add(content_id)
            schema_inventory["integer_values"].add(version)
            entries.append({"category": category, "path": logical_path, "id": content_id, "sha256": sha256(raw)})
    if len(entries) != 55:
        raise SyncError(f"expected 55 manifest entries, found {len(entries)}")
    metadata = {
        "metadata_format_version": 1,
        "sync_tool_version": TOOL_VERSION,
        "source_root": "Source/Content",
        "generated_content_warning": "Generated output. Do not edit manually.",
        "manifest_version": manifest.get("manifest_version"),
        "manifest_sha256": sha256(manifest_bytes),
        "entry_count": len(entries),
        "category_counts": category_counts,
        "schema_version_inventory": {
            "integer_values": sorted(schema_inventory["integer_values"]),
            "string_values": [], "missing": 0,
            "supported_runtime_representation": "integer:1",
        },
        "ordered_inventory": entries,
        "integrity_scope": "Synchronization consistency only; not a cryptographic signature or anti-tampering mechanism.",
    }
    return manifest, entries, metadata


def metadata_bytes(metadata: dict) -> bytes:
    return (json.dumps(metadata, ensure_ascii=False, indent=2) + "\n").encode("utf-8")


def expected_paths(entries: list[dict]) -> set[str]:
    return {MANIFEST_NAME, METADATA_NAME, *(entry["path"] for entry in entries)}


def verify_destination(destination_root: Path, entries: list[dict], metadata: dict) -> list[str]:
    errors: list[str] = []
    if not destination_root.is_dir():
        return [f"destination missing: {destination_root}"]
    expected = expected_paths(entries)
    actual = {path.relative_to(destination_root).as_posix() for path in destination_root.rglob("*") if path.is_file()}
    if actual != expected:
        errors.append(f"destination inventory mismatch: missing={sorted(expected - actual)} stale={sorted(actual - expected)}")
    expected_metadata = metadata_bytes(metadata)
    destination_metadata = destination_root / METADATA_NAME
    if not destination_metadata.is_file() or destination_metadata.read_bytes() != expected_metadata:
        errors.append("metadata mismatch")
    manifest_bytes = (SOURCE_ROOT / MANIFEST_NAME).read_bytes()
    target_manifest = destination_root / MANIFEST_NAME
    if not target_manifest.is_file() or target_manifest.read_bytes() != manifest_bytes:
        errors.append("manifest hash mismatch")
    for entry in entries:
        source = SOURCE_ROOT / entry["path"]
        destination = destination_root / entry["path"]
        if not destination.is_file() or sha256(destination.read_bytes()) != entry["sha256"] or destination.read_bytes() != source.read_bytes():
            errors.append(f"content hash mismatch: {entry['path']}")
    return errors


def build_staging(entries: list[dict], metadata: dict) -> Path:
    DATA_ROOT.mkdir(parents=True, exist_ok=True)
    staging = DATA_ROOT / f".content-staging-{uuid.uuid4().hex}"
    staging.mkdir()
    try:
        shutil.copyfile(SOURCE_ROOT / MANIFEST_NAME, staging / MANIFEST_NAME)
        for entry in entries:
            target = staging / entry["path"]
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(SOURCE_ROOT / entry["path"], target)
        (staging / METADATA_NAME).write_bytes(metadata_bytes(metadata))
        return staging
    except Exception:
        shutil.rmtree(staging, ignore_errors=True)
        raise


def transactional_sync(entries: list[dict], metadata: dict) -> None:
    staging = build_staging(entries, metadata)
    backup = DATA_ROOT / f".content-backup-{uuid.uuid4().hex}"
    destination_was_moved = False
    try:
        errors = verify_destination(staging, entries, metadata)
        if errors:
            raise SyncError("staging verification failed: " + "; ".join(errors))
        if DESTINATION_ROOT.exists():
            os.replace(DESTINATION_ROOT, backup)
            destination_was_moved = True
        try:
            os.replace(staging, DESTINATION_ROOT)
        except Exception:
            if destination_was_moved and backup.exists() and not DESTINATION_ROOT.exists():
                os.replace(backup, DESTINATION_ROOT)
            raise
        if backup.exists():
            shutil.rmtree(backup)
    except Exception as error:
        shutil.rmtree(staging, ignore_errors=True)
        try:
            if destination_was_moved and backup.exists() and not DESTINATION_ROOT.exists():
                os.replace(backup, DESTINATION_ROOT)
        except OSError as restore_error:
            raise FilesystemSyncError(
                f"transactional sync failed and rollback failed: {error}; {restore_error}"
            ) from restore_error
        if isinstance(error, SyncError):
            raise
        raise FilesystemSyncError(f"transactional sync failed and rollback was attempted: {error}") from error


def main() -> int:
    parser = argparse.ArgumentParser()
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--sync", action="store_true")
    mode.add_argument("--check", action="store_true")
    mode.add_argument("--clean", action="store_true")
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--report", nargs="?", const=str(PROJECT_ROOT / "Godot" / ".godot" / "content_sync_report.json"))
    args = parser.parse_args()
    if args.clean:
        if not args.force:
            parser.error("--clean requires --force")
        if DESTINATION_ROOT.exists():
            shutil.rmtree(DESTINATION_ROOT)
        return 0
    try:
        _manifest, entries, metadata = build_inventory()
        errors = verify_destination(DESTINATION_ROOT, entries, metadata) if args.check else []
        if args.check and errors:
            raise RuntimeError("; ".join(errors))
        if args.sync:
            source_before = {entry["path"]: entry["sha256"] for entry in entries}
            transactional_sync(entries, metadata)
            _manifest_after, entries_after, _metadata_after = build_inventory()
            if source_before != {entry["path"]: entry["sha256"] for entry in entries_after}:
                raise SyncError("canonical source changed during sync")
        report = {"status": "PASS", "entry_count": len(entries), "category_counts": metadata["category_counts"], "manifest_sha256": metadata["manifest_sha256"]}
        if args.report:
            report_path = Path(args.report)
            report_path.parent.mkdir(parents=True, exist_ok=True)
            report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(report, sort_keys=True))
        return 0
    except FilesystemSyncError as error:
        print(f"FILESYSTEM_ERROR: {error}", file=sys.stderr)
        return EXIT_FILESYSTEM
    except SyncError as error:
        print(f"SYNC_ERROR: {error}", file=sys.stderr)
        return EXIT_SOURCE
    except RuntimeError as error:
        print(f"CHECK_ERROR: {error}", file=sys.stderr)
        return EXIT_MISMATCH
    except OSError as error:
        print(f"FILESYSTEM_ERROR: {error}", file=sys.stderr)
        return EXIT_FILESYSTEM


if __name__ == "__main__":
    sys.exit(main())
