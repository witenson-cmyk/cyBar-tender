extends Area2D

var dragging = false
var off = Vector2(0,0)
var lastok= Vector2(0,0)
var added=[]
var lastPlace
var wanted
var got
var previousPosition = global_position
@onready var button = get_node("CollisionShape2D/Sprite2D/Button")

# Called when the node enters the scene tree for the first time.simple and clean birth by sleep
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
		z_index=2
	else:
		position=lerp(position,lastok,.2)
	var toolText=""
	if added.is_empty():
		toolText="Empty Liquor Glass"
	else:
		toolText = "Liquor Glass ("
		for thing in added:
			if added.find(thing)==added.size()-1:
				toolText+=thing.capitalize()+")"
			else:
				toolText+=thing.capitalize()+", "
	button.tooltip_strings[0]=toolText
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
			if thing.get_meta("place")==true:
				lastok=thing.global_position
				thing.set_meta("place",false)
				if(lastPlace!=null):
					lastPlace.set_meta("place",true)
				lastPlace=thing
			elif thing.get_meta("trash")==true:
				lastPlace.set_meta("place",true)
				queue_free()
			elif thing.get_meta("patron")==true:
				added.sort()
				thing.wants.sort()
				if added==thing.wants:
					var pointsToAdd=added.size()*50
					if thing.wants.has("on the rocks"):
						pointsToAdd+=150
					get_tree().current_scene.points+=pointsToAdd
				else:
					get_tree().current_scene.lives=get_tree().current_scene.lives-1
				thing.queue_free()
				lastPlace.set_meta("place",true)
				queue_free()
