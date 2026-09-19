extends Area2D
var instance
var timer=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = preload("res://ice.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_meta("icePlace")==true and timer<=0:
		var newIce=instance.instantiate()
		newIce.lastok=get_node(".").global_position
		newIce.lastPlace=get_node(".")
		newIce.position=global_position
		newIce.startingPos=global_position
		get_tree().current_scene.add_child(newIce)
		set_meta("icePlace",false)
		timer=1200
	elif timer<0:
		timer-=1
