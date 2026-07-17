extends Control

## M4.3A.3_VERTICAL_SLICE_RULE: debug controls demonstrate one White Lily lifecycle only.

const PlantingPlotScript := preload("res://scripts/gameplay/planting_plot.gd")
const DEBUG_ADVANCE_MINUTES := 60
const SAVE_VERSION := "1.0.0"
const ENGINE_RUNTIME := "godot"
const CONTENT_SCHEMA_VERSION := "1.0.0-STABLE"

@onready var game_time_label: Label = $Layout/Header/GameTimeLabel
@onready var flower_name_label: Label = $Layout/PlotPanel/PlotContent/FlowerNameLabel
@onready var lifecycle_label: Label = $Layout/PlotPanel/PlotContent/LifecycleLabel
@onready var progress_bar: ProgressBar = $Layout/PlotPanel/PlotContent/GrowthProgress
@onready var status_label: Label = $Layout/StatusLabel
@onready var plant_button: Button = $Layout/Controls/PlantButton
@onready var water_button: Button = $Layout/Controls/WaterButton
@onready var advance_time_button: Button = $Layout/Controls/AdvanceTimeButton
@onready var harvest_button: Button = $Layout/Controls/HarvestButton
@onready var save_button: Button = $Layout/Controls/SaveButton
@onready var load_button: Button = $Layout/Controls/LoadButton
@onready var reset_button: Button = $Layout/Controls/ResetButton

var _content_registry: Variant
var _game_clock: Variant
var _save_service: Variant
var _telemetry_service: Variant
var _plot: Variant


func _ready() -> void:
	_content_registry = get_node_or_null("/root/ContentRegistry")
	_game_clock = get_node_or_null("/root/GameClock")
	_save_service = get_node_or_null("/root/SaveService")
	_telemetry_service = get_node_or_null("/root/TelemetryService")
	if _content_registry == null or _game_clock == null or _save_service == null or not _content_registry.is_ready():
		push_error("[PLANT_TALES][GREENHOUSE_ERROR] ContentRegistry is not ready.")
		status_label.text = "Configuration error: content is unavailable"
		return
	_plot = PlantingPlotScript.new(_content_registry)
	_plot.state_changed.connect(_on_plot_state_changed)
	_plot.growth_changed.connect(_on_plot_growth_changed)
	_plot.action_rejected.connect(_on_action_rejected)
	_plot.flower_planted.connect(_on_flower_planted)
	_plot.flower_watered.connect(_on_flower_watered)
	_plot.flower_bloomed.connect(_on_flower_bloomed)
	_plot.flower_harvested.connect(_on_flower_harvested)
	_game_clock.minutes_advanced.connect(_plot.advance_from_clock)
	plant_button.pressed.connect(_on_plant_pressed)
	water_button.pressed.connect(_on_water_pressed)
	advance_time_button.pressed.connect(_on_advance_time_pressed)
	harvest_button.pressed.connect(_on_harvest_pressed)
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	advance_time_button.visible = OS.is_debug_build()
	advance_time_button.disabled = not OS.is_debug_build()
	plant_button.text = "Plant %s" % _plot.get_supported_flower_display_name()
	status_label.text = "Ready to plant a White Lily"
	_refresh_ui()
	print("[PLANT_TALES][GREENHOUSE_READY]")
	_record_telemetry("GREENHOUSE_READY", {"scene": scene_file_path})


func _exit_tree() -> void:
	if _plot != null and _game_clock != null and _game_clock.minutes_advanced.is_connected(_plot.advance_from_clock):
		_game_clock.minutes_advanced.disconnect(_plot.advance_from_clock)


func _on_plant_pressed() -> void:
	_apply_result(_plot.plant_white_lily())


func _on_water_pressed() -> void:
	_apply_result(_plot.water_current_flower())


