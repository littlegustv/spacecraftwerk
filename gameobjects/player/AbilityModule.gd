extends HBoxContainer

onready var parent = get_parent().get_parent().get_parent().get_parent()

export ( Texture ) var texture
export ( int ) var speed = 80
export ( int ) var base_damage  = 10
export ( int ) var max_health = 150

func _ready():
	parent.sprite.texture = texture
	parent.SPEED = speed
	parent.base_damage = base_damage
	parent.max_health = max_health
