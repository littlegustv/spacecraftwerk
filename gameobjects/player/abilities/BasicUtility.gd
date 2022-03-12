extends "res://gameobjects/player/abilities/Ability.gd"

onready var animation_player = $AnimationPlayer

func _ready():
	var blink_animation = Animation.new()
	
	blink_animation.add_track( 0 )
	blink_animation.track_set_path( 0, NodePath( str( parent.get_path() ) + ":modulate" ) )
	blink_animation.track_insert_key( 0, 0, Color.white )
	blink_animation.track_insert_key( 0, 0.2, Color.transparent )
	blink_animation.track_insert_key( 0, 0.4, Color.transparent )
	blink_animation.track_insert_key( 0, 0.6, Color.white )
	
	blink_animation.add_track( 2 )
	blink_animation.track_set_path( 1, get_path() )
	blink_animation.track_insert_key( 1, 0.4,  {"method" : "blink" , "args" : []} )
	
	animation_player.add_animation("Blink", blink_animation)

func blink():
	var destination = parent.get_global_mouse_position()
	parent.position = destination

func _physics_process(delta):
	if Input.is_action_pressed("utility") and use():
		animation_player.play("Blink")
