extends Node2D
var camera
var movSpeed=2
var mov
var lives = 3
var points = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_node("camera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#camera movement

	var mousePos=get_viewport().get_mouse_position().x
	mousePos=clamp(mousePos,0,1920)
	if mousePos<250:
		if mousePos>1:
			mov=250/mousePos
		mov=clamp(mov,3,25)
		camera.position.x-=mov
	if mousePos>1670:
		if mousePos<1920:
			mov=250/(1920-mousePos)
		else:
			mov=mov
		mov=clamp(mov,3,25)
		camera.position.x+=mov
	camera.position.x=clamp(camera.position.x,0,2000)
	var label = get_node("Control/CanvasLayer/ui")
	label.text="Points: "+str(points)+" Lives: "+str(lives)
