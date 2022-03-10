extends "res://gameobjects/player/abilities/Ability.gd"

const HOMING_MISSILE = preload("res://combat/HomingMissile.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("primary") and use():
		var targets = get_tree().get_nodes_in_group("Enemies")
		var closest_distance = 100000
		var closest_target = null
		var mouse_position = get_global_mouse_position()
		for target in targets:
			if ( target.position - mouse_position ).length() < closest_distance:
				closest_distance = ( target.position - mouse_position ).length()
				closest_target = target
				
		if closest_target != null:
			var b = HOMING_MISSILE.instance()
			b.target = closest_target
			b.position = global_position
			get_tree().current_scene.add_child( b )
			b.set_source( get_parent() )
