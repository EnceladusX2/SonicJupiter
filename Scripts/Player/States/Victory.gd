extends PlayerState

# variable to keep track of if the player "jumped" during their victory animation
var jumped = false
# variable to give us a bit of leeway when jumping, so we don't auto switch to the next animation
var jumpSafety = 0

func state_activated():
	# play our victory animation, we can change animations later if there's more then one
	parent.animator.play("victory")

func _process(_delta: float) -> void:
	# grab a reference to the current frame of our character sprite, because Godot doesn't have an animation frame property on the AnimationPlayer
	var current_frame = parent.sprite.frame

	# make our player instantly stop moving
	parent.groundSpeed = 0
	parent.movement.x = 0

	# perform specialized victory poses
	match (parent.character):
		# Amy
		parent.CHARACTERS.AMY:
			if current_frame == 78 and parent.animator.current_animation == "victory":
				parent.animator.stop(true)
				parent.movement.y = -2.0*60
				jumped = true
			else:
				pass

			if jumped and jumpSafety >= 10 and parent.ground:
				parent.animator.play("victoryLand")
				jumped = false
				jumpSafety = 0
				return
		# redundant catch all for the characters. Godot yells at me if I don't have this
		_:
			parent.animator.play("victory")

# we use physics process so we can have a consistant update for our values
func _physics_process(delta: float) -> void:
	# always add to jumpSafety if jumped is true
	if jumped:
		jumpSafety += 1

	if !parent.ground:
		# make sure the player always has gravity
		parent.movement.y += parent.grv/GlobalFunctions.div_by_delta(delta)
