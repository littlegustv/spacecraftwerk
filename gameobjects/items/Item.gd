extends Node2D

func modify( stat : String, proc_chance : float ):
	return 1.0

func proc( proc_chance : float, target = null ):
	pass

func attach_effects():
	pass

func detach_effects():
	pass

func _on_Item_tree_entered():
	attach_effects()

func _on_Item_tree_exited():
	detach_effects()
