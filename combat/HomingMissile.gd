extends "res://combat/Projectile.gd"

var target : Node2D

func _physics_process(delta):
	if target:
		rotation = direction.angle() - PI / 2
		direction = lerp( direction, ( target.position - position ).normalized(), 10 * delta )
	else:
		queue_free()
	._physics_process(delta)

func on_hit():
	queue_free()
