extends "res://gameobjects/player/abilities/Ability.gd"

const PROJECTILE = preload("res://combat/BouncingProjectile.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("secondary") and use():
		var b = PROJECTILE.instance()
		b.damage_multiplier = 2.5
		b.bounce_multiplier = 1.1
		b.proc_chance = 0.8
		b.position = parent.global_position
		b.target = Globals.get_closest( b.position, "Enemies" )
		get_tree().current_scene.add_child( b )
		b.set_source( parent )
