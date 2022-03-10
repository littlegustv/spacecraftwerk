extends "res://gameobjects/items/Item.gd"

func modify( stat : String, proc_chance : float ):
	if stat == "speed":
		return 1.14
	else:
		return 1
