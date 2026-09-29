extends Area2D
var startingPos=global_position
var dragging=false
@export var toAdd="blended"
var off=Vector2(0,0)
var timer=0
var blended=false
var iceAdd=false
var sprite
var blendingSpr = load("res://Sprites/blenderBlending.png")
var noBlendSpr = load("res://Sprites/blenderDepressed.png")
@onready var button = get_node("Sprite2D/Button")
var random = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite=get_node("Sprite2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
		z_index=2
	else:
		position=lerp(position,startingPos,.2)
		
	if timer>0:
		timer-=1*delta
	elif iceAdd:
		blended=true
		iceAdd=false
	
	if blended:
		button.tooltip_strings[0] = "Blender (Blended)"
		sprite.set_texture(blendingSpr)
	elif iceAdd and timer > 0:
		button.tooltip_strings[0] = "Blender (Blending)"
		sprite.set_texture(blendingSpr)
		var offY = random.randi()%5
		var offX = random.randi()%5
		get_node("Sprite2D").position.x=offX
		get_node("Sprite2D").position.y=offY
	else:
		button.tooltip_strings[0] = "Blender (Needs Ice)"
		sprite.set_texture(noBlendSpr)

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
				if thing.has_meta("drink"):
					for all in thing.added:
						if(all==toAdd):
							return
					thing.added.append(toAdd)
					blended=false
					
