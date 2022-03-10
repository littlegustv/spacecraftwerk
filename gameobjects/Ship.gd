extends KinematicBody2D

export ( Vector2 ) var direction = Vector2.ZERO
export ( int ) var SPEED = 200
export ( int ) var ACCELERATION = 1.0
export ( int ) var attack_collision_layer = 1
export ( int ) var base_damage = 10

var velocity : Vector2 = Vector2.ZERO

const EXPLOSION = preload("res://fx/Explosion.tscn")
const TEXTFX = preload("res://fx/TextFX.tscn")

export ( int ) var max_health : int = 50
var health : int = max_health
var evasion : int = 10
var regen : int = 1

onready var items = $Items

func proc( proc_chance : float, target = null ):
	for item in items.get_children():
		item.proc( proc_chance, target )

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = lerp( velocity, direction * speed(), delta * ACCELERATION )
	move_and_slide( velocity, Vector2.UP, false, 4, 0, false )

func speed():
	var s = SPEED
	for item in items.get_children():
		s *= item.modify( "speed", 1 )
	return s

func damage( proc_chance : float = 1 ):
	var d = base_damage
	for item in items.get_children():
		d *= item.modify( "damage", proc_chance )
	return d

func regen():
	var r = regen
	for item in items.get_children():
		r *= item.modify( "regen", 1.0 )
	return r

func evasion():
	var e = evasion
	for item in items.get_children():
		e *= item.modify( "evasion", 1.0 )
	return e

func hurt( damage : int ):
	health -= damage
	var text_fx = TEXTFX.instance()
	text_fx.position = global_position
	get_tree().current_scene.add_child( text_fx )
	text_fx.label.text = str( damage )
	if health <= 0:
		die()

func heal( amount : int ):
	health = min( max_health, health + amount )

func die():
	var explosion = EXPLOSION.instance()
	explosion.position = position
	get_tree().current_scene.add_child( explosion )
	queue_free()

func _on_HurtBox_area_entered(area):
	if randi() % 100 > evasion():
		var damage = area.get_parent().damage()
		hurt( damage )
	else:
		var text = TEXTFX.instance()
		text.position = position
		get_tree().current_scene.add_child( text )
		text.label.text = "dodged!"

func _on_Ticker_timeout():
	heal( regen() )
