extends RefCounted

## M4.3A.3_VERTICAL_SLICE_RULE: one dry planting needs one water action, then persists.

signal state_changed(state: String)
signal growth_changed(elapsed_minutes: int, growth_time_minutes: int)
signal flower_planted(flower_id: String)
signal flower_watered(flower_id: String)
signal flower_bloomed(flower_id: String)
signal flower_harvested(flower_id: String)
signal action_rejected(action: String, reason: String, severity: String)

const EMPTY := "EMPTY"
const WHITE_LILY_ID := "flower_white_lily"
const WHITE_LILY_SEED_ID := "seed_white_lily"
const FlowerInstanceScript := preload("res://scripts/gameplay/flower_instance.gd")

var _content_registry: Variant
var _flower: Variant


func _init(content_registry: Variant) -> void:
	_content_registry = content_registry


func plant_white_lily() -> Dictionary:
	if _flower != null:
		return _reject("plant", "plot is already occupied", "player_action")
	var seed_lookup := _find_definition_by_id(WHITE_LILY_SEED_ID)
	var flower_lookup := _find_definition_by_id(WHITE_LILY_ID)
	if seed_lookup.is_empty() or flower_lookup.is_empty():
		return _reject("plant", "required canonical definition is missing", "configuration")
	var seed: Dictionary = seed_lookup.definition
	var flower: Dictionary = flower_lookup.definition
	if seed.get("item_type") != "Seed" or seed.get("target_flower_id") != WHITE_LILY_ID:
		return _reject("plant", "seed-to-flower relationship is invalid", "configuration")
	if flower.get("id") != WHITE_LILY_ID or int(flower.get("growth_time", 0)) <= 0:
		return _reject("plant", "White Lily growth definition is invalid", "configuration")
	_flower = FlowerInstanceScript.new(flower, str(seed.get("id")))
	state_changed.emit(get_lifecycle_state())
	flower_planted.emit(_flower.flower_id)
	print("[PLANT_TALES][FLOWER_PLANTED] id=%s" % _flower.flower_id)
	return _success("plant", "White Lily planted dry")


func water_current_flower() -> Dictionary:
	if _flower == null:
		return _reject("water", "plot is empty", "player_action")
	if not _flower.water():
		return _reject("water", "flower is already growing or bloomed", "player_action")
	state_changed.emit(get_lifecycle_state())
	flower_watered.emit(_flower.flower_id)
	print("[PLANT_TALES][FLOWER_WATERED] id=%s" % _flower.flower_id)
	return _success("water", "Flower growth activated")


func advance_from_clock(delta_minutes: int, _total_elapsed_minutes: int = 0) -> void:
	if _flower == null:
		return
	var result: Dictionary = _flower.advance_growth(delta_minutes)
	if int(result.advanced_minutes) > 0:
		growth_changed.emit(_flower.growth_elapsed_minutes, _flower.growth_time_minutes)
	if result.bloomed_now:
		state_changed.emit(get_lifecycle_state())
		flower_bloomed.emit(_flower.flower_id)
		print("[PLANT_TALES][FLOWER_BLOOMED] id=%s" % _flower.flower_id)


func harvest_current_flower() -> Dictionary:
	if _flower == null:
		return _reject("harvest", "plot is empty", "player_action")
	if not _flower.is_bloomed():
		return _reject("harvest", "flower is not bloomed", "player_action")
	var harvested_id: String = _flower.flower_id
	_flower = null
	state_changed.emit(EMPTY)
	flower_harvested.emit(harvested_id)
	print("[PLANT_TALES][FLOWER_HARVESTED] id=%s" % harvested_id)
	return _success("harvest", "Flower harvested; plot is empty")


func get_lifecycle_state() -> String:
	return EMPTY if _flower == null else _flower.lifecycle_state


func get_growth_elapsed_minutes() -> int:
	return 0 if _flower == null else _flower.growth_elapsed_minutes


func get_growth_time_minutes() -> int:
	return 0 if _flower == null else _flower.growth_time_minutes


func get_progress_ratio() -> float:
	return 0.0 if _flower == null else _flower.get_progress_ratio()


func get_current_display_name() -> String:
	return "" if _flower == null else _flower.display_name


func get_supported_flower_display_name() -> String:
	var flower_lookup := _find_definition_by_id(WHITE_LILY_ID)
	if flower_lookup.is_empty():
		return "Unavailable"
	return str(flower_lookup.definition.get("display_name", "Unavailable"))


func _find_definition_by_id(content_id: String) -> Dictionary:
	if _content_registry == null or not _content_registry.is_ready():
		return {}
	for content_type_value in _content_registry.get_counts().keys():
		var content_type := str(content_type_value)
		if _content_registry.has_definition(content_type, content_id):
			return {"content_type": content_type, "definition": _content_registry.get_definition(content_type, content_id)}
	return {}


func _success(action: String, message: String) -> Dictionary:
	return {"ok": true, "action": action, "message": message}


func _reject(action: String, reason: String, severity: String) -> Dictionary:
	action_rejected.emit(action, reason, severity)
	return {"ok": false, "action": action, "reason": reason, "severity": severity}
