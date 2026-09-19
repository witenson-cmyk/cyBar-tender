extends Control

const SAVE_PATH := "user://savegame.tres"

var save_game: player_data = null


func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
		save_game.points+=50
		save_game.write_savegame()
	else:
		save_game = player_data.new()
		save_game.days=1
		save_game.points+=50
		save_game.write_savegame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
	pass
