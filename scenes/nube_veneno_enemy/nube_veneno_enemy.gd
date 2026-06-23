extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale = Vector2(0.5, 0.5)
	await get_tree().create_timer(1, false).timeout
	self.scale = Vector2(1, 1)
	add_to_group("enemyattack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_nube_veneno_enemy_timeout() -> void:
	await parpadeo_desaparecer(2)

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
