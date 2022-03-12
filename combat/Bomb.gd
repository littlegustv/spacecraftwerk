extends "res://combat/Projectile.gd"

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func on_hit( target = null ):
	queue_free()
