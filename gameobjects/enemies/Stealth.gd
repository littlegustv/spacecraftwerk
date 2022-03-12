extends "res://gameobjects/enemies/BaseEnemy.gd"

export (float) var desired_distance = 128
const BULLET = preload("res://combat/Bullet.tscn")

func seek_player( delta : float ):
	if ( Globals.player.position - position ).length() > desired_distance:
		direction = lerp( direction, ( Globals.player.position - position ).normalized(), delta  )
	else:
		direction = lerp( direction, Vector2.ZERO, delta  )

func _on_ActionTimer_timeout():
	var bullet = BULLET.instance()
	bullet.damage_multiplier = 1.5
	bullet.direction = ( Globals.player.position - position ).normalized()
	bullet.SPEED = 300
	bullet.position = position
	get_tree().current_scene.add_child( bullet )
	bullet.set_source( self )
	
