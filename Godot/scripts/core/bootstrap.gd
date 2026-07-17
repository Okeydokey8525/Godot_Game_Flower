extends Control

@onready var status_label: Label = $CenterContainer/VBoxContainer/StatusLabel


func _ready() -> void:
	print("[PLANT_TALES][BOOT_START]")

	if not is_instance_valid(AppState):
		push_error("[PLANT_TALES][BOOT_ERROR] AppState autoload is unavailable.")
		return

	AppState.mark_boot_initialized()
	print("[PLANT_TALES][APP_STATE_READY]")

	status_label.text = "Boot skeleton ready"
	AppState.mark_boot_completed()
	print("[PLANT_TALES][BOOT_COMPLETE]")
