extends HBoxContainer

export (Array, PackedScene) var ships = []
onready var list = $VBoxContainer/OptionButton
onready var cheat_code = $VBoxContainer/LineEdit

func _ready():
	get_tree().paused = false
	for ship in ships:
		var path = ship.resource_path.rsplit('/')
		list.add_item( path[ path.size() - 1 ].split('.')[0] )
	list.visible = false
	list.visible = true
	$VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	Globals.player_abilities = ships[ list.selected ].instance()
	if cheat_code.text == "host":
		Globals.host()
	elif cheat_code.text != "" and cheat_code.text != null:
		Globals.join( cheat_code.text )
	get_tree().change_scene("res://Game.tscn")
