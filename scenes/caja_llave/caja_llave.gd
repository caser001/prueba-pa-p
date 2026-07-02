extends StaticBody2D

var recogible = false
var cogiendo = false

func _ready():
	$Llave.hide()
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y - 3, 0.8)
	tween.tween_property(self, "position:y", position.y, 0.8)

func romper():
	$Caja.hide()
	recogible = true
	$Llave.show()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and recogible == true:
		cogiendo = true
		$Llave.hide()
		$"/root/GameState".llave = true
		$Area2D.queue_free()
		await get_tree().create_timer(3).timeout
		queue_free()
