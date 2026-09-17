extends Node2D
var camera
var mov
var lives = 3
var points = 0
var places=[null,null,null,null,null,null]
var timer=0
var instance
var newPerson
var random=RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_node("camera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	instance = preload("res://patron.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#camera movement

	var mousePos=get_viewport().get_mouse_position().x
	mousePos=clamp(mousePos,0,1920)
	if mousePos<250:
		mov=251/mousePos
		mov=clamp(mov,.1,25)
		camera.position.x-=mov
	if mousePos>1670:
		mov=250/(1921-mousePos)
		mov=clamp(mov,.1,25)
		camera.position.x+=mov
	camera.position.x=clamp(camera.position.x,0,2000)
	
	#ui
	
	var label = get_node("Control/CanvasLayer/ui")
	label.text="Points: "+str(points)+" Lives: "+str(lives)
	
	#spawning patrons
	
	if timer!=0:
		timer-=1
	else:
		var didIt=false
		if places.has(null):
			while didIt==false:
				var ran=random.randi()%4
				if places[ran]==null:
					newPerson=instance.instantiate()
					get_tree().current_scene.add_child(newPerson)
					didIt=true
					newPerson.position.x=500*ran-700
					newPerson.position.y=500
					places[ran]=newPerson
		timer=2000-random.randi()%1500
