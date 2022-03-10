extends Node2D

onready var animation_player = $AnimationPlayer
onready var label = $Label

func _ready():
	animation_player.play("Fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
