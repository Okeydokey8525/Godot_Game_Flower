extends SceneTree

const GameClockScript := preload("res://autoload/game_clock.gd")
const PlantingPlotScript := preload("res://scripts/gameplay/planting_plot.gd")
const GREENHOUSE_SCENE := preload("res://scenes/greenhouse/greenhouse.tscn")

var _failures: Array[String] = []


func _initialize() -> void:
	var content_registry: Variant = root.get_node_or_null("ContentRegistry")
	_expect(content_registry != null, "ContentRegistry autoload exists")
	if content_registry == null:
		quit(1)
		return
	var content_report: Dictionary = content_registry.initialize()
	_expect(content_report.get("success") == true, "ContentRegistry initializes")
	_expect(GREENHOUSE_SCENE != null, "Greenhouse scene resource loads")
	var registry_snapshot := _capture_required_definitions(content_registry)
	_expect(not registry_snapshot.is_empty(), "White Lily and seed definitions exist")
	if not registry_snapshot.is_empty():
		_expect(registry_snapshot.seed.get("target_flower_id") == "flower_white_lily", "seed target resolves to White Lily")
	_run_lifecycle_case("first", content_registry)
	_run_lifecycle_case("second", content_registry)
	_expect(_capture_required_definitions(content_registry) == registry_snapshot, "gameplay does not mutate registry definitions")
	if _failures.is_empty():
		print("[PLANT_TALES][GREENHOUSE_VERTICAL_SLICE_TEST_PASS] cases=20")
		quit(0)
		return
	for failure in _failures:
		push_error("[PLANT_TALES][GREENHOUSE_VERTICAL_SLICE_TEST_FAIL] %s" % failure)
	quit(1)


func _run_lifecycle_case(case_name: String, content_registry: Variant) -> void:
	var clock := GameClockScript.new()
	clock.reset_for_test()
	_expect(clock.get_formatted_time() == "Day 1 - 06:00", "%s: canonical clock starts at Day 1 06:00" % case_name)
	_expect(clock.advance_minutes_for_debug(1_080), "%s: canonical clock advance succeeds" % case_name)
	_expect(clock.get_formatted_time() == "Day 1 - 00:00", "%s: 1080 minutes reaches Day 1 00:00" % case_name)
	_expect(clock.advance_minutes_for_debug(360), "%s: day-boundary advance succeeds" % case_name)
	_expect(clock.get_formatted_time() == "Day 2 - 06:00", "%s: 1440 minutes reaches Day 2 06:00" % case_name)
	clock.reset_for_test()
	var plot := PlantingPlotScript.new(content_registry)
	clock.minutes_advanced.connect(plot.advance_from_clock)

	_expect(not plot.water_current_flower().get("ok"), "%s: empty plot rejects water" % case_name)
	_expect(not plot.harvest_current_flower().get("ok"), "%s: empty plot rejects harvest" % case_name)
	_expect(plot.plant_white_lily().get("ok"), "%s: plant succeeds" % case_name)
	_expect(not plot.plant_white_lily().get("ok"), "%s: duplicate plant is rejected" % case_name)
	_expect(plot.get_lifecycle_state() == "PLANTED_DRY", "%s: plant begins dry" % case_name)
	_expect(clock.advance_minutes_for_debug(0) == false, "%s: zero debug advance is rejected" % case_name)
	_expect(clock.advance_minutes_for_debug(-1) == false, "%s: negative debug advance is rejected" % case_name)
	_expect(clock.advance_minutes_for_debug(1), "%s: debug time advancement is available" % case_name)
	_expect(plot.get_growth_elapsed_minutes() == 0, "%s: dry flower gains zero growth" % case_name)
	_expect(not plot.harvest_current_flower().get("ok"), "%s: harvest before bloom is rejected" % case_name)
	_expect(plot.water_current_flower().get("ok"), "%s: water activates growth" % case_name)
	_expect(plot.get_lifecycle_state() == "GROWING", "%s: water enters growing state" % case_name)
	_expect(not plot.water_current_flower().get("ok"), "%s: repeated water is rejected" % case_name)
	_expect(clock.advance_minutes_for_debug(1_079), "%s: pre-bloom advance succeeds" % case_name)
	_expect(plot.get_growth_elapsed_minutes() == 1_079, "%s: exact accumulated growth before bloom" % case_name)
	_expect(plot.get_lifecycle_state() != "BLOOMED", "%s: below 1080 is not bloomed" % case_name)
	_expect(clock.advance_minutes_for_debug(1), "%s: exact bloom minute advances" % case_name)
	_expect(plot.get_growth_elapsed_minutes() == 1_080, "%s: bloom reaches canonical 1080 minutes" % case_name)
	_expect(plot.get_lifecycle_state() == "BLOOMED", "%s: flower blooms exactly at canonical growth time" % case_name)
	_expect(clock.advance_minutes_for_debug(120), "%s: post-bloom advance succeeds" % case_name)
	_expect(plot.get_growth_elapsed_minutes() == 1_080, "%s: growth remains clamped after bloom" % case_name)
	_expect(plot.harvest_current_flower().get("ok"), "%s: harvest after bloom succeeds" % case_name)
	_expect(plot.get_lifecycle_state() == "EMPTY", "%s: harvest returns plot to empty" % case_name)
	clock.minutes_advanced.disconnect(plot.advance_from_clock)
	clock.free()


func _capture_required_definitions(content_registry: Variant) -> Dictionary:
	var flower: Dictionary = content_registry.get_definition("flowers", "flower_white_lily")
	var seed: Dictionary = content_registry.get_definition("items", "seed_white_lily")
	if flower.is_empty() or seed.is_empty():
		return {}
	return {"flower": flower, "seed": seed}


func _expect(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)
