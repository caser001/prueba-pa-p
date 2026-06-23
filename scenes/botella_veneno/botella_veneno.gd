extends StaticBody2D

var cogiendo: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y - 3, 0.8)
	tween.tween_property(self, "position:y", position.y, 0.8)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		cogiendo = true
		$AnimatedSprite2D.hide()
		$"/root/GameState".cantidad_botellas_veneno += 1
		$Area2D.queue_free()
		$Recoger.play()
		await get_tree().create_timer(3).timeout
		queue_free()


func parpadeo_desaparecer(numero):
	for i in numero:
		if cogiendo == true:
			$AnimatedSprite2D.hide()
			break
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(0.35, false).timeout
		if cogiendo == true:
			$AnimatedSprite2D.hide()
			break
		$AnimatedSprite2D.show()
		await get_tree().create_timer(0.35, false).timeout
	for i in numero:
		if cogiendo == true:
			$AnimatedSprite2D.hide()
			break
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(0.15, false).timeout
		if cogiendo == true:
			$AnimatedSprite2D.hide()
			break
		$AnimatedSprite2D.show()
		await get_tree().create_timer(0.15, false).timeout
	if cogiendo != true:
		$AnimatedSprite2D.hide()
		queue_free()


func _on_timer_desaparecer_timeout() -> void:
	if cogiendo == false:
		await parpadeo_desaparecer(3)
