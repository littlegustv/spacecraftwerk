extends TextureRect

onready var cooldown = $Cooldown
onready var cooldown_ui = $CooldownUI
onready var cooldown_label = $CooldownUI/Label
onready var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
var useable = true

func use():
	if useable:
		useable = false
		cooldown.start()
		cooldown_ui.visible = true
		cooldown_label.text = str( cooldown.wait_time )
		return true
	else:
		return false

func _physics_process(delta):
	if cooldown_ui.visible == true:
		cooldown_label.text = str( stepify( cooldown.time_left, 0.1 ) )

func _on_Cooldown_timeout():
	useable = true
	cooldown_ui.visible = false
