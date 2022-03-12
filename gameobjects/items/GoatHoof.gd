extends "res://gameobjects/items/Item.gd"

func tooltip_message():
	hint_tooltip = "Increase movement speed by " + str( 14 * stack ) + "%"

func modify( stat : String, proc_chance : float ):
	if stat == "speed":
		return 1.0 + 0.14 * stack
	else:
		return 1
