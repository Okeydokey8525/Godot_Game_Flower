extends Node

const METADATA_FILE := "content_sync_metadata.json"
const MANIFEST_FILE := "content_manifest.json"
const DEFAULT_ENTRY_COUNT := 55
const CATEGORY_DIRECTORIES := {
	"flowers": "Flowers",
	"npcs": "NPCs",
	"dialogues": "Dialogues",
	"quests": "Quests",
	"items": "Items",
	"weather": "Weather",
	"seasons": "Seasons",
}
const ID_PREFIXES := {
	"flowers": ["flower_"],
	"npcs": ["npc_"],
	"dialogues": ["dialogue_"],
	"quests": ["quest_"],
	"items": ["seed_", "tool_"],
	"weather": ["weather_"],
	"seasons": ["season_"],
}

var _ready: bool = false
var _definitions: Dictionary = {}
var _ordered_definitions: Dictionary = {}
var _initialization_report: Dictionary = {}


func initialize(content_root: String = "res://data/content", expected_entry_count: int = DEFAULT_ENTRY_COUNT) -> Dictionary:
	_reset()
	print("[PLANT_TALES][CONTENT_LOAD_START]")

	var metadata_result := _read_json(_join_path(content_root, METADATA_FILE))
	if not metadata_result.ok:
		return _fail(metadata_result.error)
	var metadata: Dictionary = metadata_result.value
	var metadata_validation := _validate_metadata(metadata, expected_entry_count)
	if not metadata_validation.ok:
		return _fail(metadata_validation.error)

	var inventory: Array = metadata.ordered_inventory
	var hash_validation := _verify_inventory_hashes(content_root, metadata, inventory)
	if not hash_validation.ok:
		return _fail(hash_validation.error)
	print("[PLANT_TALES][CONTENT_SYNC_VERIFIED] total=%d" % inventory.size())

	var manifest_result := _read_json(_join_path(content_root, MANIFEST_FILE))
	if not manifest_result.ok:
		return _fail(manifest_result.error)
	var manifest: Dictionary = manifest_result.value
	var manifest_validation := _validate_manifest(manifest, metadata, expected_entry_count)
	if not manifest_validation.ok:
		return _fail(manifest_validation.error)
	print("[PLANT_TALES][CONTENT_MANIFEST_LOADED] total=%d" % expected_entry_count)

	var temporary_definitions: Dictionary = {}
	var temporary_ordered: Dictionary = {}
	var global_ids: Dictionary = {}
	for entry_value in inventory:
		var entry: Dictionary = entry_value
		var category: String = entry.category
		var content_path: String = entry.path
		var payload_result := _read_json(_join_path(content_root, content_path))
		if not payload_result.ok:
			return _fail(payload_result.error)
		var payload: Dictionary = payload_result.value
		var content_validation := _validate_content_payload(category, content_path, payload, entry)
		if not content_validation.ok:
			return _fail(content_validation.error)
		var content_id: String = payload.id
		if global_ids.has(content_id):
			return _fail("duplicate content id %s in %s and %s" % [content_id, global_ids[content_id], content_path])
		global_ids[content_id] = content_path
		if not temporary_definitions.has(category):
			temporary_definitions[category] = {}
			temporary_ordered[category] = []
		temporary_definitions[category][content_id] = payload
		temporary_ordered[category].append(content_id)

	var reference_validation := _validate_confirmed_references(temporary_definitions)
	if not reference_validation.ok:
		return _fail(reference_validation.error)

	_definitions = temporary_definitions
	_ordered_definitions = temporary_ordered
	_ready = true
	_initialization_report = {
		"success": true,
		"entry_count": expected_entry_count,
		"category_counts": metadata.category_counts.duplicate(true),
		"runtime_validation": "metadata, hashes, manifest, identity, schema representation, and confirmed references",
	}
	print("[PLANT_TALES][CONTENT_REGISTRY_READY] total=%d" % expected_entry_count)
	return get_initialization_report()


func is_ready() -> bool:
	return _ready


func has_definition(content_type: String, content_id: String) -> bool:
	return _ready and _definitions.has(content_type) and _definitions[content_type].has(content_id)


