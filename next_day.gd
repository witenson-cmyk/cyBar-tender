extends Control
const SAVE_PATH:="res://Resources/savegame.tres"
var save_game: player_data = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	save_game.day+=1
	save_game.write_savegame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
	pass
