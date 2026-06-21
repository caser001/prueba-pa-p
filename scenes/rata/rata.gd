extends CharacterBody2D

@export var _sprite_rata: AnimatedSprite2D

var player: CharacterBody2D
var attack: Area2D
var _velocidad_rata: float = 100

func _ready() -> void:
	player = get_parent().get_node("Player")

func _physics_process(_delta: float) -> void:
	
	#IA y movimiento
	var direccion_rata: Vector2
	
	if player.global_position.x > global_position.x +1:
		direccion_rata.x += 1
		_sprite_rata.flip_h = true
	if player.global_position.x < global_position.x -1:
		direccion_rata.x += -1
		_sprite_rata.flip_h = false
	if player.global_position.y > global_position.y +1:
		direccion_rata.y += 1
	if player.global_position.y < global_position.y -1:
		direccion_rata.y += -1
	
	direccion_rata = direccion_rata.normalized()
	velocity = direccion_rata * _velocidad_rata
	move_and_slide()
