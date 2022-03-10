extends "res://gameobjects/items/Item.gd"

const BLEED_EFFECT = preload("res://combat/Status/BleedEffect.tscn")

func proc( proc_chance : float, target = null ):
	if target != null:
		var bleed = BLEED_EFFECT.instance()
		bleed.source = get_parent().get_parent()
		target.add_child( bleed )
