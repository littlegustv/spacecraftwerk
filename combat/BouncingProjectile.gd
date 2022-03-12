extends "res://combat/HomingMissile.gd"

var max_bounces : int = 5
var bounces : int = 0
var bounce_multiplier : float = 1.0

export(int) var min_distance = 4
export(int) var max_distance = 128

func on_hit( t = null ):
	if bounces < max_bounces:
		bounces += 1
		damage_multiplier *= bounce_multiplier
		var new_target = Globals.get_closest( position, "Enemies", [ t, target ] )
		if new_target:
			var distance = ( position - new_target.position ).length()
			if distance < max_distance and distance > min_distance:
				target = new_target
			else:
				queue_free()
		else:
			queue_free()
	else:
		queue_free()
