extends Control

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
