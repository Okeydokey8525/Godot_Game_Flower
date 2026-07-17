extends Node

## Local debug-evidence writer. It observes runtime facts but never controls gameplay.

const DEFAULT_OUTPUT_ROOT := "user://telemetry"
const CONTENT_SCHEMA_VERSION := "1.0.0-STABLE"
const SAVE_VERSION := "1.0.0"
const MIGRATION_PHASE := "M4.3A.5"

const EVENT_ALLOWLIST: Array[String] = [
	"SESSION_START",
	"APP_STATE_READY",
	"CONTENT_REGISTRY_READY",
	"GREENHOUSE_READY",
	"FLOWER_PLANTED",
	"FLOWER_WATERED",
	"FLOWER_BLOOMED",
	"FLOWER_HARVESTED",
	"SAVE_COMPLETE",
	"SAVE_REJECTED",
	"LOAD_COMPLETE",
	"LOAD_REJECTED",
	"SESSION_END",
]

var _enabled := false
var _session_active := false
var _sequence := 0
var _session_path := ""
var _session_metadata: Dictionary = {}
var _session_start_time_ms := 0
var _clock_provider: Callable = Callable()
var _file: FileAccess
var _last_error: Dictionary = {}
var _writes_disabled_after_failure := false
var _test_force_write_failure := false


func set_enabled(enabled: bool) -> void:
	_enabled = enabled


func is_enabled() -> bool:
	return _enabled


func is_session_active() -> bool:
	return _session_active


func get_session_path() -> String:
	return _session_path


func get_last_error() -> Dictionary:
	return _last_error.duplicate(true)


func start_session(options: Dictionary = {}) -> Dictionary:
	if not _enabled:
		return _success("TELEMETRY_DISABLED")
	if _session_active:
		return _failure("TELEMETRY_SESSION_ACTIVE", "A telemetry session is already active")
	if _writes_disabled_after_failure:
		return _failure("TELEMETRY_WRITE_DISABLED", "Telemetry writes were disabled after an earlier failure")

	var output_root := str(options.get("output_root", DEFAULT_OUTPUT_ROOT))
	var root_validation := _validate_output_root(output_root)
	if not root_validation.ok:
		return root_validation
	var evidence_kind := str(options.get("evidence_kind", "functional_runtime"))
	if evidence_kind != "functional_runtime" and evidence_kind != "automated_test":
		return _failure("TELEMETRY_INVALID_CONFIGURATION", "Unsupported evidence kind")
	var session_id := str(options.get("session_id", _generate_opaque_id("session")))
	var run_id := str(options.get("run_id", _generate_opaque_id("run")))
	if not _is_safe_identifier(session_id) or not _is_safe_identifier(run_id):
		return _failure("TELEMETRY_INVALID_CONFIGURATION", "Session and run IDs must be safe opaque identifiers")

	var clock_candidate: Variant = options.get("clock_provider", Callable())
	if clock_candidate is Callable and (clock_candidate as Callable).is_valid():
		_clock_provider = clock_candidate
	else:
		_clock_provider = Callable()
	_session_start_time_ms = _now_ms()
	_sequence = 0
	_last_error = {}
	_session_metadata = {
		"session_id": session_id,
		"run_id": run_id,
		"runtime": "godot",
		"godot_version": _format_engine_version(Engine.get_version_info()),
		"project_version": str(ProjectSettings.get_setting("application/config/version", "unavailable")),
		"migration_phase": MIGRATION_PHASE,
		"content_schema_version": CONTENT_SCHEMA_VERSION,
		"save_version": SAVE_VERSION,
		"deterministic_test_seed": options.get("deterministic_test_seed", null),
		"evidence_kind": evidence_kind,
	}.duplicate(true)

	var directory_error := DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_root))
	if directory_error != OK:
		return _failure("TELEMETRY_WRITE_FAILED", "Unable to create telemetry directory", {"error": directory_error})
	_session_path = "%s/session_%s.jsonl" % [output_root, session_id]
	_file = FileAccess.open(_session_path, FileAccess.WRITE)
	if _file == null:
		return _failure("TELEMETRY_WRITE_FAILED", "Unable to open telemetry output", {"error": FileAccess.get_open_error()})
	_session_active = true
	var start_result := _write_event("SESSION_START", {"startup_mode": str(options.get("startup_mode", "debug"))})
	if not start_result.ok:
		return start_result
	return _success("OK", {"session_path": _session_path})


func record_event(event_name: String, payload: Dictionary = {}) -> Dictionary:
	if not _enabled:
		return _success("TELEMETRY_DISABLED")
	if not _session_active:
		return _failure("TELEMETRY_SESSION_INACTIVE", "No active telemetry session")
	if event_name == "SESSION_START" or event_name == "SESSION_END":
		return _failure("TELEMETRY_EVENT_MANAGED", "Session boundary events are managed by TelemetryService")
	return _write_event(event_name, payload)


func close_session(reason: String = "clean_shutdown") -> Dictionary:
	if not _session_active:
		return _success("TELEMETRY_SESSION_INACTIVE")
	var end_result := _write_event("SESSION_END", {"reason": reason})
	if _file != null:
		_file.flush()
		_file.close()
		_file = null
	_session_active = false
	if not end_result.ok:
		return end_result
	return _success("OK", {"session_path": _session_path})


