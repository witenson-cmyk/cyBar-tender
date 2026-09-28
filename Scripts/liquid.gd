extends Area2D
var startingPos=global_position
var dragging=false
@export var toAdd="vodka"
var off=Vector2(0,0)
var previousPosition = startingPos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
		z_index=3
	else:
		position=lerp(position,startingPos,.2)
		z_index = 1
	var shmoovX = (global_position.x - previousPosition.x)/100
	var shmoovY = (global_position.y - previousPosition.y)/100*sign(shmoovX)
	var shmoov = shmoovY+shmoovX
	shmoov = clamp(shmoov,-.50,.50)
	get_node("CollisionShape2D/Sprite2D").rotation = shmoov
	previousPosition=global_position


func _on_button_button_down() -> void:
	dragging = true
	off = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	var placed=get_overlapping_areas()
	if(placed!=null):
		for thing in placed:
			if thing.has_meta("drink"):
				for all in thing.added:
					if(all==toAdd):
						return
				thing.added.append(toAdd)
