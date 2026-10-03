extends Node2D
var camera
var mov
var lives = 3
var points = 0
var places=[null,null,null,null,null,null,null]
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
var peeps = []
@export var timerMax=30
var dayOver=false
var dayActuallyOver = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_node("camera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	instance = preload("res://patron.tscn")
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = player_data.new()
		save_game.write_savegame()
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
	if lives <=0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		return
		
	#camera movement
	var mousePos=get_viewport().get_mouse_position().x
	mousePos=clamp(mousePos,0,1920)
	var winSize = get_window().size.x
	if mousePos<winSize*.15:
		mov=251/mousePos
		mov=clamp(mov,.1,25)
		camera.position.x-=mov
	elif mousePos>winSize-winSize*.15:
		mov=250/(1921-mousePos)
		mov=clamp(mov,.1,25)
		camera.position.x+=mov
	camera.position.x=clamp(camera.position.x,0,2000)
	
	#spawning patrons
	if timer>0 and dayStarted and not dayOver:
		timer-=1*delta
	elif dayStarted and not dayOver:
		var didIt=false
		if places.has(null):
			while didIt==false:
				var ran=random.randi()%places.size()
				if places[ran]==null:
					if peeps.is_empty():
						load_peeps()
					newPerson=instance.instantiate()
					get_node("patrons").add_child(newPerson)
					AudioManager.ding.play()
					didIt=true
					newPerson.position.x=500*ran-800
					newPerson.position.y=350
					newPerson.z_index=0
					var picked = random.randi()%peeps.size()
					newPerson.get_node("CollisionShape2D/Sprite2D").texture=peeps[picked]
					peeps.remove_at(picked)
					places[ran]=newPerson
		timer=timerMax-day*2-random.randi()%(9+day)
	
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
	
	if gameHT>=12:
		gameML+= " AM"
	else:
		gameML+= " PM"
	
	#end the day
	if gameHT>3 and gameHT<8 and not dayOver:
		dayOver=true
		AudioManager.actual_end.play()
	
	if places.is_empty() and dayOver:
		if day<5:
			save_game.days+=1
			save_game.points+=points
			save_game.write_savegame()
			get_tree().change_scene_to_file("res://next_day.tscn")
		elif day==5:
			save_game.points+=points-9000
			save_game.write_savegame()
			if save_game.points>=0:
				save_game.days+=2
				save_game.write_savegame()
			else:
				save_game.days+=1
				save_game.write_savegame()
			get_tree().change_scene_to_file("res://start_screen.tscn")
		
	var pointLabel: String = str(int(points/100))+"."
	if points%100==0:
		pointLabel+="00"
	else:
		pointLabel+=str(points%100)
	#update UI
	label.text="Tips: "+pointLabel+"       Citations Remaining: "+str(lives)+"       Time: "+gameHL+":"+gameML

func _on_button_button_down() -> void:
	AudioManager.button_noise.play()
	dayStarted=true
	get_node("startDay").queue_free()
	
func load_peeps():
	for file_name in DirAccess.get_files_at("res://Sprites/patrons/"):
		if(file_name.get_extension()=="import"):
			file_name = file_name.replace(".import","")
			peeps.append(load("res://Sprites/patrons/"+file_name))
			
