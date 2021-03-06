extends "res://gameobjects/items/Item.gd"

const BLEED_EFFECT = preload("res://combat/Status/BleedEffect.tscn")

func tooltip_message():
	hint_tooltip = str( 10 * stack ) + "% chance to apply bleed."

func proc( proc_chance : float, target = null ):
	if randi() % 100 < ( 10 * proc_chance * stack ) and target != null:
		var bleed = BLEED_EFFECT.instance()
		bleed.source = parent
		target.add_child( bleed )
