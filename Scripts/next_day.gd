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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
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
	if dNum<lines.size():
			point.text+=lines[dNum]
			point.text+="\n"
			dNum+=1
			camera.position.y=cameraBMAX
	
func _input(event):
	if event.is_action_pressed("ui_accept") and visChars==point.get_total_character_count():
		if dNum<lines.size():
			point.text+=lines[dNum]
			point.text+="\n"
			dNum+=1
			camera.position.y=cameraBMAX
		else:
			get_tree().change_scene_to_file("res://node_2d.tscn")
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
		visChars+=75*delta
	point.visible_characters=visChars
