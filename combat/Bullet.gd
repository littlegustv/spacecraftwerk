extends "res://combat/Projectile.gd"

func on_hit( target = null ):
	queue_free()
