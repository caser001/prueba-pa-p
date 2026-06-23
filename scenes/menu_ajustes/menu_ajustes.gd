extends Node2D

var volumen 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CheckAndroid.hide()
	$VBoxContainer/HScrollBar.value = $"/root/GameState".volumen_general


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volver_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_inicio/menu_inicio.tscn")


func _on_modo_android_pressed() -> void:
	if $"/root/GameState".android == true:
		$"/root/GameState".android = false
		$CheckAndroid.hide()
	else:
		$"/root/GameState".android = true
		$CheckAndroid.show()


func _on_h_scroll_bar_scrolling() -> void:
	volumen = $VBoxContainer/HScrollBar.value
	$"/root/GameState".volumen_general = volumen
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(volumen))
	print($"/root/GameState".volumen_general)
