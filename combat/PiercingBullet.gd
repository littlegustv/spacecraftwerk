extends "res://combat/Projectile.gd"

func _on_HitBox_area_entered(area):
	damage_multiplier *= 1.4
