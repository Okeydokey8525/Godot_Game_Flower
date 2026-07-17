extends Node

const DEFAULT_SAVE_PATH := "user://saves/save_slot_01.json"
const SAVE_VERSION := "1.0.0"
const ENGINE_RUNTIME := "godot"
const CONTENT_SCHEMA_VERSION := "1.0.0-STABLE"


func has_save(save_path: String = DEFAULT_SAVE_PATH) -> bool:
	return _validate_save_path(save_path).ok and FileAccess.file_exists(save_path)


func save_document(document: Dictionary, save_path: String = DEFAULT_SAVE_PATH) -> Dictionary:
	var path_result := _validate_save_path(save_path)
	if not path_result.ok:
		return path_result
	var validation := validate_document(document)
	if not validation.ok:
		return validation
	var parent_error := DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(save_path.get_base_dir()))
	if parent_error != OK:
		return _failure("WRITE_FAILED", "Unable to create save directory", {"error": parent_error})
	var serialized := JSON.stringify(document, "\t", true) + "\n"
	var temporary_path := "%s.tmp" % save_path
	var previous_path := "%s.previous" % save_path
	var write_result := _write_text(temporary_path, serialized)
	if not write_result.ok:
		return write_result
	var temporary_verification := load_document(temporary_path)
	if not temporary_verification.ok:
		_remove_if_exists(temporary_path)
		return _failure("TEMP_VERIFICATION_FAILED", "Temporary save could not be validated", temporary_verification)
	var replacement := _replace_transactionally(save_path, temporary_path, previous_path)
	if not replacement.ok:
		return replacement
	return _success({"save_path": save_path})


func load_document(save_path: String = DEFAULT_SAVE_PATH) -> Dictionary:
	var path_result := _validate_save_path(save_path)
	if not path_result.ok:
		return path_result
	if not FileAccess.file_exists(save_path):
		return _failure("SAVE_NOT_FOUND", "Save file does not exist", {"save_path": save_path})
	var file := FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return _failure("INVALID_JSON", "Save file could not be opened", {"error": FileAccess.get_open_error()})
	var parser := JSON.new()
	var parse_error := parser.parse(file.get_as_text())
	file.close()
	if parse_error != OK or not parser.data is Dictionary:
		return _failure("INVALID_JSON", "Save file is not a JSON object", {"error": parse_error})
	var document: Dictionary = parser.data
	var validation := validate_document(document)
	if not validation.ok:
		return validation
	return _success({"document": document.duplicate(true), "save_path": save_path})


func validate_document(document: Dictionary) -> Dictionary:
	if not document.has("save_version") or not document.has("engine_runtime") or not document.has("content_schema_version") or not document.has("world_state"):
		return _failure("INVALID_ENVELOPE", "Save envelope is missing required fields")
	if document.save_version != SAVE_VERSION:
		return _failure("UNSUPPORTED_SAVE_VERSION", "Unsupported save version", {"save_version": document.save_version})
	if document.engine_runtime != ENGINE_RUNTIME:
		return _failure("WRONG_RUNTIME", "Save runtime is not Godot", {"engine_runtime": document.engine_runtime})
	if document.content_schema_version != CONTENT_SCHEMA_VERSION:
		return _failure("INCOMPATIBLE_CONTENT_SCHEMA", "Content schema is incompatible", {"content_schema_version": document.content_schema_version})
	if not document.world_state is Dictionary:
		return _failure("INVALID_ENVELOPE", "world_state must be an object")
	if not document.world_state.has("elapsed_gameplay_minutes") or not document.world_state.has("greenhouse"):
		return _failure("INVALID_ENVELOPE", "world_state is missing required sections")
	if not document.world_state.greenhouse is Dictionary or not document.world_state.greenhouse.has("plot"):
		return _failure("INVALID_ENVELOPE", "greenhouse plot section is missing")
	return _success()


func _replace_transactionally(save_path: String, temporary_path: String, previous_path: String) -> Dictionary:
	var save_absolute := ProjectSettings.globalize_path(save_path)
	var temporary_absolute := ProjectSettings.globalize_path(temporary_path)
	var previous_absolute := ProjectSettings.globalize_path(previous_path)
	_remove_if_exists(previous_path)
	var moved_previous := false
	if FileAccess.file_exists(save_path):
		var backup_error := DirAccess.rename_absolute(save_absolute, previous_absolute)
		if backup_error != OK:
			_remove_if_exists(temporary_path)
			return _failure("REPLACEMENT_FAILED", "Unable to preserve previous save", {"error": backup_error})
		moved_previous = true
	var replace_error := DirAccess.rename_absolute(temporary_absolute, save_absolute)
	if replace_error != OK:
		if moved_previous and FileAccess.file_exists(previous_path) and not FileAccess.file_exists(save_path):
			DirAccess.rename_absolute(previous_absolute, save_absolute)
		_remove_if_exists(temporary_path)
		return _failure("REPLACEMENT_FAILED", "Unable to replace active save; rollback attempted", {"error": replace_error})
	if FileAccess.file_exists(previous_path):
		_remove_if_exists(previous_path)
	return _success()


func _write_text(path_value: String, text: String) -> Dictionary:
	var file := FileAccess.open(path_value, FileAccess.WRITE)
	if file == null:
		return _failure("WRITE_FAILED", "Unable to open temporary save", {"error": FileAccess.get_open_error()})
	file.store_string(text)
	file.flush()
	file.close()
	return _success()


func _remove_if_exists(path_value: String) -> void:
	if FileAccess.file_exists(path_value):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path_value))


func _validate_save_path(path_value: String) -> Dictionary:
	if not path_value.begins_with("user://"):
		return _failure("UNSAFE_SAVE_PATH", "Save path must remain inside user://")
	var relative_path := path_value.trim_prefix("user://")
	if relative_path.is_empty() or relative_path.begins_with("/") or relative_path.contains("\\") or relative_path.contains(".."):
		return _failure("UNSAFE_SAVE_PATH", "Save path contains unsafe components")
	return _success()


func _success(details: Dictionary = {}) -> Dictionary:
	return {"ok": true, "code": "OK", "message": "Success", "details": details.duplicate(true)}


func _failure(code: String, message: String, details: Dictionary = {}) -> Dictionary:
	return {"ok": false, "code": code, "message": message, "details": details.duplicate(true)}
