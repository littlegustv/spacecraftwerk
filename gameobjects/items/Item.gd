extends TextureRect

# hboxcontainer -> vboxcontainer -> canvaslayer -> player
onready var parent = get_parent().get_parent().get_parent().get_parent()
onready var stack_label = $Label
var stack : int = 1

func stack():
	stack += 1
	stack_label.text = str( stack )
	if stack > 1:
		stack_label.visible = true

func modify( stat : String, proc_chance : float ):
	return 1.0

func proc( proc_chance : float, target = null ):
	pass

func attach_effects():
	pass

func detach_effects():
	pass

func _on_Item_tree_entered():
	attach_effects()

func _on_Item_tree_exited():
	detach_effects()
