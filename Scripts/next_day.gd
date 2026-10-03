extends Node2D
const SAVE_PATH:="res://Resources/savegame.tres"
var save_game: player_data = null
var text: dialogue = dialogue.new()
var speak: String
var speaks
var cameraBMAX = 0
var dNum = 0
var lines = []
var whos = []
var words
var camera
var point
var visChars = 0
@onready var label=get_node("Camera2D/Label")
var i = 0
var bMaxTemp=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = player_data.new()
		save_game.write_savegame()
	speak=text.words.get(str(save_game.days))
	speaks=speak.split("\n")
	for other in speaks:
		words = other.split(" ")
		var who = words[0]
		words.remove_at(0)
		var line = ""
		for more in words:
			line+=more+" "
		lines.append(line)
		whos.append(who)
	camera = get_node("Camera2D")
	point = get_node("RichTextLabel")
	point.text+="Current Account Balance: %.2f" %(save_game.points/100)+"\n"
	
	
func _input(event):
	if event.is_action_pressed("ui_accept") and visChars==point.get_total_character_count():
		if dNum<lines.size():
			point.text+=text.headers[(whos[dNum]).to_lower()]
			point.text+=lines[dNum]
			point.text+="[/color]\n"
			dNum+=1
			camera.position.y=cameraBMAX
		elif save_game.days<6:
			get_tree().change_scene_to_file("res://node_2d.tscn")
		else:
			DirAccess.remove_absolute("res://Resources/savegame.tres")
			get_tree().change_scene_to_file("res://start_screen.tscn")
	elif event.is_action_pressed("ui_accept"):
		visChars = point.get_total_character_count()
		
	if event.is_action_pressed("ui_text_scroll_down"):
		camera.position.y+=45
	
	if event.is_action_pressed("ui_text_scroll_up"):
		camera.position.y-=45
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cameraBMAX = point.get_content_height()-950
	if cameraBMAX<0:
		cameraBMAX=0
	camera.position.y=clamp(camera.position.y,0,cameraBMAX)
	if visChars < point.get_total_character_count():
		visChars+=45*delta
		visChars=clamp(visChars,0,point.get_total_character_count())
	var prevCharacters = point.visible_characters
	point.visible_characters=visChars
	if int(prevCharacters)!=int(point.visible_characters):
		AudioManager.ping.play()
	
	if bMaxTemp!=cameraBMAX:
		camera.position.y=cameraBMAX
	bMaxTemp=cameraBMAX
	i += 2.5*delta
	if i >=360:
		i = 0
	var visibility = abs(sin(i))
	visibility = clamp(visibility,.2,1)
	label.modulate.a=sin(visibility)
