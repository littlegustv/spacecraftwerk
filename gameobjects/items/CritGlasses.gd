extends "res://gameobjects/items/Item.gd"

func modify( stat : String, proc_chance : float ):
	if stat == "damage" and randi() % 100 < proc_chance * 10:
		return 2.0
	else:
		return 1.0
