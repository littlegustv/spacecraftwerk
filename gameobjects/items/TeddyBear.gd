extends "res://gameobjects/items/Item.gd"

func tooltip_message():
	hint_tooltip = "Increases evade chance by " + str( 1 + 0.8 * stack )

func modify( stat : String, proc_chance : float ):
	if stat == "evasion":
		return 1.0 + 0.8 * stack
	else:
		return 1.0
