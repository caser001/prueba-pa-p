extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_seleccionar_nitolas_pressed() -> void:
	$"/root/GameState".personaje_seleccionado = 1
	$"/root/GameState".boss_hp = 18
	get_tree().change_scene_to_file("res://scenes/main_scene/main_scene.tscn")


func _on_seleccionar_totolas_pressed() -> void:
	$"/root/GameState".personaje_seleccionado = 2
	$"/root/GameState".boss_hp = 18
	get_tree().change_scene_to_file("res://scenes/main_scene/main_scene.tscn")


func _on_volver_al_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_inicio/menu_inicio.tscn")
