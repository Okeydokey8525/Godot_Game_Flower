extends SceneTree

const GREENHOUSE_SCENE := preload("res://scenes/greenhouse/greenhouse.tscn")
const TEST_OUTPUT_ROOT := "user://plant_tales_telemetry_tests"
const FAILURE_OUTPUT_ROOT := "user://plant_tales_telemetry_failure_tests"
const TEST_SAVE_ROOT := "user://plant_tales_telemetry_save_tests"
const TEST_SAVE_PATH := "user://plant_tales_telemetry_save_tests/save_slot_01.json"
const RUNTIME_OUTPUT_ROOT := "user://telemetry"
const FORBIDDEN_KEYS := [
	"username", "email", "ip", "ip_address", "device_id", "account_id",
	"machine_name", "hostname", "absolute_path", "geolocation", "latitude", "longitude",
]

var _failures: Array[String] = []
var _clock_ticks := 0


func _initialize() -> void:
	_cleanup_root(TEST_OUTPUT_ROOT)
	_cleanup_root(FAILURE_OUTPUT_ROOT)
	_cleanup_root(TEST_SAVE_ROOT)
	var runtime_inventory_before := _file_inventory(RUNTIME_OUTPUT_ROOT)
	var telemetry: Variant = root.get_node_or_null("TelemetryService")
	var registry: Variant = root.get_node_or_null("ContentRegistry")
	var game_clock: Variant = root.get_node_or_null("GameClock")
	_expect(telemetry != null and registry != null and game_clock != null, "required autoloads exist")
	if telemetry == null or registry == null or game_clock == null:
		_finish()
		return

	telemetry.set_enabled(false)
	_expect(telemetry.start_session({"output_root": TEST_OUTPUT_ROOT}).code == "TELEMETRY_DISABLED", "disabled telemetry does not start")
	_expect(_file_inventory(TEST_OUTPUT_ROOT).is_empty(), "disabled telemetry creates no file")
	telemetry.set_enabled(true)
	_expect(telemetry.start_session({"output_root": "C:/unsafe"}).code == "UNSAFE_OUTPUT_ROOT", "unsafe output root is rejected")

	var options := {
		"output_root": TEST_OUTPUT_ROOT,
		"session_id": "test-session-001",
		"run_id": "test-run-001",
		"deterministic_test_seed": 42,
		"evidence_kind": "automated_test",
		"clock_provider": Callable(self, "_next_clock_tick"),
		"startup_mode": "headless_test",
	}
	var session_start: Dictionary = telemetry.start_session(options)
	_expect(session_start.ok, "test session starts")
	_expect(_file_inventory(TEST_OUTPUT_ROOT).size() == 1, "one JSONL file exists")
	options.session_id = "mutated-session"
	options.run_id = "mutated-run"
	_expect(telemetry.get_session_path().begins_with(TEST_OUTPUT_ROOT), "injected output root is used")

	var registry_report: Dictionary = registry.initialize()
	_expect(registry_report.success, "ContentRegistry initializes")
	game_clock.pause()
	_expect(telemetry.record_event("APP_STATE_READY", {"runtime": "godot", "migration_phase": "M4.3A.5"}).ok, "app state event records")
	_expect(telemetry.record_event("CONTENT_REGISTRY_READY", {"total": int(registry_report.entry_count)}).ok, "content-ready event records")

	var greenhouse := GREENHOUSE_SCENE.instantiate()
	root.add_child(greenhouse)
	await process_frame
	_press(greenhouse, "PlantButton")
	_press(greenhouse, "WaterButton")
	_expect(game_clock.advance_minutes_for_debug(600), "partial lifecycle advances")
	_expect(greenhouse.save_runtime_state(TEST_SAVE_PATH).ok, "save complete operation succeeds")
	greenhouse.reset_runtime_state()
	_expect(greenhouse.load_runtime_state(TEST_SAVE_PATH).ok, "load complete operation succeeds")
	_expect(not greenhouse.load_runtime_state("user://plant_tales_telemetry_save_tests/missing.json").ok, "load rejection operation occurs")
	_expect(not greenhouse.save_runtime_state("C:/unsafe.json").ok, "save rejection operation occurs")
	_expect(game_clock.advance_minutes_for_debug(480), "remaining lifecycle advances")
	_press(greenhouse, "HarvestButton")

	var mutable_payload := {"flower_id": "flower_white_lily", "nested": {"value": "before"}}
	_expect(telemetry.record_event("FLOWER_WATERED", mutable_payload).ok, "valid payload records")
	mutable_payload.nested.value = "after"
	_expect(telemetry.record_event("UNKNOWN_EVENT", {}).code == "TELEMETRY_EVENT_NOT_ALLOWED", "unknown event is rejected")
	_expect(telemetry.record_event("FLOWER_WATERED", {"flower_id": ""}).code == "TELEMETRY_INVALID_PAYLOAD", "invalid payload is rejected")
	var close_result: Dictionary = telemetry.close_session("test_complete")
	_expect(close_result.ok, "explicit close succeeds")
	_expect(not telemetry.is_session_active(), "closed session becomes inactive")
	_expect(telemetry.record_event("FLOWER_WATERED", {"flower_id": "flower_white_lily"}).code == "TELEMETRY_SESSION_INACTIVE", "events after close are rejected")

	var documents := _read_jsonl(session_start.details.session_path)
	_validate_documents(documents)
	_expect(_file_inventory(RUNTIME_OUTPUT_ROOT) == runtime_inventory_before, "test output does not touch runtime telemetry root")
	_expect(_run_write_failure_case(telemetry), "write failure returns structured non-critical result")
	greenhouse.reset_runtime_state()
	_press(greenhouse, "PlantButton")
	_expect(greenhouse.build_save_document().world_state.greenhouse.plot.state == "PLANTED_DRY", "telemetry write failure does not interrupt a gameplay callback")
	_expect(game_clock.advance_minutes_for_debug(1), "telemetry write failure does not interrupt game clock")

	greenhouse.queue_free()
	_cleanup_root(TEST_OUTPUT_ROOT)
	_cleanup_root(FAILURE_OUTPUT_ROOT)
	_cleanup_root(TEST_SAVE_ROOT)
	_finish()


