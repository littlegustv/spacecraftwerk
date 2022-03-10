extends Node2D

export (int) var duration : int = 1
var source

func do_status_tick():
	pass
	
func _on_Timer_timeout():
	duration -= 1
	do_status_tick()
	if duration <= 0:
		queue_free()
