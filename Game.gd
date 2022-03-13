extends Node2D

onready var space_bottom_layer = $ParallaxBackground/SpaceBottom
onready var space_bottom_sprite = $ParallaxBackground/SpaceBottom/Sprite

onready var space_top_layer = $ParallaxBackground/SpaceTop
onready var space_top_sprite = $ParallaxBackground/SpaceTop/Sprite

var budget : float = 10.0
var enemies_unlocked : float = 5.0

const PLAYER = preload("res://gameobjects/Player.tscn")
const MAX_ENEMIES = 10
const ENEMIES = [
	preload("res://gameobjects/enemies/Saucer.tscn"),
	preload("res://gameobjects/enemies/MantaRay.tscn"),
	preload("res://gameobjects/enemies/Stealth.tscn"),
	preload("res://gameobjects/enemies/Diamond.tscn"),
	preload("res://gameobjects/enemies/Enterprise.tscn")
]

func enemy_die( enemy ):
	budget += enemy.bounty
	enemies_unlocked += 1

func _ready():
	Globals.game = self
	
	var player = PLAYER.instance()
	player.position = Vector2.ZERO
	get_tree().current_scene.add_child( player )
	
	for i in range(0, 5):
		spawn_enemies()

func spawn_enemies():
	if budget > 0:
		var enemy = ENEMIES[ randi() % int( min( ENEMIES.size(), ceil( enemies_unlocked / 4 ) ) ) ].instance()
		enemy.position = Globals.player.position + Vector2.ONE * ( randi() % 1600 - 800 )
		budget -= enemy.cost
		get_tree().current_scene.add_child( enemy )

func _physics_process(delta):
	if space_bottom_sprite.position != Globals.player.global_position.snapped( Vector2.ONE * 512 / space_bottom_layer.motion_scale.x ) * space_bottom_layer.motion_scale.x:
		space_bottom_sprite.position = Globals.player.global_position.snapped( Vector2.ONE * 512 / space_bottom_layer.motion_scale.x ) * space_bottom_layer.motion_scale.x

	if space_top_sprite.position != Globals.player.global_position.snapped( Vector2.ONE * 512 / space_top_layer.motion_scale.x ) * space_top_layer.motion_scale.x:
		space_top_sprite.position = Globals.player.global_position.snapped( Vector2.ONE * 512 / space_top_layer.motion_scale.x ) * space_top_layer.motion_scale.x

func _on_SpawnTimer_timeout():
	spawn_enemies()
