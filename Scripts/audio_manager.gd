extends Node2D
@onready var actual_end: AudioStreamPlayer = $ActualEnd
@onready var button_noise: AudioStreamPlayer = $ButtonNoise
@onready var correct: AudioStreamPlayer = $Correct
@onready var ding: AudioStreamPlayer = $Ding
@onready var sploosh: AudioStreamPlayer = $Sploosh
@onready var wrong: AudioStreamPlayer = $Wrong
@onready var clink: AudioStreamPlayer = $PhotosMetalClink415813
@onready var low_clink: AudioStreamPlayer = $LowClink
@onready var ping: AudioStreamPlayer = $Ping

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
