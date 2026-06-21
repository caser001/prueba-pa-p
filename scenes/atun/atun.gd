extends CharacterBody2D

@export var _sprite_atun: AnimatedSprite2D
@export var _sprite_jetpack: AnimatedSprite2D
@export var _particulas_jetpack: GPUParticles2D

var player: CharacterBody2D
var attack: Area2D
var _velocidad_atun: float = 65
var _velocidad_extra_atun: float = 270
var turbo: bool = false
@onready var _particulas_jetpack_procesadas = _particulas_jetpack.process_material as ParticleProcessMaterial

func _ready() -> void:
	player = get_parent().get_node("Player")

func _physics_process(_delta: float) -> void:
	
	#IA y movimiento
	var direccion_atun: Vector2
	
	if player.global_position.x > global_position.x +1:
		direccion_atun.x += 1
		_sprite_atun.flip_h = true
		_sprite_jetpack.flip_h = true
		_sprite_jetpack.position.x = -12
		_particulas_jetpack.position.x = -10
		_particulas_jetpack.scale.x = -1
	if player.global_position.x < global_position.x -1:
		direccion_atun.x += -1
		_sprite_atun.flip_h = false
		_sprite_jetpack.flip_h = false
		_sprite_jetpack.position.x = 12
		_particulas_jetpack.position.x = 10
		_particulas_jetpack.scale.x = 1
	if player.global_position.y > global_position.y +1:
		direccion_atun.y += 1
	if player.global_position.y < global_position.y -1:
		direccion_atun.y += -1
	
	direccion_atun = direccion_atun.normalized()
	if turbo == false:
		velocity = direccion_atun * _velocidad_atun
	else:
		velocity = direccion_atun * _velocidad_extra_atun
	move_and_slide()


func numero_random():
	return randi_range(1, 3)


func _on_timer_turbo_timeout() -> void:
	if turbo == false:
		if numero_random() == 1:
			$sprite_atun.modulate = Color(1.0, 0.353, 0.353, 1.0)
			await get_tree().create_timer(0.10).timeout
			$sprite_atun.modulate = Color(1,1,1)
			await get_tree().create_timer(0.10).timeout
			$sprite_atun.modulate = Color(1.0, 0.353, 0.353, 1.0)
			await get_tree().create_timer(0.10).timeout
			$sprite_atun.modulate = Color(1,1,1)
			$sprite_atun/sprite_jetpack.modulate = Color(1,1,1)
			turbo = true
			_particulas_jetpack.amount = 150
			_particulas_jetpack_procesadas.initial_velocity_min = 100
			_particulas_jetpack_procesadas.initial_velocity_max = 200
	else:
		$sprite_atun.modulate = Color(1,1,1)
		turbo = false
		_particulas_jetpack.amount = 35
		_particulas_jetpack_procesadas.initial_velocity_min = 15
		_particulas_jetpack_procesadas.initial_velocity_max = 40
