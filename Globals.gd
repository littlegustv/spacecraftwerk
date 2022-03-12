extends Node2D

func get_closest( p : Vector2, group : String, exclude : Array = [] ):
	var closest_distance = 100000
	var closest_target = null
	for target in get_tree().get_nodes_in_group( "Enemies" ):
		if exclude.has( target ):
			pass
		elif ( target.position - p ).length() < closest_distance:
			closest_distance = ( target.position - p ).length()
			closest_target = target
	return closest_target

var player
var player_abilities
