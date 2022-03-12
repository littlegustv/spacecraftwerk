extends "res://gameobjects/player/abilities/Ability.gd"

const BOMB = preload("res://combat/Bomb.tscn")

onready var shoot_timer = $ShootTimer

var count = 0
var max_count : int = 20

export (int) var radius = 48

var target_position : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("special") and use():
		target_position = parent.get_global_mouse_position()
		shoot_timer.start()

func _on_ShootTimer_timeout():
	if count <= max_count:
		count += 1
		var bomb = BOMB.instance()
		bomb.proc_chance = 0.2
		var angle = randf() * 2 * PI
		bomb.position = target_position + Vector2( cos( angle ), sin( angle ) ) * ( randi() % radius )
		get_tree().current_scene.add_child( bomb )
		bomb.set_source( parent )
	else:
		shoot_timer.stop()
		count = 0
