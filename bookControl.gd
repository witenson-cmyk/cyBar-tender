extends Control
var open = false
var yPlace
var page = 0
@onready var book = get_node("CanvasLayer/book")
@onready var left = get_node("CanvasLayer/left")
@onready var right = get_node("CanvasLayer/right")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if open:
		yPlace = 500.0
	else:
		yPlace = 1500.0
	book.position.y=lerp(book.position.y,yPlace,.1)
	right.position.y=lerp(right.position.y,yPlace-150,.1)
	left.position.y=lerp(left.position.y,yPlace-150,.1)

func _on_open_book_button_down() -> void:
	open = not open
