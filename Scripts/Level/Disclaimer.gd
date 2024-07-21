extends Node2D

@export var nextScene = preload("res://Scene/Presentation/TitleNew.tscn") # Skip the powered by screen for now
var alreadyChanged = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout

	if !alreadyChanged:
		$AnimationPlayer.play("Fade")
		$MenuDisc.play()
		await $AnimationPlayer.animation_finished
		if !alreadyChanged:
			alreadyChanged = true
			Global.main.change_scene_to_file(nextScene, "FadeOut", "FadeOut", 1)

func _input(event):
	# check if start gets pressed
	if event.is_action_pressed("gm_pause") and !alreadyChanged:
		alreadyChanged = true # used so that room skipping isn't doubled
		Global.main.change_scene_to_file(nextScene,"FadeOut","FadeOut",1)
