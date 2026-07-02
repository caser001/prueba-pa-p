extends Area2D

var direccion := Vector2.ZERO
var velocidad := 500.0

signal impacto(body)

func _ready():
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _physics_process(delta):
	position += direccion * velocidad * delta


func _on_body_entered(body: Node2D) -> void:
	emit_signal("impacto", body)
	queue_free()
