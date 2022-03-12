extends TextureRect

onready var cooldown = $Cooldown
onready var cooldown_ui = $CooldownUI
onready var cooldown_label = $CooldownUI/Label
onready var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
export (int) var max_charges = 1
onready var charges = max_charges
onready var charges_label = $Charges

func _ready():
	if max_charges > 1:
		charges_label.visible = true
		charges_label.text = str( charges )

func use():
	if charges > 0:
		do_cooldown()
		return true
	else:
		return false

func do_cooldown():
	charges -= 1
	charges_label.text = str( charges )
	cooldown.start()
	cooldown_ui.visible = true
	cooldown_label.text = str( cooldown.wait_time )

func _physics_process(delta):
	if cooldown_ui.visible == true:
		cooldown_label.text = str( stepify( cooldown.time_left, 0.1 ) )

func on_cooldown():
	charges += 1
	charges_label.text = str( charges )
	if charges >= max_charges:
		cooldown_ui.visible = false
		cooldown.stop()

func _on_Cooldown_timeout():
	on_cooldown()
