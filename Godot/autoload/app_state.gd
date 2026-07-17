extends Node

var runtime_name: String = "godot"
var runtime_version: String = "uninitialized"
var migration_phase: String = "M4.3A.1"
var boot_initialized: bool = false
var boot_completed: bool = false


func _ready() -> void:
	runtime_version = _format_engine_version(Engine.get_version_info())
	print("[PLANT_TALES][APP_STATE_INITIALIZED] runtime=%s version=%s phase=%s" % [
		runtime_name,
		runtime_version,
		migration_phase,
	])


func mark_boot_initialized() -> void:
	boot_initialized = true


func mark_boot_completed() -> void:
	boot_completed = true


func get_runtime_metadata() -> Dictionary:
	return {
		"runtime_name": runtime_name,
		"runtime_version": runtime_version,
		"migration_phase": migration_phase,
		"boot_initialized": boot_initialized,
		"boot_completed": boot_completed,
	}


func _format_engine_version(version_info: Dictionary) -> String:
	return "%s.%s.%s.%s" % [
		version_info.get("major", 0),
		version_info.get("minor", 0),
		version_info.get("patch", 0),
		version_info.get("status", "unknown"),
	]
