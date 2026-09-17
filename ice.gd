extends Area2D
var startingPos
var dragging=false
@export var toAdd="on the rocks"
var off=Vector2(0,0)
var lastok=Vector2(0,0)
var lastPlace
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
	else:
		position=lerp(position,startingPos,.2)


func _on_button_button_down() -> void:
	dragging = true
	off = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	var placed=get_overlapping_areas()
	if(placed!=null):
		for thing in placed:
			if thing.get_meta("drink")==true:
				for all in thing.added:
					if(all==toAdd):
						pass
				thing.added.append(toAdd)
				lastPlace.set_meta("icePlace",true)
				queue_free()
			elif thing.get_meta("blender")==true:
				if thing.iceAdd==false:
					thing.iceAdd=true
					thing.timer=1000
				queue_free()
