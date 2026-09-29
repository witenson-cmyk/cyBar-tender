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
@onready var filled = load("res://Sprites/cuppFilled.png")

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
	
	if not added.is_empty():
		get_node("CollisionShape2D/Sprite2D").texture = filled
		get_node("CollisionShape2D/Sprite2D/outline").texture = filled


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
			elif thing.has_meta("trash"):
				lastPlace.set_meta("place",true)
				queue_free()
			elif thing.has_meta("patron"):
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

func _mouse_enter() -> void:
	get_node("CollisionShape2D/Sprite2D/outline").visible=true

func _mouse_exit() -> void:
	get_node("CollisionShape2D/Sprite2D/outline").visible=false
