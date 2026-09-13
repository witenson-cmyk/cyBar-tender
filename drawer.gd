extends Area2D
var instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = preload("res://glass.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_meta("place")==true:
		var newCup=instance.instantiate()
		newCup.lastok=get_node(".").position
		newCup.lastPlace=get_node(".")
		newCup.position=position
		get_tree().current_scene.add_child(newCup)
		set_meta("place",false)
