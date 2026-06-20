extends Node2D

@onready var total_ratas_muertas = $TotalRatasMuertas

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("equis"):
		iniciar_menu()

func _ready() -> void:
	actualizar_puntuacion()
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	

func _on_boton_reiniciar_pressed() -> void:
	iniciar_menu()

func actualizar_puntuacion():
	total_ratas_muertas.text = str($"/root/GameState".ratas_muertas)


func iniciar_menu():
	$"/root/GameState".player_hp = 7
	$"/root/GameState".ratas_muertas = 0
	get_tree().change_scene_to_file("res://scenes/menu_inicio/menu_inicio.tscn")