func _on_advance_time_pressed() -> void:
	if _game_clock.advance_minutes_for_debug(DEBUG_ADVANCE_MINUTES):
		status_label.text = "Debug advanced %d gameplay minutes" % DEBUG_ADVANCE_MINUTES
	else:
		status_label.text = "Debug time advance is unavailable in this build"
	_refresh_ui()


func _on_harvest_pressed() -> void:
	_apply_result(_plot.harvest_current_flower())


func _on_save_pressed() -> void:
	_apply_result(save_runtime_state())


func _on_load_pressed() -> void:
	_apply_result(load_runtime_state())


func _on_reset_pressed() -> void:
	reset_runtime_state()


func _on_plot_state_changed(_state: String) -> void:
	_refresh_ui()


func _on_plot_growth_changed(_elapsed_minutes: int, _growth_time_minutes: int) -> void:
	_refresh_ui()


func _on_action_rejected(action: String, reason: String, severity: String) -> void:
	status_label.text = "%s rejected (%s): %s" % [action.capitalize(), severity, reason]
	_refresh_ui()


func _on_flower_planted(flower_id: String) -> void:
	var snapshot: Dictionary = _plot.get_save_snapshot()
	var flower: Dictionary = snapshot.get("flower", {})
	_record_telemetry("FLOWER_PLANTED", {"flower_id": flower_id, "seed_id": str(flower.get("seed_id", ""))})


func _on_flower_watered(flower_id: String) -> void:
	_record_telemetry("FLOWER_WATERED", {"flower_id": flower_id})


func _on_flower_bloomed(flower_id: String) -> void:
	_record_telemetry("FLOWER_BLOOMED", {
		"flower_id": flower_id,
		"growth_elapsed_minutes": _plot.get_growth_elapsed_minutes(),
	})


func _on_flower_harvested(flower_id: String) -> void:
	_record_telemetry("FLOWER_HARVESTED", {"flower_id": flower_id})


func _record_telemetry(event_name: String, payload: Dictionary) -> void:
	if _telemetry_service == null or not _telemetry_service.is_session_active():
		return
	var result: Dictionary = _telemetry_service.record_event(event_name, payload)
	if not result.ok:
		push_warning("[PLANT_TALES][TELEMETRY_WARNING] %s: %s" % [event_name, result.code])


func _apply_result(result: Dictionary) -> void:
	status_label.text = str(result.get("message", result.get("code", "Action complete")))
	_refresh_ui()


func build_save_document() -> Dictionary:
	return {
		"save_version": SAVE_VERSION,
		"engine_runtime": ENGINE_RUNTIME,
		"content_schema_version": CONTENT_SCHEMA_VERSION,
		"world_state": {
			"elapsed_gameplay_minutes": _game_clock.get_save_snapshot().elapsed_gameplay_minutes,
			"greenhouse": {"plot": _plot.get_save_snapshot()},
		},
	}


func save_runtime_state(save_path: String = "") -> Dictionary:
	var resolved_path: String = _save_service.DEFAULT_SAVE_PATH if save_path.is_empty() else save_path
	print("[PLANT_TALES][SAVE_START]")
	var result: Dictionary = _save_service.save_document(build_save_document(), resolved_path)
	if result.ok:
		print("[PLANT_TALES][SAVE_COMPLETE]")
		_record_telemetry("SAVE_COMPLETE", {"result_code": str(result.code), "save_version": SAVE_VERSION})
		return {"ok": true, "code": "OK", "message": "Save successful"}
	print("[PLANT_TALES][SAVE_REJECTED] code=%s" % result.code)
	_record_telemetry("SAVE_REJECTED", {"code": str(result.code)})
	return {"ok": false, "code": result.code, "message": "Save rejected: %s" % result.message}


