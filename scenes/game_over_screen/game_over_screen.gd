extends Node2D

@onready var total_enemigos_muertos = $TotalEnemigosMuertos

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("equis"):
		iniciar_menu()

func _ready() -> void:
	actualizar_puntuacion()
	if $"/root/GameState".enemigos_muertos > $"/root/GameState".record:
		$"/root/GameState".record = $"/root/GameState".enemigos_muertos
		$"/root/GameState".personaje_seleccionado_record = $"/root/GameState".personaje_seleccionado
		$"/root/GameState".cantidad_botellas_veneno_usadas_record = $"/root/GameState".cantidad_botellas_veneno_usadas
		guardar_datos()
	if $"/root/GameState".personaje_seleccionado == 1 and $"/root/GameState".enemigos_muertos >= 500:
		$"/root/GameState".nitolas_corona = true
		guardar_datos()
	if $"/root/GameState".personaje_seleccionado == 2 and $"/root/GameState".enemigos_muertos >= 500:
		$"/root/GameState".totolas_corona = true
		guardar_datos()
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	if $"/root/GameState".personaje_seleccionado == 1:
		$VBoxContainer/RecordPersonaje.text = "Con: Nitolas"
	elif $"/root/GameState".personaje_seleccionado == 2:
		$VBoxContainer/RecordPersonaje.text = "Con: Totolas"
	else:
		$VBoxContainer/RecordPersonaje.text = "Con: Nadie"
	$VBoxContainer/RecordVeneno.text = "Veneno gastado: " + str($"/root/GameState".cantidad_botellas_veneno_usadas)


func _on_boton_reiniciar_pressed() -> void:
	iniciar_menu()

func actualizar_puntuacion():
	total_enemigos_muertos.text = str($"/root/GameState".enemigos_muertos)


func iniciar_menu():
	get_tree().change_scene_to_file("res://scenes/menu_inicio/menu_inicio.tscn")

func guardar_datos():
	var datos = {
		"record": $"/root/GameState".record,
		"personaje_seleccionado_record": $"/root/GameState".personaje_seleccionado_record,
		"cantidad_botellas_veneno_usadas_record": $"/root/GameState".cantidad_botellas_veneno_usadas_record,
		"nitolas_corona": $"/root/GameState".nitolas_corona,
		"totolas_corona": $"/root/GameState".totolas_corona
	}

	print("Guardando:", datos)
	var archivo = FileAccess.open("user://save.dat", FileAccess.WRITE)
	archivo.store_var(datos)
