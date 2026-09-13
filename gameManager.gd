extends Node2D
var camera
var movSpeed=2
var mov
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_node("camera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#camera movement
	
	var mousePos=get_viewport().get_mouse_position().x
	mousePos=clamp(mousePos,0,1920)
	if mousePos<450:
		if mousePos>1:
			mov=450/mousePos
		mov=clamp(mov,3,25)
		camera.position.x-=mov
	if mousePos>1470:
		if mousePos<1920:
			mov=450/(1920-mousePos)
		else:
			mov=mov
		mov=clamp(mov,3,25)
		camera.position.x+=mov
	camera.position.x=clamp(camera.position.x,-1000,1000)
