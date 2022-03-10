extends "res://combat/Status/StatusEffect.gd"

func do_status_tick():
	if source != null:
		get_parent().hurt( 0.2 * source.damage( 0 ) )
