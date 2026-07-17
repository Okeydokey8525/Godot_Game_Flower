extends Control

const GREENHOUSE_SCENE := "res://scenes/greenhouse/greenhouse.tscn"

@onready var status_label: Label = $CenterContainer/VBoxContainer/StatusLabel


func _ready() -> void:
	print("[PLANT_TALES][BOOT_START]")

	if not is_instance_valid(AppState):
		push_error("[PLANT_TALES][BOOT_ERROR] AppState autoload is unavailable.")
		return

	AppState.mark_boot_initialized()
	print("[PLANT_TALES][APP_STATE_READY]")

	status_label.text = "Initializing content..."
	var content_report: Dictionary = ContentRegistry.initialize()
	if content_report.get("success") != true:
		push_error("[PLANT_TALES][CONTENT_LOAD_FAILED] %s" % content_report.get("error", "unknown error"))
		status_label.text = "Content load failed"
		return

	status_label.text = "Content registry ready"
	AppState.mark_boot_completed()
	print("[PLANT_TALES][BOOT_COMPLETE]")
	print("[PLANT_TALES][GREENHOUSE_LOAD_START]")
	status_label.text = "Loading Greenhouse..."
	if ResourceLoader.load(GREENHOUSE_SCENE) == null:
		push_error("[PLANT_TALES][GREENHOUSE_ERROR] Unable to load %s" % GREENHOUSE_SCENE)
		return
	call_deferred("_transition_to_greenhouse")


func _transition_to_greenhouse() -> void:
	var transition_error := get_tree().change_scene_to_file(GREENHOUSE_SCENE)
	if transition_error != OK:
		push_error("[PLANT_TALES][GREENHOUSE_ERROR] Scene transition failed: %s" % error_string(transition_error))
