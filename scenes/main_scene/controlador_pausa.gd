extends Node


func _unhandled_input(event):
	if event.is_action_pressed("pause") and not event.is_echo():
		if get_tree().paused:
			get_tree().paused = false
		else:
			get_tree().paused = true

		# corta el input del frame actual
		get_viewport().set_input_as_handled()
