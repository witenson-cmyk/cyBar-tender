extends Area2D

var dragging = false
var off = Vector2(0,0)
var lastok= Vector2(0,0)
var added=[]
var lastPlace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
	else:
		position=lerp(position,lastok,.2)


func _on_button_button_down() -> void:
	dragging = true
	off = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	var placed=get_overlapping_areas()
	if(placed!=null):
		for thing in placed:
			if thing.get_meta("place")==true:
				lastok=thing.global_position
				thing.set_meta("place",false)
				if(lastPlace!=null):
					lastPlace.set_meta("place",true)
				lastPlace=thing
			elif thing.get_meta("trash")==true:
				lastPlace.set_meta("place",true)
				queue_free()
