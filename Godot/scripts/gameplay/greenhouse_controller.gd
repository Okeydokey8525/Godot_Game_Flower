extends Control

## M4.3A.3_VERTICAL_SLICE_RULE: debug controls demonstrate one White Lily lifecycle only.

const PlantingPlotScript := preload("res://scripts/gameplay/planting_plot.gd")
const DEBUG_ADVANCE_MINUTES := 60

@onready var game_time_label: Label = $Layout/Header/GameTimeLabel
@onready var flower_name_label: Label = $Layout/PlotPanel/PlotContent/FlowerNameLabel
@onready var lifecycle_label: Label = $Layout/PlotPanel/PlotContent/LifecycleLabel
@onready var progress_bar: ProgressBar = $Layout/PlotPanel/PlotContent/GrowthProgress
@onready var status_label: Label = $Layout/StatusLabel
@onready var plant_button: Button = $Layout/Controls/PlantButton
@onready var water_button: Button = $Layout/Controls/WaterButton
@onready var advance_time_button: Button = $Layout/Controls/AdvanceTimeButton
@onready var harvest_button: Button = $Layout/Controls/HarvestButton

var _content_registry: Variant
var _game_clock: Variant
var _plot: Variant


func _ready() -> void:
	_content_registry = get_node_or_null("/root/ContentRegistry")
	_game_clock = get_node_or_null("/root/GameClock")
	if _content_registry == null or _game_clock == null or not _content_registry.is_ready():
		push_error("[PLANT_TALES][GREENHOUSE_ERROR] ContentRegistry is not ready.")
		status_label.text = "Configuration error: content is unavailable"
		return
	_plot = PlantingPlotScript.new(_content_registry)
	_plot.state_changed.connect(_on_plot_state_changed)
	_plot.growth_changed.connect(_on_plot_growth_changed)
	_plot.action_rejected.connect(_on_action_rejected)
	_game_clock.minutes_advanced.connect(_plot.advance_from_clock)
	plant_button.pressed.connect(_on_plant_pressed)
	water_button.pressed.connect(_on_water_pressed)
	advance_time_button.pressed.connect(_on_advance_time_pressed)
	harvest_button.pressed.connect(_on_harvest_pressed)
	advance_time_button.visible = OS.is_debug_build()
	advance_time_button.disabled = not OS.is_debug_build()
	plant_button.text = "Plant %s" % _plot.get_supported_flower_display_name()
	status_label.text = "Ready to plant a White Lily"
	_refresh_ui()
	print("[PLANT_TALES][GREENHOUSE_READY]")


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


func _on_plot_state_changed(_state: String) -> void:
	_refresh_ui()


func _on_plot_growth_changed(_elapsed_minutes: int, _growth_time_minutes: int) -> void:
	_refresh_ui()


func _on_action_rejected(action: String, reason: String, severity: String) -> void:
	status_label.text = "%s rejected (%s): %s" % [action.capitalize(), severity, reason]
	_refresh_ui()


func _apply_result(result: Dictionary) -> void:
	if result.get("ok") == true:
		status_label.text = str(result.get("message", "Action complete"))
	_refresh_ui()


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
