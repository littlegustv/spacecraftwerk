extends "res://gameobjects/Ship.gd"

onready var animation_player = $AnimationPlayer
onready var health_bar = $CanvasLayer/HBoxContainer/AbilitiesContainer/HealthBar
onready var health_bar_label = $CanvasLayer/HBoxContainer/AbilitiesContainer/HealthBar/Label
onready var abilities_container = $CanvasLayer/HBoxContainer/AbilitiesContainer
onready var pickup_sound = $PickupSound

onready var dps_label = $CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/DPS
onready var score_label = $CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/Score
onready var shake_timer = $ShakeTimer

onready var camera = $Camera2D

var damage_per_second : float = 0.0
var shake_amount = 0.0

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

func dps( damage ):
	damage_per_second += damage

func hurt( damage : int ):
	.hurt( damage )
	shake_amount = 2.0
	shake_timer.start()
	update_health_bar()

func heal( amount : int ):
	.heal( amount )
	update_health_bar()
	
func die():
	var explosion = EXPLOSION.instance()
	explosion.position = position
	explosion.pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().current_scene.add_child( explosion )
	Globals.game_over()

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

	if shake_amount != 0:
		camera.set_offset(Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		))

func _on_ItemPickupRadius_area_entered(area):
	var new_item = area.item.instance()
	pickup_sound.play()
	var text = TEXTFX.instance()
	text.position = position
	get_tree().current_scene.add_child( text )
	text.label.text = new_item.name
	
	for item in items.get_children():
		if item.filename == area.item.resource_path:
			item.stack()
			area.queue_free()
			return
	items.add_child( new_item )
	area.queue_free()

func _on_DPSTimer_timeout():
	dps_label.text = str( ceil( damage_per_second * 4.0 ) ) + " DPS"
	damage_per_second = 0

func _on_ShakeTimer_timeout():
	shake_amount = 0.0
	camera.set_offset( Vector2.ZERO )
