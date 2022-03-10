extends "res://gameobjects/items/Item.gd"

const TEXTFX = preload("res://fx/TextFX.tscn")
const MISSILE = preload("res://combat/HomingMissile.tscn")

func proc( proc_chance : float, target = null ):
	if randi() % 100 < 10 * proc_chance:
		var text = TEXTFX.instance()
		text.position = get_parent().global_position
		get_tree().current_scene.add_child( text )
		text.label.text = "MISSILE!"
		
		var missile = MISSILE.instance()
		missile.position = get_parent().global_position
		missile.proc_chance = missile.proc_chance * proc_chance
		var targets = get_tree().get_nodes_in_group("Enemies")
		missile.target = targets[ randi() % targets.size() ]
		get_tree().current_scene.add_child( missile )
		missile.set_source( get_parent().get_parent() ) # must be a better way!
		missile.damage_multiplier = 3
	
