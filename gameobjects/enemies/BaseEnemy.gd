extends "res://gameobjects/Ship.gd"

# for spawning logic
export (int) var cost = 1.0
export (int) var bounty = 10.0

const ITEM_PICKUP = preload("res://gameobjects/items/ItemPickup.tscn")

onready var action_timer = $ActionTimer

func seek_player( delta : float ):
	pass

func _physics_process(delta):
	seek_player( delta )
	._physics_process( delta )
	rotation = stepify( direction.angle(), PI / 4 )

func die():
	Globals.player.score += bounty
	if randi() % 100 < 50 and get_tree():
		var item_pickup = ITEM_PICKUP.instance()
		item_pickup.position = position
		get_tree().current_scene.add_child( item_pickup )
	Globals.game.enemy_die( self )
	.die()
