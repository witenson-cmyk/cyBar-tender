extends Resource
class_name player_data

const SAVE_PATH := "res://Resources/savegame.tres"

@export var days: int
@export var points: int
@export var fired: int

func write_savegame() -> void:
	var error_code := ResourceSaver.save(self, SAVE_PATH)
	if error_code != OK:
		push_error("Failed to save game: " + error_string(error_code))
	
static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	return null
