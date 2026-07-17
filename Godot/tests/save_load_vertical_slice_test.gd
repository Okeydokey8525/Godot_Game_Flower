extends SceneTree

const GREENHOUSE_SCENE := preload("res://scenes/greenhouse/greenhouse.tscn")
const TEST_ROOT := "user://plant_tales_save_load_tests"
const TEST_PATH := "user://plant_tales_save_load_tests/save_slot_01.json"

var _failures: Array[String] = []


func _initialize() -> void:
	_cleanup_test_files()
	var registry: Variant = root.get_node_or_null("ContentRegistry")
	var clock: Variant = root.get_node_or_null("GameClock")
	var save_service: Variant = root.get_node_or_null("SaveService")
	_expect(registry != null and clock != null and save_service != null, "required autoloads exist")
	if registry == null or clock == null or save_service == null:
		_finish()
		return
	var registry_report: Dictionary = registry.initialize()
	_expect(registry_report.get("success") == true, "ContentRegistry initializes")
	var white_lily_snapshot: Dictionary = registry.get_definition("flowers", "flower_white_lily")
	clock.pause()
	var greenhouse := GREENHOUSE_SCENE.instantiate()
	root.add_child(greenhouse)
	await process_frame

	_expect(save_service.load_document(TEST_PATH).code == "SAVE_NOT_FOUND", "missing save reports SAVE_NOT_FOUND")
	_expect(save_service.load_document("C:/unsafe.json").code == "UNSAFE_SAVE_PATH", "non-user path is rejected")
	_expect(greenhouse.save_runtime_state(TEST_PATH).ok, "empty world saves")
	greenhouse.reset_runtime_state()
	_expect(greenhouse.load_runtime_state(TEST_PATH).ok, "empty world loads")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "EMPTY", "empty plot restores")

	_press(greenhouse, "PlantButton")
	_press(greenhouse, "WaterButton")
	_expect(clock.advance_minutes_for_debug(600), "advance to partial growth succeeds")
	var partial_document: Dictionary = greenhouse.build_save_document()
	_expect(partial_document.world_state.elapsed_gameplay_minutes == 600, "clock snapshot is 600")
	_expect(partial_document.world_state.greenhouse.plot.flower.growth_elapsed_minutes == 600, "flower snapshot is 600")
	_expect(greenhouse.save_runtime_state(TEST_PATH).ok, "partial world saves")
	_expect(greenhouse.save_runtime_state(TEST_PATH).ok, "second save safely replaces slot")
	greenhouse.reset_runtime_state()
	_expect(_world_state(greenhouse).elapsed_gameplay_minutes == 0, "reset restores elapsed time to zero")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "EMPTY", "reset clears plot without deleting save")
	_expect(greenhouse.load_runtime_state(TEST_PATH).ok, "partial world loads")
	_expect(_world_state(greenhouse).elapsed_gameplay_minutes == 600, "load restores clock exactly")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "GROWING", "load restores growing state")
	_expect(_world_state(greenhouse).greenhouse.plot.flower.growth_elapsed_minutes == 600, "load restores flower growth exactly")
	_expect(_world_state(greenhouse).greenhouse.plot.flower.watered == true, "load restores watered state")
	_expect(clock.advance_minutes_for_debug(479), "advance remaining pre-bloom minutes")
	_expect(_world_state(greenhouse).greenhouse.plot.state != "BLOOMED", "479 remaining minutes do not bloom")
	_expect(clock.advance_minutes_for_debug(1), "advance final bloom minute")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "BLOOMED", "flower blooms after exact remaining time")
	_press(greenhouse, "HarvestButton")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "EMPTY", "harvest after restored bloom clears plot")

	greenhouse.reset_runtime_state()
	_press(greenhouse, "PlantButton")
	_press(greenhouse, "WaterButton")
	clock.advance_minutes_for_debug(600)
	var before_failed_load: Dictionary = _world_state(greenhouse)
	_run_semantic_rejection_cases(save_service, greenhouse, partial_document, before_failed_load)
	_run_envelope_rejection_cases(save_service, partial_document)
	_run_invalid_json_case(save_service)
	_expect(registry.get_definition("flowers", "flower_white_lily") == white_lily_snapshot, "registry definition remains unchanged")
	greenhouse.queue_free()
	_cleanup_test_files()
	_finish()