func get_definition(content_type: String, content_id: String) -> Dictionary:
	if not has_definition(content_type, content_id):
		return {}
	return _definitions[content_type][content_id].duplicate(true)


func get_all(content_type: String) -> Array:
	if not _ready or not _ordered_definitions.has(content_type):
		return []
	var results: Array = []
	for content_id in _ordered_definitions[content_type]:
		results.append(_definitions[content_type][content_id].duplicate(true))
	return results


func get_counts() -> Dictionary:
	var counts: Dictionary = {}
	for category in _ordered_definitions:
		counts[category] = _ordered_definitions[category].size()
	return counts


func get_initialization_report() -> Dictionary:
	return _initialization_report.duplicate(true)


func _reset() -> void:
	_ready = false
	_definitions = {}
	_ordered_definitions = {}
	_initialization_report = {"success": false, "error": "not initialized"}


func _fail(error_message: String) -> Dictionary:
	_initialization_report = {"success": false, "error": error_message}
	print("[PLANT_TALES][CONTENT_LOAD_FAILED] %s" % error_message)
	return get_initialization_report()


func _validate_metadata(metadata: Dictionary, expected_entry_count: int) -> Dictionary:
	if metadata.get("metadata_format_version") != 1:
		return _error("unsupported metadata format")
	if metadata.get("entry_count") != expected_entry_count:
		return _error("metadata entry count does not match expected count")
	if not metadata.get("ordered_inventory") is Array or metadata.ordered_inventory.size() != expected_entry_count:
		return _error("metadata ordered inventory is invalid")
	if not metadata.get("manifest_sha256") is String or metadata.manifest_sha256.length() != 64:
		return _error("metadata manifest hash is invalid")
	if not metadata.get("category_counts") is Dictionary:
		return _error("metadata category counts are invalid")
	var schema_inventory: Variant = metadata.get("schema_version_inventory")
	if not schema_inventory is Dictionary or schema_inventory.get("supported_runtime_representation") != "integer:1":
		return _error("unsupported schema compatibility contract")
	return _ok()


func _verify_inventory_hashes(content_root: String, metadata: Dictionary, inventory: Array) -> Dictionary:
	var manifest_path := _join_path(content_root, MANIFEST_FILE)
	if not FileAccess.file_exists(manifest_path) or _sha256_file(manifest_path) != metadata.manifest_sha256:
		return _error("manifest SHA-256 mismatch")
	var paths: Dictionary = {}
	for entry_value in inventory:
		if not entry_value is Dictionary:
			return _error("metadata inventory entry is not an object")
		var entry: Dictionary = entry_value
		var path_value: Variant = entry.get("path")
		if not path_value is String or not _is_safe_relative_path(path_value):
			return _error("unsafe metadata path %s" % str(path_value))
		if paths.has(path_value):
			return _error("duplicate metadata path %s" % path_value)
		paths[path_value] = true
		var file_path := _join_path(content_root, path_value)
		if not FileAccess.file_exists(file_path):
			return _error("missing content file %s" % path_value)
		if not entry.get("sha256") is String or _sha256_file(file_path) != entry.sha256:
			return _error("SHA-256 mismatch for %s" % path_value)
	return _ok()


func _validate_manifest(manifest: Dictionary, metadata: Dictionary, expected_entry_count: int) -> Dictionary:
	var groups: Variant = manifest.get("content_groups")
	if not groups is Dictionary:
		return _error("manifest content_groups is invalid")
	var seen_paths: Array[String] = []
	var count := 0
	for category in CATEGORY_DIRECTORIES:
		var filenames: Variant = groups.get(category)
		if not filenames is Array:
			return _error("manifest category %s is missing" % category)
		if metadata.category_counts.get(category) != filenames.size():
			return _error("manifest category count mismatch for %s" % category)
		for filename_value in filenames:
			if not filename_value is String or not _is_safe_filename(filename_value):
				return _error("unsafe manifest filename in %s" % category)
			var path_value := "%s/%s" % [CATEGORY_DIRECTORIES[category], filename_value]
			if path_value in seen_paths:
				return _error("duplicate manifest path %s" % path_value)
			seen_paths.append(path_value)
			count += 1
	if count != expected_entry_count:
		return _error("manifest entry count does not match expected count")
	var inventory_paths: Array[String] = []
	for entry_value in metadata.ordered_inventory:
		inventory_paths.append(entry_value.path)
	if seen_paths != inventory_paths:
		return _error("manifest order does not match metadata inventory")
	return _ok()


