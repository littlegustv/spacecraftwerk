extends Node2D

export (float) var proc_chance = 1.0
export (float) var damage_multiplier = 1.0

export (int) var SPEED = 400
export (Vector2) var direction = Vector2.UP

onready var hitbox = $HitBox

var source

func set_source( src ):
	source = src
	hitbox.collision_layer = src.attack_collision_layer

func damage():
	if source:
		return source.damage( proc_chance ) * damage_multiplier

func _physics_process(delta):
	position += SPEED * delta * direction

func on_hit( target = null ):
	pass

func _on_HitBox_area_entered(area):
	if source != null:
		source.proc( proc_chance, area.get_parent() )
	on_hit( area.get_parent() )