func _run_semantic_rejection_cases(save_service: Variant, greenhouse: Variant, valid_document: Dictionary, expected_state: Dictionary) -> void:
	var cases := [
		["unknown flower", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "flower_id"], "flower_unknown")],
		["unknown seed", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "seed_id"], "seed_unknown")],
		["seed mismatch", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "seed_id"], "seed_daisy")],
		["negative growth", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "growth_elapsed_minutes"], -1)],
		["growth above maximum", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "growth_elapsed_minutes"], 1081)],
		["growing dry", _mutate(valid_document, ["world_state", "greenhouse", "plot", "flower", "watered"], false)],
		["bloomed below maximum", _mutate_state(valid_document, "BLOOMED", 600, true)],
		["maximum still growing", _mutate_state(valid_document, "GROWING", 1080, true)],
		["empty with flower", _mutate_plot_state(valid_document, "EMPTY", valid_document.world_state.greenhouse.plot.flower)],
	]
	for entry in cases:
		var write_result: Dictionary = save_service.save_document(entry[1], TEST_PATH)
		_expect(write_result.ok, "%s fixture writes" % entry[0])
		var load_result: Dictionary = greenhouse.load_runtime_state(TEST_PATH)
		_expect(not load_result.ok, "%s is rejected" % entry[0])
		_expect(_world_state(greenhouse) == expected_state, "%s leaves runtime unchanged" % entry[0])
	var bloomed_document := _mutate_state(valid_document, "BLOOMED", 1080, true)
	_expect(save_service.save_document(bloomed_document, TEST_PATH).ok, "canonical maximum bloom fixture writes")
	_expect(greenhouse.load_runtime_state(TEST_PATH).ok, "canonical maximum with BLOOMED restores")
	_expect(_world_state(greenhouse).greenhouse.plot.state == "BLOOMED", "canonical maximum requires BLOOMED")
	greenhouse.reset_runtime_state()
	greenhouse.load_runtime_state(TEST_PATH)
	greenhouse.reset_runtime_state()
	_press(greenhouse, "PlantButton")
	_press(greenhouse, "WaterButton")
	var clock: Variant = root.get_node_or_null("GameClock")
	clock.advance_minutes_for_debug(600)


func _run_envelope_rejection_cases(save_service: Variant, valid_document: Dictionary) -> void:
	var future := valid_document.duplicate(true)
	future.save_version = "9.0.0"
	_expect(save_service.validate_document(future).code == "UNSUPPORTED_SAVE_VERSION", "future save version is rejected")
	var wrong_runtime := valid_document.duplicate(true)
	wrong_runtime.engine_runtime = "gdevelop"
	_expect(save_service.validate_document(wrong_runtime).code == "WRONG_RUNTIME", "wrong runtime is rejected")
	var wrong_schema := valid_document.duplicate(true)
	wrong_schema.content_schema_version = "9.0.0"
	_expect(save_service.validate_document(wrong_schema).code == "INCOMPATIBLE_CONTENT_SCHEMA", "wrong content schema is rejected")
	var missing_world := valid_document.duplicate(true)
	missing_world.erase("world_state")
	_expect(save_service.validate_document(missing_world).code == "INVALID_ENVELOPE", "missing world section is rejected")


func _run_invalid_json_case(save_service: Variant) -> void:
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(TEST_ROOT))
	var file := FileAccess.open(TEST_PATH, FileAccess.WRITE)
	file.store_string("{ not valid json")
	file.close()
	_expect(save_service.load_document(TEST_PATH).code == "INVALID_JSON", "invalid JSON is rejected")


func _world_state(greenhouse: Variant) -> Dictionary:
	return greenhouse.build_save_document().world_state.duplicate(true)


func _press(greenhouse: Variant, button_name: String) -> void:
	var button: Button = greenhouse.get_node("Layout/Controls/%s" % button_name)
	button.emit_signal("pressed")


func _mutate(document: Dictionary, path: Array, value: Variant) -> Dictionary:
	var copy := document.duplicate(true)
	var cursor: Dictionary = copy
	for index in range(path.size() - 1):
		cursor = cursor[path[index]]
	cursor[path[path.size() - 1]] = value
	return copy


func _mutate_state(document: Dictionary, state: String, elapsed: int, watered: bool) -> Dictionary:
	var copy := document.duplicate(true)
	copy.world_state.greenhouse.plot.state = state
	copy.world_state.greenhouse.plot.flower.state = state
	copy.world_state.greenhouse.plot.flower.growth_elapsed_minutes = elapsed
	copy.world_state.greenhouse.plot.flower.watered = watered
	return copy


func _mutate_plot_state(document: Dictionary, state: String, flower: Variant) -> Dictionary:
	var copy := document.duplicate(true)
	copy.world_state.greenhouse.plot.state = state
	copy.world_state.greenhouse.plot.flower = flower.duplicate(true) if flower is Dictionary else flower
	return copy


func _cleanup_test_files() -> void:
	for path_value in [TEST_PATH, "%s.tmp" % TEST_PATH, "%s.previous" % TEST_PATH]:
		if FileAccess.file_exists(path_value):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(path_value))
	DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_ROOT))


func _expect(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("[PLANT_TALES][SAVE_LOAD_VERTICAL_SLICE_TEST_PASS] cases=32")
		quit(0)
		return
	for failure in _failures:
		push_error("[PLANT_TALES][SAVE_LOAD_VERTICAL_SLICE_TEST_FAIL] %s" % failure)
	quit(1)
