extends "res://gameobjects/player/abilities/Ability.gd"

func _physics_process(delta):
	if Input.is_action_pressed("utility") and use():
		parent.velocity = 150 * parent.direction
