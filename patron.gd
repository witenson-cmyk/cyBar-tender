extends Area2D
var wants=[]
var possible=["vodka","water","fruit","sprite","soda water","whisky","on the rocks"]
var types=["stirred","shaken","blended"]
var random=RandomNumberGenerator.new()
@export var timerMax = 6500
var timer=timerMax
var tazed=false
var label
var failed=false
var good = false
var chance=80
var talking=false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#set up patron order
	
	while good==false:
		if wants.size()<=2 or random.randi()%101<=chance or failed:
			var next=random.randi()%possible.size()
			if wants.size()==possible.size():
				good=true
			elif not wants.has(possible[next]):
				wants.append(possible[next])
				chance-=10
				failed=false
			else:
				failed=true
		else:
			good=true
			
	wants.append(types[random.randi()%types.size()])
	
	label=get_node("patron label")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer>0 and talking:
		timer-=.25
	elif timer>0:
		timer-=1
	else:
		get_tree().current_scene.lives=get_tree().current_scene.lives-1
		queue_free()
	
	get_node("TextureProgressBar").value = timer*100/timerMax
	
	var text = ""
	for another in wants:
		text+=another+"\n"
	label.text=text
	
func _on_button_button_down() -> void:
	talking=true

func _on_button_button_up() -> void:
	talking=false