func _next_clock_tick() -> int:
	_clock_ticks += 10
	return _clock_ticks


func _run_write_failure_case(telemetry: Variant) -> bool:
	telemetry.set_enabled(true)
	var started: Dictionary = telemetry.start_session({
		"output_root": FAILURE_OUTPUT_ROOT,
		"session_id": "test-session-write-failure",
		"run_id": "test-run-write-failure",
		"evidence_kind": "automated_test",
	})
	if not started.ok:
		return false
	telemetry.set_test_force_write_failure(true)
	var result: Dictionary = telemetry.record_event("FLOWER_WATERED", {"flower_id": "flower_white_lily"})
	telemetry.set_test_force_write_failure(false)
	return result.code == "TELEMETRY_WRITE_FAILED" and not telemetry.is_session_active()


func _validate_documents(documents: Array) -> void:
	_expect(not documents.is_empty(), "JSONL contains accepted events")
	var expected_prefix := ["SESSION_START", "APP_STATE_READY", "CONTENT_REGISTRY_READY", "GREENHOUSE_READY"]
	for index in range(expected_prefix.size()):
		_expect(index < documents.size() and documents[index].event_name == expected_prefix[index], "startup event order %s" % expected_prefix[index])
	var lifecycle := _event_names(documents)
	_expect(_ordered(lifecycle, ["FLOWER_PLANTED", "FLOWER_WATERED", "FLOWER_BLOOMED", "FLOWER_HARVESTED"]), "lifecycle event order is preserved")
	_expect(lifecycle.has("SAVE_COMPLETE"), "SAVE_COMPLETE exists")
	_expect(lifecycle.has("LOAD_COMPLETE"), "LOAD_COMPLETE exists")
	_expect(lifecycle.has("LOAD_REJECTED"), "LOAD_REJECTED exists")
	_expect(lifecycle.has("SAVE_REJECTED"), "SAVE_REJECTED exists")
	_expect(lifecycle.back() == "SESSION_END", "SESSION_END is last")
	var previous_sequence := 0
	var previous_timestamp := -1
	for document_value in documents:
		var document: Dictionary = document_value
		_expect(document.has_all(["event_name", "sequence", "timestamp_monotonic_ms", "evidence_kind", "session", "payload"]), "event envelope is complete")
		_expect(int(document.sequence) == previous_sequence + 1, "sequence increments only for accepted events")
		_expect(int(document.timestamp_monotonic_ms) >= previous_timestamp, "timestamps are monotonic")
		previous_sequence = int(document.sequence)
		previous_timestamp = int(document.timestamp_monotonic_ms)
		_expect(document.evidence_kind == "automated_test", "automated test evidence kind is explicit")
		_expect(document.session.session_id == "test-session-001", "session metadata snapshot preserves injected ID")
		_expect(document.session.run_id == "test-run-001", "run metadata snapshot preserves injected ID")
		_expect(document.session.deterministic_test_seed == 42, "deterministic seed is preserved")
		_expect(not _contains_forbidden_key(document), "event document contains no forbidden PII key")
		_expect(document.event_name in _allow_list(), "event name is allow-listed")
	var copied_payload := _find_event(documents, "FLOWER_WATERED", true)
	_expect(copied_payload.payload.nested.value == "before", "event payload is deep-copied before caller mutation")


