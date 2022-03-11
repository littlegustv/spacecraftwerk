extends "res://gameobjects/player/abilities/Ability.gd"

const HOMING_MISSILE = preload("res://combat/HomingMissile.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("primary") and use():
		var closest_target = Globals.get_closest( parent.get_global_mouse_position(), "Enemies" )
				
		if closest_target != null:
			var b = HOMING_MISSILE.instance()
			b.target = closest_target
			b.position = parent.global_position
			get_tree().current_scene.add_child( b )
			b.set_source( parent )
