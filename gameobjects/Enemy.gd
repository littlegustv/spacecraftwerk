extends "res://gameobjects/Ship.gd"

const BULLET = preload("res://combat/Bullet.tscn")
var desired_offset : Vector2 = Vector2( randi() % 32 - 16, -32 - randi() % 64 )

onready var shoot_timer = $ShootTimer

func _ready():
	SPEED = randi() % 40 + 20
	shoot_timer.wait_time = randf() * 3 + 3

func _physics_process(delta):
	if ( ( Globals.player.position + desired_offset ) - position ).length() > 16:
		direction = lerp( direction, ( ( Globals.player.position + desired_offset ) - position ).normalized(), delta  )
	else:
		direction = lerp( direction, Vector2( -direction.y, -direction.x ), delta / 10 )

func _on_ShootTimer_timeout():
	var b = BULLET.instance()
	b.position = position
	b.direction = ( Globals.player.position - position ).normalized()
	b.rotation = b.direction.angle() - PI / 2
	b.SPEED = 150
	get_tree().current_scene.add_child( b )
	b.set_source( self )