func _read_jsonl(path: String) -> Array:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		_failures.append("JSONL output opens")
		return []
	var documents: Array = []
	while not file.eof_reached():
		var line := file.get_line()
		if line.is_empty():
			continue
		var parser := JSON.new()
		if parser.parse(line) != OK or not parser.data is Dictionary:
			_failures.append("every JSONL line parses")
			continue
		documents.append(parser.data)
	file.close()
	return documents


func _event_names(documents: Array) -> Array:
	var names: Array = []
	for document_value in documents:
		names.append(str((document_value as Dictionary).event_name))
	return names


func _ordered(names: Array, required_names: Array) -> bool:
	var cursor := 0
	for name_value in names:
		if cursor < required_names.size() and name_value == required_names[cursor]:
			cursor += 1
	return cursor == required_names.size()


func _find_event(documents: Array, event_name: String, require_nested: bool = false) -> Dictionary:
	for document_value in documents:
		var document: Dictionary = document_value
		if document.event_name == event_name and (not require_nested or document.payload.has("nested")):
			return document
	_failures.append("event %s exists" % event_name)
	return {}


func _contains_forbidden_key(value: Variant) -> bool:
	if value is Dictionary:
		for key_value in value.keys():
			if FORBIDDEN_KEYS.has(str(key_value).to_lower()) or _contains_forbidden_key(value[key_value]):
				return true
	if value is Array:
		for child in value:
			if _contains_forbidden_key(child):
				return true
	return false


func _allow_list() -> Array:
	return [
		"SESSION_START", "APP_STATE_READY", "CONTENT_REGISTRY_READY", "GREENHOUSE_READY",
		"FLOWER_PLANTED", "FLOWER_WATERED", "FLOWER_BLOOMED", "FLOWER_HARVESTED",
		"SAVE_COMPLETE", "SAVE_REJECTED", "LOAD_COMPLETE", "LOAD_REJECTED", "SESSION_END",
	]


func _press(greenhouse: Variant, button_name: String) -> void:
	var button: Button = greenhouse.get_node("Layout/Controls/%s" % button_name)
	button.emit_signal("pressed")


func _file_inventory(root_path: String) -> Array:
	if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(root_path)):
		return []
	var files := DirAccess.get_files_at(root_path)
	files.sort()
	return files


func _cleanup_root(root_path: String) -> void:
	if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(root_path)):
		return
	for file_name in DirAccess.get_files_at(root_path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path("%s/%s" % [root_path, file_name]))
	DirAccess.remove_absolute(ProjectSettings.globalize_path(root_path))


func _expect(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("[PLANT_TALES][TELEMETRY_BASELINE_TEST_PASS] cases=32")
		quit(0)
		return
	for failure in _failures:
		push_error("[PLANT_TALES][TELEMETRY_BASELINE_TEST_FAIL] %s" % failure)
	quit(1)
