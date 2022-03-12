extends "res://combat/Projectile.gd"

onready var hitbox_collision_shape = $HitBox/CollisionShape2D

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func on_hit( target = null ):
	queue_free()

func set_source( src ):
	.set_source( src )
	hitbox_collision_shape.disabled = false
