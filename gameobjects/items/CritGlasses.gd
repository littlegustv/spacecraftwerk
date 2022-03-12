extends "res://gameobjects/items/Item.gd"

func tooltip_message():
	hint_tooltip = str( 10 * stack ) + "% chance to deal double damage."

func modify( stat : String, proc_chance : float ):
	if stat == "damage" and randi() % 100 < proc_chance * 10 * stack:
		return 2.0
	else:
		return 1.0