func load_runtime_state(save_path: String = "") -> Dictionary:
	var resolved_path: String = _save_service.DEFAULT_SAVE_PATH if save_path.is_empty() else save_path
	print("[PLANT_TALES][LOAD_START]")
	var loaded: Dictionary = _save_service.load_document(resolved_path)
	if not loaded.ok:
		print("[PLANT_TALES][LOAD_REJECTED] code=%s" % loaded.code)
		_record_telemetry("LOAD_REJECTED", {"code": str(loaded.code)})
		return {"ok": false, "code": loaded.code, "message": "Load rejected: %s" % loaded.message}
	var restored := _restore_document(loaded.details.document)
	if not restored.ok:
		print("[PLANT_TALES][LOAD_REJECTED] code=%s" % restored.code)
		_record_telemetry("LOAD_REJECTED", {"code": str(restored.code)})
		return {"ok": false, "code": restored.code, "message": "Load rejected: %s" % restored.message}
	print("[PLANT_TALES][LOAD_COMPLETE]")
	_record_telemetry("LOAD_COMPLETE", {"result_code": "OK", "save_version": SAVE_VERSION})
	return {"ok": true, "code": "OK", "message": "Load successful"}


func reset_runtime_state() -> void:
	_game_clock.reset_runtime_state()
	_plot.reset_runtime_state()
	status_label.text = "Runtime reset"
	_refresh_ui()
	print("[PLANT_TALES][RUNTIME_STATE_RESET]")


func _restore_document(document: Dictionary) -> Dictionary:
	var world_state: Variant = document.get("world_state")
	if not world_state is Dictionary or not world_state.has("elapsed_gameplay_minutes") or not world_state.has("greenhouse"):
		return {"ok": false, "code": "INVALID_ENVELOPE", "message": "World state is incomplete"}
	if not world_state.greenhouse is Dictionary or not world_state.greenhouse.has("plot"):
		return {"ok": false, "code": "INVALID_ENVELOPE", "message": "Greenhouse plot state is missing"}
	var clock_candidate: Dictionary = _game_clock.validate_restore_snapshot({"elapsed_gameplay_minutes": world_state.elapsed_gameplay_minutes})
	if not clock_candidate.ok:
		return clock_candidate
	var plot_candidate: Dictionary = _plot.prepare_restore_snapshot(world_state.greenhouse.plot)
	if not plot_candidate.ok:
		return plot_candidate
	var old_clock: Dictionary = _game_clock.get_save_snapshot()
	var old_plot: Dictionary = _plot.get_save_snapshot()
	var clock_commit: Dictionary = _game_clock.commit_restore_candidate(clock_candidate.candidate)
	if not clock_commit.ok:
		return clock_commit
	var plot_commit: Dictionary = _plot.commit_restore_candidate(plot_candidate.candidate)
	if not plot_commit.ok:
		var rollback_clock: Dictionary = _game_clock.validate_restore_snapshot(old_clock)
		var rollback_plot: Dictionary = _plot.prepare_restore_snapshot(old_plot)
		if rollback_clock.ok and rollback_plot.ok:
			_game_clock.commit_restore_candidate(rollback_clock.candidate)
			_plot.commit_restore_candidate(rollback_plot.candidate)
		return {"ok": false, "code": "RUNTIME_RESTORE_FAILED", "message": "Plot commit failed; rollback attempted"}
	_refresh_ui()
	return {"ok": true, "code": "OK"}


func _refresh_ui() -> void:
	game_time_label.text = _game_clock.get_formatted_time()
	var state: String = _plot.get_lifecycle_state()
	lifecycle_label.text = "State: %s" % state
	var growth_time: int = _plot.get_growth_time_minutes()
	var elapsed: int = _plot.get_growth_elapsed_minutes()
	progress_bar.max_value = maxi(growth_time, 1)
	progress_bar.value = elapsed
	progress_bar.tooltip_text = "%d / %d gameplay minutes" % [elapsed, growth_time]
	flower_name_label.text = _plot.get_supported_flower_display_name() if _plot.get_current_display_name().is_empty() else _plot.get_current_display_name()
	plant_button.disabled = state != "EMPTY"
	water_button.disabled = state != "PLANTED_DRY"
	harvest_button.disabled = state != "BLOOMED"
