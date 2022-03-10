extends "res://combat/Projectile.gd"

func on_hit():
	queue_free()