func set_test_force_write_failure(enabled: bool) -> void:
	if OS.is_debug_build():
		_test_force_write_failure = enabled


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and _session_active:
		var result := close_session("window_close_request")
		if not result.ok:
			push_warning("[PLANT_TALES][TELEMETRY_WARNING] Session close failed: %s" % result.code)


func _exit_tree() -> void:
	if _session_active:
		var result := close_session("tree_exit")
		if not result.ok:
			push_warning("[PLANT_TALES][TELEMETRY_WARNING] Session close failed: %s" % result.code)


func _write_event(event_name: String, payload: Dictionary) -> Dictionary:
	if not EVENT_ALLOWLIST.has(event_name):
		return _failure("TELEMETRY_EVENT_NOT_ALLOWED", "Event name is not allow-listed", {"event_name": event_name})
	var payload_validation := _validate_payload(event_name, payload)
	if not payload_validation.ok:
		return payload_validation
	if _test_force_write_failure or _file == null:
		return _handle_write_failure("Telemetry output is unavailable")
	var timestamp := maxi(0, _now_ms() - _session_start_time_ms)
	var event_document := {
		"event_name": event_name,
		"sequence": _sequence + 1,
		"timestamp_monotonic_ms": timestamp,
		"evidence_kind": _session_metadata.evidence_kind,
		"session": _session_metadata.duplicate(true),
		"payload": payload.duplicate(true),
	}
	_file.store_line(JSON.stringify(event_document))
	_file.flush()
	if _file.get_error() != OK:
		return _handle_write_failure("Telemetry output write failed")
	_sequence += 1
	return _success("OK", {"sequence": _sequence})


func _handle_write_failure(message: String) -> Dictionary:
	var result := _failure("TELEMETRY_WRITE_FAILED", message)
	_last_error = result.duplicate(true)
	_writes_disabled_after_failure = true
	if _file != null:
		_file.close()
		_file = null
	_session_active = false
	push_warning("[PLANT_TALES][TELEMETRY_WARNING] %s" % message)
	return result


func _validate_payload(event_name: String, payload: Dictionary) -> Dictionary:
	var contracts := {
		"SESSION_START": {},
		"APP_STATE_READY": {"runtime": "string", "migration_phase": "string"},
		"CONTENT_REGISTRY_READY": {"total": "non_negative_int"},
		"GREENHOUSE_READY": {"scene": "string"},
		"FLOWER_PLANTED": {"flower_id": "string", "seed_id": "string"},
		"FLOWER_WATERED": {"flower_id": "string"},
		"FLOWER_BLOOMED": {"flower_id": "string", "growth_elapsed_minutes": "non_negative_int"},
		"FLOWER_HARVESTED": {"flower_id": "string"},
		"SAVE_COMPLETE": {"result_code": "string", "save_version": "string"},
		"SAVE_REJECTED": {"code": "string"},
		"LOAD_COMPLETE": {"result_code": "string", "save_version": "string"},
		"LOAD_REJECTED": {"code": "string"},
		"SESSION_END": {"reason": "string"},
	}
	var contract: Dictionary = contracts.get(event_name, {})
	for field_value in contract.keys():
		var field := str(field_value)
		if not payload.has(field):
			return _failure("TELEMETRY_INVALID_PAYLOAD", "%s requires %s" % [event_name, field])
		var value: Variant = payload[field]
		if contract[field] == "string" and (not value is String or str(value).is_empty()):
			return _failure("TELEMETRY_INVALID_PAYLOAD", "%s.%s must be a non-empty String" % [event_name, field])
		if contract[field] == "non_negative_int" and (typeof(value) != TYPE_INT or int(value) < 0):
			return _failure("TELEMETRY_INVALID_PAYLOAD", "%s.%s must be a non-negative integer" % [event_name, field])
	return _success("OK")


func _validate_output_root(output_root: String) -> Dictionary:
	if not output_root.begins_with("user://"):
		return _failure("UNSAFE_OUTPUT_ROOT", "Telemetry output must stay under user://")
	var relative_path := output_root.trim_prefix("user://")
	if relative_path.is_empty() or relative_path.contains("..") or relative_path.contains("\\") or relative_path.begins_with("/"):
		return _failure("UNSAFE_OUTPUT_ROOT", "Telemetry output root is unsafe")
	return _success("OK")


func _is_safe_identifier(value: String) -> bool:
	if value.is_empty() or value.contains(".."):
		return false
	for character in value:
		if not (character.to_lower() >= "a" and character.to_lower() <= "z") and not (character >= "0" and character <= "9") and character != "-" and character != "_":
			return false
	return true


func _generate_opaque_id(prefix: String) -> String:
	return "%s_%s_%s" % [prefix, Time.get_ticks_usec(), randi()]


func _now_ms() -> int:
	if _clock_provider.is_valid():
		return int(_clock_provider.call())
	return Time.get_ticks_msec()


func _format_engine_version(version_info: Dictionary) -> String:
	return "%s.%s.%s.%s" % [
		version_info.get("major", 0),
		version_info.get("minor", 0),
		version_info.get("patch", 0),
		version_info.get("status", "unknown"),
	]


func _success(code: String, details: Dictionary = {}) -> Dictionary:
	return {"ok": true, "code": code, "details": details.duplicate(true)}


func _failure(code: String, message: String, details: Dictionary = {}) -> Dictionary:
	return {"ok": false, "code": code, "message": message, "details": details.duplicate(true)}
