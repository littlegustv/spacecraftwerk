extends "res://gameobjects/Ship.gd"

onready var animation_player = $AnimationPlayer
onready var health_bar = $CanvasLayer/HBoxContainer/AbilitiesContainer/HealthBar
onready var health_bar_label = $CanvasLayer/HBoxContainer/AbilitiesContainer/HealthBar/Label
onready var abilities_container = $CanvasLayer/HBoxContainer/AbilitiesContainer

var score : float = 0.0
var peer : bool = false

func _ready():
#	animation_player.play("Up")
	Globals.player = self
	abilities_container.add_child( Globals.player_abilities )
	abilities_container.move_child( Globals.player_abilities, 0)

func update_health_bar():
	health_bar.rect_size.x = 248 * health / max_health
	health_bar_label.text = str( health ) + " / " + str( max_health )

func hurt( damage : int ):
	.hurt( damage )
	update_health_bar()

func heal( amount : int ):
	.heal( amount )
	update_health_bar()
	
func die():
	var explosion = EXPLOSION.instance()
	explosion.position = position
	get_tree().current_scene.add_child( explosion )
	get_tree().change_scene("res://MainMenu.tscn")

func _physics_process(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1

	._physics_process( delta )

func _on_ItemPickupRadius_area_entered(area):
	for item in items.get_children():
		if item.filename == area.item.resource_path:
			item.stack()
			area.queue_free()
			return
	items.add_child( area.item.instance() )
	area.queue_free()
