extends RefCounted

## M4.3A.3_VERTICAL_SLICE_RULE: watering once enables all lifecycle growth.

const PLANTED_DRY := "PLANTED_DRY"
const GROWING := "GROWING"
const BLOOMED := "BLOOMED"

var flower_id: String
var seed_id: String
var display_name: String
var growth_time_minutes: int
var growth_elapsed_minutes: int = 0
var watered: bool = false
var lifecycle_state: String = PLANTED_DRY


func _init(flower_definition: Dictionary, planted_seed_id: String) -> void:
	flower_id = str(flower_definition.get("id", ""))
	seed_id = planted_seed_id
	display_name = str(flower_definition.get("display_name", ""))
	growth_time_minutes = int(flower_definition.get("growth_time", 0))


func water() -> bool:
	if lifecycle_state != PLANTED_DRY:
		return false
	watered = true
	lifecycle_state = GROWING
	return true


func advance_growth(delta_minutes: int) -> Dictionary:
	if delta_minutes <= 0 or lifecycle_state != GROWING:
		return {"advanced_minutes": 0, "bloomed_now": false}
	var previous_elapsed := growth_elapsed_minutes
	growth_elapsed_minutes = mini(growth_elapsed_minutes + delta_minutes, growth_time_minutes)
	var bloomed_now := growth_elapsed_minutes == growth_time_minutes and lifecycle_state != BLOOMED
	if bloomed_now:
		lifecycle_state = BLOOMED
	return {
		"advanced_minutes": growth_elapsed_minutes - previous_elapsed,
		"bloomed_now": bloomed_now,
	}


func is_bloomed() -> bool:
	return lifecycle_state == BLOOMED


func get_progress_ratio() -> float:
	if growth_time_minutes <= 0:
		return 0.0
	return float(growth_elapsed_minutes) / float(growth_time_minutes)
