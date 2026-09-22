extends Area2D
var dragging=false
var off = Vector2(0,0)
var lastok
var random=RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	lastok=global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()-off
		z_index=2
	else:
		position=lerp(position,lastok,.2)


func _on_button_button_down() -> void:
	dragging = true
	off = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	var placed=get_overlapping_areas()
	var good = false
	for thing in placed:
		if thing.get_meta("patron")==true and thing.tazed==false:
			while not good:
				
				if random.randi()%100<=10:
					thing.queue_free()
				var toRemove=[]
				
				for other in thing.wants:
					if not thing.types.has(other):
						if random.randi()%100<=25:
							toRemove.append(other)
				
				if !toRemove.is_empty():
					good=true
					for another in toRemove:
						thing.wants.erase(another)
					thing.tazed=true
