extends Area2D
var wants=[]
var possible=["vodka","water","fruit","sprite","soda water","whisky"]
var random=RandomNumberGenerator.new()
@export var timerMax = 7500
var timer=timerMax

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var good = false
	var chance=20
	while good==false:
		for thing in possible:
			if wants.size()<5:
				if random.randi()%100<20:
					if wants.has(thing)==false:
						wants.append(thing)
				if wants.size()>2:
					good=true
				else:
					chance+=10
	var label=get_node("patron label")
	for another in wants:
		label.text+=another+"\n"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer>0:
		timer=timer-1
	else:
		get_tree().current_scene.lives=get_tree().current_scene.lives-1
		queue_free()
	get_node("TextureProgressBar").value = timer*100/timerMax
	
