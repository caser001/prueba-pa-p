extends Area2D

var direccion := Vector2.ZERO
var velocidad := 400

func _ready() -> void:
	var objetivo = $"/root/GameState".posicion_jugador
	direccion = (objetivo - global_position).normalized()
	rotation = direccion.angle()
	await get_tree().create_timer(2).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	global_position += direccion * velocidad * delta



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print(body)
		body.recibir_dano()
