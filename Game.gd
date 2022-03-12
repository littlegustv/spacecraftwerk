extends Node2D

onready var space_bottom_layer = $ParallaxBackground/SpaceBottom
onready var space_bottom_sprite = $ParallaxBackground/SpaceBottom/Sprite

onready var space_top_layer = $ParallaxBackground/SpaceTop
onready var space_top_sprite = $ParallaxBackground/SpaceTop/Sprite

const MAX_ENEMIES = 10

const ENEMIES = [
	preload("res://gameobjects/enemies/Saucer.tscn"),
	preload("res://gameobjects/enemies/Diamond.tscn"),
	preload("res://gameobjects/enemies/Stealth.tscn"),
	preload("res://gameobjects/enemies/MantaRay.tscn"),
	preload("res://gameobjects/enemies/Enterprise.tscn")
]

func spawn_enemies():
	if get_tree().get_nodes_in_group("Enemies").size() < MAX_ENEMIES:
		var enemy = ENEMIES[ randi() % ENEMIES.size() ].instance()
		enemy.position = Globals.player.position + Vector2.ONE * ( randi() % 2048 - 1024 )
		get_tree().current_scene.add_child( enemy )

func _physics_process(delta):
	if space_bottom_sprite.position != Globals.player.global_position.snapped( Vector2.ONE * 512 / space_bottom_layer.motion_scale.x ) * space_bottom_layer.motion_scale.x:
		space_bottom_sprite.position = Globals.player.global_position.snapped( Vector2.ONE * 512 / space_bottom_layer.motion_scale.x ) * space_bottom_layer.motion_scale.x

	if space_top_sprite.position != Globals.player.global_position.snapped( Vector2.ONE * 512 / space_top_layer.motion_scale.x ) * space_top_layer.motion_scale.x:
		space_top_sprite.position = Globals.player.global_position.snapped( Vector2.ONE * 512 / space_top_layer.motion_scale.x ) * space_top_layer.motion_scale.x
		
	spawn_enemies()
