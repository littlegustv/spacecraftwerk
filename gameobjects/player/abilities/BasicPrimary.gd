extends "res://gameobjects/player/abilities/Ability.gd"

const BULLET = preload("res://combat/Bullet.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("primary") and use():
		var b = BULLET.instance()
		b.position = parent.global_position
		get_tree().current_scene.add_child( b )
		b.set_source( parent )
