extends Node2D


# Called when the node enters the scene tree for the first time.



func _on_title_button_down() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")


func _on_retry_button_down() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
