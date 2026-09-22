extends Control
var open = true
var yPlace
var pages = []
@onready var book = get_node("CanvasLayer/book")
@onready var left = get_node("CanvasLayer/left")
@onready var right = get_node("CanvasLayer/right")
@onready var wordPlace = get_node("CanvasLayer/right/RichTextLabel")
var info: dialogue = dialogue.new()
@onready var day = get_parent().day
var save_game: player_data = null
var Dinfo: data = data.new()
const SAVE_PATH:="res://Resources/savegame.tres"
var page = 0
var totalPages = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = player_data.new()
	day=save_game.days
	var i = 1
	while i <= day:
		pages.append(info.bookPages[str(i)])
		i+=1
	page = day-1
	totalPages = day-1
	if day>=3:
		var specialsPage = ""
		for thing in Dinfo.Specials:
			var toAdd="	"
			for other in Dinfo.Specials[thing]:
				toAdd+=other+", "
			toAdd+="\n\n"
			specialsPage+=thing+"\n"+toAdd
		pages.append(specialsPage)
		totalPages+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if open:
		yPlace = 500.0
	else:
		yPlace = 1500.0
	page=clamp(page,0,totalPages)
	book.position.y=lerp(book.position.y,yPlace,.1)
	right.position.y=lerp(right.position.y,yPlace-150,.1)
	left.position.y=lerp(left.position.y,yPlace-150,.1)
	wordPlace.text=pages[page]

func _on_open_book_button_down() -> void:
	open = not open

func _on_right_button_down() -> void:
	page+=1

func _on_left_button_down() -> void:
	page-=1
