extends Node2D

onready var cooldown = $Cooldown
var useable = true

func use():
	if useable:
		useable = false
		cooldown.start()
		return true
	else:
		return false

func _on_Cooldown_timeout():
	useable = true
