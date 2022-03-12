extends "res://combat/Projectile.gd"

var target : Node2D
export (int) var turn_rate = 10

func _physics_process(delta):
	if target:
		rotation = direction.angle() - PI / 2
		direction = lerp( direction, ( target.position - position ).normalized(), turn_rate * delta )
	else:
		queue_free()
	._physics_process(delta)

func on_hit( target = null ):
	queue_free()
