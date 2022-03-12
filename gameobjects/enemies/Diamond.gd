extends "res://gameobjects/enemies/BaseEnemy.gd"

const BOMB = preload("res://combat/Bomb.tscn")

func seek_player( delta : float ):
	direction = lerp( direction, ( Globals.player.position - position ).normalized(), delta  )

func _on_ActionTimer_timeout():
	if ( Globals.player.position - position ).length() <= 32:
		velocity = Vector2.ZERO
		var bomb = BOMB.instance()
		bomb.scale.x = 2
		bomb.scale.y = 2
		bomb.position = position + 16 * direction.normalized()
		bomb.damage_multiplier = 10.0
		get_tree().current_scene.add_child( bomb )
		bomb.set_source( self )
		action_timer.stop()
		yield( bomb, "tree_exited" )
		die()
