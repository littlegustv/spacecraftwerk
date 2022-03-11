extends "res://gameobjects/items/Item.gd"

func modify( stat : String, proc_chance : float ):
	if stat == "evasion":
		return 1.0 + 0.8 * stack
	else:
		return 1.0
