extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ovni_vacio/SpriteAlien.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		pass


func _on_ovni_vacio_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		body.request_ovni_phase.emit()
		body.queue_free()
		$ovni_vacio/SpriteVacio.hide()
		$ovni_vacio/SpriteAlien.show()
		var tween = create_tween()
		tween.tween_property( $ovni_vacio, "position", $ovni_vacio/SpriteAlien.position + Vector2(200, 0), 0.3)
		tween.tween_interval(8)
		$ovni_vacio/SpriteAlien.flip_h = true
		tween.tween_property( $ovni_vacio, "position", $ovni_vacio/SpriteAlien.position + Vector2(0, 0), 0.3)
		await tween.finished
		$ovni_vacio/SpriteAlien.hide()
		$ovni_vacio/SpriteVacio.show()
		$ovni_vacio/SpriteAlien.flip_h = false
		return
