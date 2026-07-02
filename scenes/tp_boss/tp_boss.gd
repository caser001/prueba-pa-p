extends Node2D

var ya_activado := false

func _ready() -> void:
	$Area2D/PuertaAbierta.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if ya_activado:
		return

	if body.is_in_group("player") and $"/root/GameState".llave == true:
		ya_activado = true

		var puerta_abierta = $Area2D/PuertaAbierta
		var puerta_cerrada = $Area2D/PuertaCerrada

		puerta_abierta.show()
		puerta_cerrada.hide()

		await get_tree().create_timer(0.3).timeout

		get_tree().change_scene_to_file("res://scenes/boss_scene/boss_scene.tscn")
		print("tepeadno zona boss")
