extends Node2D
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("equis"):
		iniciar_juego()

func _on_button_pressed() -> void:
	iniciar_juego()


func iniciar_juego():
	$"/root/GameState".player_hp = 7
	$"/root/GameState".enemigos_muertos = 0
	get_tree().change_scene_to_file("res://scenes/main_scene/main_scene.tscn")


func _on_cerrar_juego_pressed() -> void:
	get_tree().quit()


func _on_ajustes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_ajustes/menu_ajustes.tscn")
