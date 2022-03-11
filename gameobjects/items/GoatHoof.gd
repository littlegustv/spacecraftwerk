extends "res://gameobjects/items/Item.gd"

func modify( stat : String, proc_chance : float ):
	if stat == "speed":
		return 1.0 + 0.14 * stack
	else:
		return 1
