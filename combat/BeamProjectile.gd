extends "res://combat/Projectile.gd"

var target
var target_point : Vector2

onready var tween = $Tween

func _ready():
	tween.interpolate_property( self, "modulate", Color.transparent, Color.white, 1.0 )
	tween.start()
	pass

func _physics_process(delta):
	if target:
		direction = lerp( direction, ( target.position - position ).normalized(), delta )
		target_point = position + direction * 1000
		update()

func _draw():
	draw_line( Vector2.ZERO, target_point - position, Color("#008751"), 2.0, false )

func _on_Tween_tween_all_completed():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray( position, target_point, [source], 8, false, true )
	if result.size() > 0:
		result["collider"].get_parent().hurt( damage() )
	queue_free()
