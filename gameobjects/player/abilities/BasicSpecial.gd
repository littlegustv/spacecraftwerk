extends "res://gameobjects/player/abilities/Ability.gd"

const BULLET = preload("res://combat/Bullet.tscn")

onready var shoot_timer = $ShootTimer
var count = 0

func _physics_process(delta):
	if Input.is_action_pressed("special") and use():
		shoot_timer.start()

func _on_ShootTimer_timeout():
	count += 1
	var b = BULLET.instance()
	b.position = global_position
	get_tree().current_scene.add_child( b )
	b.set_source( get_parent() )
	if count >= 10:
		count = 0
		shoot_timer.stop()
