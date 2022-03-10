extends AnimatedSprite

func _ready():
	play()

func _on_SpriteFX_animation_finished():
	queue_free()
