extends Control
const SAVE_PATH := "user://savegame.tres"
var save_game: player_data = null

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = player_data.new()
		save_game.write_savegame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_down() -> void:
	get_tree().quit()


func _on_start_game_button_down() -> void:
	get_tree().change_scene_to_file("res://next_day.tscn")
