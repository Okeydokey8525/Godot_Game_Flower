extends SceneTree

const REGISTRY_SCRIPT := preload("res://autoload/content_registry.gd")
const FIXTURE_ROOT := "user://plant_tales_content_pipeline_tests"
const CONTENT_ROOT := "res://data/content"

var _failures: Array[String] = []


func _initialize() -> void:
	_run_real_content_test()
	_run_negative_fixture_tests()
	_cleanup_fixture_root()
	if _failures.is_empty():
		print("[PLANT_TALES][CONTENT_PIPELINE_TEST_PASS] tests=7")
		quit(0)
		return
	for failure in _failures:
		push_error("[PLANT_TALES][CONTENT_PIPELINE_TEST_FAIL] %s" % failure)
	quit(1)


func _run_real_content_test() -> void:
	var registry := REGISTRY_SCRIPT.new()
	var report: Dictionary = registry.initialize(CONTENT_ROOT, 55)
	_expect(report.get("success") == true, "real content registry initializes")
	_expect(registry.is_ready(), "real content registry becomes ready")
	_expect(registry.get_counts().get("flowers") == 12, "real flower count is 12")
	var flowers := registry.get_all("flowers")
	_expect(not flowers.is_empty() and flowers[0].get("id") == "flower_white_lily", "manifest ordering is stable")
	_expect(registry.has_definition("flowers", "flower_white_lily"), "deterministic lookup succeeds")
	registry.free()


func _run_negative_fixture_tests() -> void:
	_run_negative_case("duplicate_id", [
		_flower("flower_test"), _flower("flower_test"),
	], false, "duplicate IDs are rejected")
	_run_negative_case("invalid_json", ["{ invalid json"], true, "invalid JSON is rejected")
	_run_missing_file_case()
	_run_negative_case("unsupported_schema", [_flower("flower_test", "1")], false, "unsupported schema representation is rejected")


func _run_negative_case(name: String, payloads: Array, raw_payload: bool, expectation: String) -> void:
	var root := _make_fixture(name, payloads, raw_payload, false)
	var registry := REGISTRY_SCRIPT.new()
	var report: Dictionary = registry.initialize(root, payloads.size())
	_expect(report.get("success") == false, expectation)
	_expect(not registry.is_ready() and registry.get_counts().is_empty(), "%s leaves no partial registry" % name)
	registry.free()


func _run_missing_file_case() -> void:
	var root := _make_fixture("missing_file", [_flower("flower_test")], false, true)
	var registry := REGISTRY_SCRIPT.new()
	var report: Dictionary = registry.initialize(root, 1)
	_expect(report.get("success") == false, "missing destination file is rejected")
	_expect(not registry.is_ready() and registry.get_counts().is_empty(), "missing file leaves no partial registry")
	registry.free()


func _make_fixture(name: String, payloads: Array, raw_payload: bool, remove_first_file: bool) -> String:
	var root := "%s/%s" % [FIXTURE_ROOT, name]
	DirAccess.remove_absolute(root)
	DirAccess.make_dir_recursive_absolute(root.path_join("Flowers"))
	var filenames: Array[String] = []
	var inventory: Array[Dictionary] = []
	for index in payloads.size():
		var filename := "flower_%d.json" % index
		var relative_path := "Flowers/%s" % filename
		var bytes: PackedByteArray
		if raw_payload:
			bytes = String(payloads[index]).to_utf8_buffer()
		else:
			bytes = JSON.stringify(payloads[index], "\t", false).to_utf8_buffer()
		_write_bytes(root.path_join(relative_path), bytes)
		filenames.append(filename)
		inventory.append({
			"category": "flowers",
			"path": relative_path,
			"id": "flower_test" if raw_payload else payloads[index].id,
			"sha256": _sha256(bytes),
		})
	var groups := {"flowers": filenames, "npcs": [], "dialogues": [], "quests": [], "items": [], "weather": [], "seasons": []}
	var manifest := {"manifest_version": 1, "content_groups": groups}
	var manifest_bytes := JSON.stringify(manifest, "\t", false).to_utf8_buffer()
	_write_bytes(root.path_join("content_manifest.json"), manifest_bytes)
	var metadata := {
		"metadata_format_version": 1,
		"manifest_sha256": _sha256(manifest_bytes),
		"entry_count": payloads.size(),
		"category_counts": {"flowers": payloads.size(), "npcs": 0, "dialogues": 0, "quests": 0, "items": 0, "weather": 0, "seasons": 0},
		"schema_version_inventory": {"supported_runtime_representation": "integer:1"},
		"ordered_inventory": inventory,
	}
	_write_bytes(root.path_join("content_sync_metadata.json"), JSON.stringify(metadata, "\t", false).to_utf8_buffer())
	if remove_first_file:
		DirAccess.remove_absolute(root.path_join("Flowers/flower_0.json"))
	return root


func _flower(content_id: String, schema_version: Variant = 1) -> Dictionary:
	return {"id": content_id, "display_name": "Test Flower", "schema_version": schema_version}


func _write_bytes(path_value: String, bytes: PackedByteArray) -> void:
	var file := FileAccess.open(path_value, FileAccess.WRITE)
	file.store_buffer(bytes)
	file.close()


func _sha256(bytes: PackedByteArray) -> String:
	var context := HashingContext.new()
	context.start(HashingContext.HASH_SHA256)
	context.update(bytes)
	return context.finish().hex_encode()


func _cleanup_fixture_root() -> void:
	DirAccess.remove_absolute(FIXTURE_ROOT)


func _expect(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)
