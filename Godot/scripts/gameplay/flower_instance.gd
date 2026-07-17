extends RefCounted
class_name FlowerInstance

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


func get_save_snapshot() -> Dictionary:
	return {
		"flower_id": flower_id,
		"seed_id": seed_id,
		"growth_elapsed_minutes": growth_elapsed_minutes,
		"watered": watered,
		"state": lifecycle_state,
	}


static func create_from_snapshot(data: Dictionary, flower_definition: Dictionary, seed_definition: Dictionary) -> Dictionary:
	if not data.has("flower_id") or not data.has("seed_id") or not data.has("growth_elapsed_minutes") or not data.has("watered") or not data.has("state"):
		return _failure("INVALID_FLOWER_SNAPSHOT", "Flower snapshot is incomplete")
	if data.flower_id != flower_definition.get("id") or data.seed_id != seed_definition.get("id"):
		return _failure("CONTENT_DEFINITION_MISSING", "Saved IDs do not match canonical definitions")
	if seed_definition.get("target_flower_id") != flower_definition.get("id"):
		return _failure("SEED_FLOWER_MISMATCH", "Seed does not target saved flower")
	if typeof(data.growth_elapsed_minutes) != TYPE_INT and typeof(data.growth_elapsed_minutes) != TYPE_FLOAT:
		return _failure("INVALID_FLOWER_SNAPSHOT", "Growth elapsed must be numeric")
	var elapsed := int(data.growth_elapsed_minutes)
	var growth_time := int(flower_definition.get("growth_time", 0))
	if elapsed < 0 or float(elapsed) != float(data.growth_elapsed_minutes) or growth_time <= 0:
		return _failure("INVALID_FLOWER_SNAPSHOT", "Growth elapsed is invalid")
	if elapsed > growth_time:
		return _failure("INVALID_FLOWER_SNAPSHOT", "Growth elapsed exceeds canonical growth time")
	if typeof(data.watered) != TYPE_BOOL or not data.state is String:
		return _failure("INVALID_FLOWER_SNAPSHOT", "Watered and state fields are invalid")
	var state: String = data.state
	if state == PLANTED_DRY and (data.watered or elapsed != 0):
		return _failure("INVALID_FLOWER_SNAPSHOT", "PLANTED_DRY requires dry zero growth")
	if state == GROWING and (not data.watered or elapsed >= growth_time):
		return _failure("INVALID_FLOWER_SNAPSHOT", "GROWING requires watered sub-maximum growth")
	if state == BLOOMED and (not data.watered or elapsed != growth_time):
		return _failure("INVALID_FLOWER_SNAPSHOT", "BLOOMED requires watered canonical maximum growth")
	if state != PLANTED_DRY and state != GROWING and state != BLOOMED:
		return _failure("INVALID_FLOWER_SNAPSHOT", "Unknown lifecycle state")
	var instance := FlowerInstance.new(flower_definition, str(seed_definition.id))
	instance.growth_elapsed_minutes = elapsed
	instance.watered = data.watered
	instance.lifecycle_state = state
	return {"ok": true, "candidate": instance}


static func _failure(code: String, message: String) -> Dictionary:
	return {"ok": false, "code": code, "message": message}
