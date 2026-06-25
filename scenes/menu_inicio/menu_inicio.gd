extends Node2D

func _ready() -> void:
	$VBoxContainer/RecordEnemigos.text = "Record: " + str($"/root/GameState".record)
	if $"/root/GameState".personaje_seleccionado_record == 1:
		$VBoxContainer/RecordPersonaje.text = "Con: Nitolas"
	elif $"/root/GameState".personaje_seleccionado_record == 2:
		$VBoxContainer/RecordPersonaje.text = "Con: Totolas"
	else:
		$VBoxContainer/RecordPersonaje.text = "Con: Nadie"
	$VBoxContainer/RecordVeneno.text = "Veneno gastado: " + str($"/root/GameState".cantidad_botellas_veneno_usadas_record)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("equis"):
		iniciar_juego()

func _on_button_pressed() -> void:
	iniciar_juego()

func iniciar_juego():
	get_tree().change_scene_to_file("res://scenes/seleccion_de_personaje/seleccion_de_personaje.tscn")

func _on_cerrar_juego_pressed() -> void:
	get_tree().quit()


func _on_ajustes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_ajustes/menu_ajustes.tscn")
