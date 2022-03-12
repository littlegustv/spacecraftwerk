extends "res://combat/Projectile.gd"

func _ready():
	rotation = direction.angle() - PI / 2

func on_hit( target = null ):
	queue_free()
