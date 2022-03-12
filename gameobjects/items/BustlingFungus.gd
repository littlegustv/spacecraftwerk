extends "res://gameobjects/items/Item.gd"

var not_moving_counter = 0
const TEXT = preload("res://fx/TextFX.tscn")

func tooltip_message():
	hint_tooltip = "Regen " + str( 2.0 + 2.0 * stack ) + " faster when stationary."

func modify( stat : String, proc_chance : float ):
	if stat == "regen" and not_moving_counter >= 4:
		var text = TEXT.instance()
		text.position = parent.global_position
		get_tree().current_scene.add_child( text )
		text.label.text = "mushroom."
		return 2.0 + 2.0 * stack
	return 1.0

func _on_Ticker_timeout():
	if parent.velocity.length() <= 0.1:
		not_moving_counter += 1
	else:
		not_moving_counter = 0
