extends "res://gameobjects/items/Item.gd"

var not_moving_counter = 0
const TEXT = preload("res://fx/TextFX.tscn")

func modify( stat : String, proc_chance : float ):
	if stat == "regen" and not_moving_counter >= 8:
		var text = TEXT.instance()
		text.position = get_parent().global_position
		get_tree().current_scene.add_child( text )
		text.label.text = "mushroom."
		return 4.0
	return 1.0

func _on_Ticker_timeout():
	if get_parent().get_parent().velocity.length() <= 0.1:
		not_moving_counter += 1
	else:
		not_moving_counter = 0
