extends "res://gameobjects/items/Item.gd"

const TEXTFX = preload("res://fx/TextFX.tscn")
const MISSILE = preload("res://combat/HomingMissile.tscn")

func tooltip_message():
	hint_tooltip = "Chance to fire missile on hit for " + str( 3 * stack * 100 ) + "% damage."

func proc( proc_chance : float, target = null ):
	if randi() % 100 < 10 * proc_chance:
		var text = TEXTFX.instance()
		text.position = parent.global_position
		get_tree().current_scene.add_child( text )
		text.label.text = "MISSILE!"
		
		var missile = MISSILE.instance()
		missile.position = parent.global_position
		missile.proc_chance = missile.proc_chance * proc_chance
		missile.target = Globals.get_closest( Globals.player.position, "Enemies" )
		get_tree().current_scene.add_child( missile )
		missile.set_source( parent ) # must be a better way!
		missile.damage_multiplier = 3 * stack
	
