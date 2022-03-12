extends "res://gameobjects/enemies/BaseEnemy.gd"

const BEAM = preload("res://combat/BeamProjectile.tscn")
const BOMB = preload("res://combat/Bomb.tscn")

func seek_player( delta : float ):
	direction = lerp( direction, ( Globals.player.position - position ).normalized(), delta  )


func _on_ActionTimer_timeout():
	if ( Globals.player.position - position ).length() <= 32:
		velocity = Vector2.ZERO
		var bomb = BOMB.instance()
		bomb.position = position + 16 * direction.normalized()
		bomb.damage_multiplier = 2.0
		get_tree().current_scene.add_child( bomb )
		bomb.set_source( self )
	elif ( Globals.player.position - position ).length() < 640:
		velocity = Vector2.ZERO
		var beam = BEAM.instance()
		beam.damage_multiplier = 2.5
		beam.direction = direction
		beam.position = position
		beam.target = Globals.player
		get_tree().current_scene.add_child( beam )
		beam.set_source( self )
