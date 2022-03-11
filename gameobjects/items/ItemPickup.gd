extends Area2D

export( Array, PackedScene ) var drops = []
var item : PackedScene

func _ready():
	if drops.size() > 0:
		item = drops[ randi() % drops.size() ]
