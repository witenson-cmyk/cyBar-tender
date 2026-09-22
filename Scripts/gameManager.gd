extends Node2D
var camera
var mov
var lives = 3
var points = 0
var places=[null,null,null,null,null,null]
var timer=3
var instance
var newPerson
var random=RandomNumberGenerator.new()
const SAVE_PATH:="res://Resources/savegame.tres"
var save_game: player_data = null
var day
var gameTime = 0
var gameTimer = 0
var dayStarted = false
var infoToGet: data = data.new()
var info

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_node("camera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	instance = preload("res://patron.tscn")
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = player_data.new()
	day=save_game.days
	info=infoToGet.dayVariables[str(day)]
	
	if not info["possible"].has("on the rocks"):
		get_node("iceMachine").queue_free()
	
	if not info["Styles"]:
		get_node("stiring").queue_free()
		get_node("shaker").queue_free()
		get_node("blender").queue_free()
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
	
	#spawning patrons
	if timer>0 and dayStarted:
		timer-=1*delta
	elif dayStarted:
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
		timer=30-random.randi()%15
	
	#game timer
	if dayStarted:
		gameTimer+=3*delta
	gameTime=int(gameTimer/30)*30
	var gameHT: int = int((gameTime/60)+9)%13
	var gameMT: int = int(gameTime)%60
	var label = get_node("Control/CanvasLayer/ui")
	var gameHL=str(gameHT)
	var gameML=""
	if gameMT<10:
		gameML="0"+str(gameMT)
	else:
		gameML=str(gameMT)
	
	#end the day
	if gameHT==3:
		save_game.days+=1
		save_game.write_savegame()
		get_tree().change_scene_to_file("res://next_day.tscn")
		
	#update UI
	label.text="Points: "+str(points)+" Lives: "+str(lives)+" "+gameHL+":"+gameML

func _on_button_button_down() -> void:
	dayStarted=true
	get_node("startDay").queue_free()
