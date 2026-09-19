extends Area2D
var startingPos=global_position
var dragging=false
@export var toAdd="blended"
var off=Vector2(0,0)
var timer=0
var blended=false
var iceAdd=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
		z_index=2
	else:
		position=lerp(position,startingPos,.2)
		
	if timer>0:
		timer-=1
	elif iceAdd:
		blended=true
		iceAdd=false

func _on_button_button_down() -> void:
	if timer<=0 and blended:
		dragging = true
		off = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	if blended:
		var placed=get_overlapping_areas()
		if(placed!=null):
			for thing in placed:
				if thing.get_meta("drink")==true:
					for all in thing.added:
						if(all==toAdd):
							pass
					thing.added.append(toAdd)
					
