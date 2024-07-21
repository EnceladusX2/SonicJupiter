extends Node2D

@export var music = preload("res://Audio/Music/door_into_summer.ogg")
@export var speed = 0
@export var nextScene = load("res://Scene/Presentation/CharacterSelect.tscn")
var titleEnd = false

func _ready() -> void:
	Global.music.stream = music
	Global.music.play()

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("gm_pause") and !titleEnd:
		titleEnd = true
		Global.main.change_scene_to_file(nextScene,"FadeOut","FadeOut",1)
