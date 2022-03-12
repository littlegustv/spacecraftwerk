extends HBoxContainer

export (Array, PackedScene) var ships = []
onready var list = $VBoxContainer/OptionButton

func _ready():
	for ship in ships:
		var path = ship.resource_path.rsplit('/')
		list.add_item( path[ path.size() - 1 ].split('.')[0] )
	list.visible = false
	list.visible = true
	$VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	Globals.player_abilities = ships[ list.selected ].instance()
	get_tree().change_scene("res://Game.tscn")
