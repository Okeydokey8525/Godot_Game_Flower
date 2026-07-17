extends Node

## M4.3A.3_VERTICAL_SLICE_RULE: time is canonical; debug advance is not gameplay.

signal minutes_advanced(delta_minutes: int, total_elapsed_minutes: int)

const GAMEPLAY_MINUTES_PER_DAY := 1_440
const START_MINUTE_OF_DAY := 360
const GAMEPLAY_MINUTES_PER_REAL_SECOND := 10.0

var elapsed_gameplay_minutes: int = 0
var _residual_gameplay_minutes: float = 0.0
var _paused: bool = false


func _process(delta: float) -> void:
	if _paused:
		return
	_residual_gameplay_minutes += delta * GAMEPLAY_MINUTES_PER_REAL_SECOND
	var whole_minutes := floori(_residual_gameplay_minutes)
	if whole_minutes > 0:
		_residual_gameplay_minutes -= whole_minutes
		_advance_minutes(whole_minutes)


func pause() -> void:
	_paused = true


func resume() -> void:
	_paused = false


func is_paused() -> bool:
	return _paused


func advance_minutes_for_debug(minutes: int) -> bool:
	if not OS.is_debug_build() or minutes <= 0:
		return false
	_advance_minutes(minutes)
	return true


func get_day_number() -> int:
	return floori(float(elapsed_gameplay_minutes) / GAMEPLAY_MINUTES_PER_DAY) + 1


func get_minute_of_day() -> int:
	return (START_MINUTE_OF_DAY + elapsed_gameplay_minutes) % GAMEPLAY_MINUTES_PER_DAY


func get_formatted_time() -> String:
	var minute_of_day := get_minute_of_day()
	return "Day %d - %02d:%02d" % [get_day_number(), minute_of_day / 60, minute_of_day % 60]


func reset_for_test() -> void:
	elapsed_gameplay_minutes = 0
	_residual_gameplay_minutes = 0.0
	_paused = true


func _advance_minutes(minutes: int) -> void:
	elapsed_gameplay_minutes += minutes
	minutes_advanced.emit(minutes, elapsed_gameplay_minutes)
