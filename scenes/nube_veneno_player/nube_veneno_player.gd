extends Area2D

signal impacto(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("nube_veneno")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		$EfectoMatar.play()
		$"/root/GameState".posicion_enemigo_muerto = body.position
		$"/root/GameState".ultimo_enemigo_muerto = body
		$"/root/GameState".enemigos_muertos += 1
		body.queue_free()

	if body.is_in_group("caja_llave"):
		body.romper()

func parpadeo_desaparecer(numero):
	for i in numero:
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(0.35, false).timeout
		$AnimatedSprite2D.show()
		await get_tree().create_timer(0.35, false).timeout
	for i in numero:
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(0.15, false).timeout
		$AnimatedSprite2D.show()
		await get_tree().create_timer(0.15, false).timeout
	queue_free()


func _on_timer_nube_veneno_timeout() -> void:
	await  parpadeo_desaparecer(2)