func _validate_content_payload(category: String, path_value: String, payload: Dictionary, entry: Dictionary) -> Dictionary:
	var content_id: Variant = payload.get("id")
	if not content_id is String or content_id.is_empty():
		return _error("missing id in %s" % path_value)
	if content_id != entry.get("id"):
		return _error("metadata id mismatch in %s" % path_value)
	if category == "dialogues":
		var dialogue_lines: Variant = payload.get("lines")
		if not dialogue_lines is Array or dialogue_lines.is_empty():
			return _error("missing dialogue lines in %s" % path_value)
	elif category == "quests":
		var quest_title: Variant = payload.get("title")
		if not quest_title is String or quest_title.is_empty():
			return _error("missing quest title in %s" % path_value)
	else:
		var display_name: Variant = payload.get("display_name")
		if not display_name is String or display_name.is_empty():
			return _error("missing display_name in %s" % path_value)
	var schema_version: Variant = payload.get("schema_version")
	if (typeof(schema_version) != TYPE_INT and typeof(schema_version) != TYPE_FLOAT) or schema_version != 1:
		return _error("unsupported schema_version in %s" % path_value)
	if not ID_PREFIXES[category].any(func(prefix: String) -> bool: return content_id.begins_with(prefix)):
		return _error("id prefix does not match %s in %s" % [category, path_value])
	return _ok()


func _validate_confirmed_references(definitions: Dictionary) -> Dictionary:
	for item in definitions.get("items", {}).values():
		if item.has("target_flower_id") and not _has_reference(definitions, "flowers", item.target_flower_id):
			return _error("missing target_flower_id reference %s" % item.target_flower_id)
	for npc in definitions.get("npcs", {}).values():
		if npc.has("default_dialogue_id") and not _has_reference(definitions, "dialogues", npc.default_dialogue_id):
			return _error("missing default_dialogue_id reference %s" % npc.default_dialogue_id)
	for dialogue in definitions.get("dialogues", {}).values():
		if dialogue.has("speaker_npc_id") and not _has_reference(definitions, "npcs", dialogue.speaker_npc_id):
			return _error("missing speaker_npc_id reference %s" % dialogue.speaker_npc_id)
	return _ok()


func _has_reference(definitions: Dictionary, category: String, content_id: Variant) -> bool:
	return content_id is String and definitions.has(category) and definitions[category].has(content_id)


func _read_json(path_value: String) -> Dictionary:
	if not FileAccess.file_exists(path_value):
		return _error("missing file %s" % path_value)
	var parser := JSON.new()
	var parse_error := parser.parse(FileAccess.get_file_as_string(path_value))
	if parse_error != OK or not parser.data is Dictionary:
		return _error("invalid JSON object %s" % path_value)
	return {"ok": true, "value": parser.data}


func _sha256_file(path_value: String) -> String:
	var context := HashingContext.new()
	context.start(HashingContext.HASH_SHA256)
	context.update(FileAccess.get_file_as_bytes(path_value))
	return context.finish().hex_encode()


func _join_path(root: String, relative_path: String) -> String:
	return root.path_join(relative_path)


func _is_safe_relative_path(path_value: String) -> bool:
	return not path_value.is_empty() and not path_value.begins_with("/") and not path_value.contains("\\") and not path_value.contains("..")


func _is_safe_filename(filename: String) -> bool:
	return filename.ends_with(".json") and not filename.contains("/") and not filename.contains("\\") and not filename.contains("..")


func _ok() -> Dictionary:
	return {"ok": true}


func _error(message: String) -> Dictionary:
	return {"ok": false, "error": message}
