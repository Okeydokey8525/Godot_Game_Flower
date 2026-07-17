extends Control

const GREENHOUSE_SCENE := "res://scenes/greenhouse/greenhouse.tscn"

@onready var status_label: Label = $CenterContainer/VBoxContainer/StatusLabel


func _ready() -> void:
	print("[PLANT_TALES][BOOT_START]")
	var telemetry_service: Variant = get_node_or_null("/root/TelemetryService")
	if telemetry_service != null and OS.is_debug_build():
		telemetry_service.set_enabled(true)
		var telemetry_start: Dictionary = telemetry_service.start_session({"startup_mode": "debug"})
		if not telemetry_start.ok and telemetry_start.code != "TELEMETRY_SESSION_ACTIVE":
			push_warning("[PLANT_TALES][TELEMETRY_WARNING] Session start failed: %s" % telemetry_start.code)

	if not is_instance_valid(AppState):
		push_error("[PLANT_TALES][BOOT_ERROR] AppState autoload is unavailable.")
		return

	AppState.mark_boot_initialized()
	print("[PLANT_TALES][APP_STATE_READY]")
	_record_telemetry(telemetry_service, "APP_STATE_READY", {
		"runtime": AppState.runtime_name,
		"migration_phase": "M4.3A.5",
	})

	status_label.text = "Initializing content..."
	var content_report: Dictionary = ContentRegistry.initialize()
	if content_report.get("success") != true:
		push_error("[PLANT_TALES][CONTENT_LOAD_FAILED] %s" % content_report.get("error", "unknown error"))
		status_label.text = "Content load failed"
		return

	status_label.text = "Content registry ready"
	_record_telemetry(telemetry_service, "CONTENT_REGISTRY_READY", {
		"total": int(content_report.get("entry_count", 0)),
	})
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


func _record_telemetry(telemetry_service: Variant, event_name: String, payload: Dictionary) -> void:
	if telemetry_service == null or not telemetry_service.is_session_active():
		return
	var result: Dictionary = telemetry_service.record_event(event_name, payload)
	if not result.ok:
		push_warning("[PLANT_TALES][TELEMETRY_WARNING] %s: %s" % [event_name, result.code])
