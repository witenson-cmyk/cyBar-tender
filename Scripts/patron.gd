extends Area2D
var infoToGet: data = data.new()
var parent
var info
var wants
var possible
var types=["stirred","shaken","blended"]
var random=RandomNumberGenerator.new()
var timerMax
var timer
var tazed=false
var label
var failed=false
var good = false
var chance=80
var talking=false
var special
var styles
var doSpecial=false
var specialName = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	info = infoToGet.dayVariables[str(parent.day)]
	wants=[]
	possible=info["possible"]
	special=info["Special"]
	styles=info["Styles"]
	timerMax=info["timerMax"]
	timer = timerMax
	label=get_node("patron label")
	
	#set up patron order
	if special and random.randi()%101<=25:
		var keys = infoToGet.Specials.keys()
		doSpecial=true
		specialName = keys[random.randi()%keys.size()]
		for thing in infoToGet.Specials[specialName]:
			wants.append(thing)
	
	while good==false and doSpecial == false:
		if wants.size()<=2 or random.randi()%101<=chance or failed:
			var next=random.randi()%possible.size()
			if wants.size()==possible.size():
				good = true
				failed = false
			elif not wants.has(possible[next]):
				wants.append(possible[next])
				chance-=10
				failed=false
			else:
				failed=true
		else:
			good=true
	if styles and not doSpecial:
		wants.append(types[random.randi()%types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer>0 and talking:
		timer-=.25*delta
	elif timer>0:
		timer-=1*delta
	else:
		get_tree().current_scene.lives=get_tree().current_scene.lives-1
		queue_free()
	
	get_node("TextureProgressBar").value = timer*100/timerMax
	
	var text = ""
	if doSpecial:
		text = specialName
	else:
		for another in wants:
			text+=another+"\n"
	label.text=text
	
func _on_button_button_down() -> void:
	talking=true

func _on_button_button_up() -> void:
	talking=false
