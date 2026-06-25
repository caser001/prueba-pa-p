extends Node2D

var volumen 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $"/root/GameState".android == false:
		$CheckMovil.hide()
	$VBoxContainer/HScrollBar.value = $"/root/GameState".volumen_general


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volver_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_inicio/menu_inicio.tscn")


func _on_modo_android_pressed() -> void:
	if $"/root/GameState".android == true:
		$"/root/GameState".android = false
		$CheckMovil.hide()
	else:
		$"/root/GameState".android = true
		$CheckMovil.show()


func _on_h_scroll_bar_scrolling() -> void:
	volumen = $VBoxContainer/HScrollBar.value
	$"/root/GameState".volumen_general = volumen
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(volumen))
	print($"/root/GameState".volumen_general)

func _on_reiniciar_record_pressed() -> void:
	$"/root/GameState".record = 0
	$"/root/GameState".personaje_seleccionado_record = 0
	$"/root/GameState".cantidad_botellas_veneno_usadas_record = 0
	$"/root/GameState".nitolas_corona = false
	$"/root/GameState".totolas_corona = false
	guardar_datos()
	
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
