extends Node2D

func get_closest( p : Vector2, group : String ):
	var closest_distance = 100000
	var closest_target = null
	print("GOAL: ", p, " ", player.global_position )
	for target in get_tree().get_nodes_in_group( "Enemies" ):
		if ( target.position - p ).length() < closest_distance:
			closest_distance = ( target.position - p ).length()
			closest_target = target
			print("CLOSER ", closest_distance, " ", closest_target.position )
	print("SELECTED : ", closest_target.position )
	return closest_target

var player
