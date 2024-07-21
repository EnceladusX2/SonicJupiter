extends CharacterBody2D

@onready var parent = get_parent()

func physics_collision(body, _hitVector):
	parent.handle_collision(body)
