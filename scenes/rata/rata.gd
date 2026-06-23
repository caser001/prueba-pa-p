extends CharacterBody2D

@export var _sprite_rata: AnimatedSprite2D

var player: CharacterBody2D
var attack: Area2D
var _velocidad_rata: float = 100
const _nube_veneno_enemy = preload("res://scenes/nube_veneno_enemy/nube_veneno_enemy.tscn")
const main_scene = preload("res://scenes/main_scene/main_scene.tscn")

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


func numero_random():
	return randi_range(0, 100)


func _on_timer_spawneo_veneno_timeout() -> void:
	if numero_random() <= 20:
		_velocidad_rata = 160
		$"/root/GameState".posicion_rata = self.position
		var _nube_veneno_enemy_instanciada = _nube_veneno_enemy.instantiate()
		$PeoEnemigo.play()
		get_tree().current_scene.add_child(_nube_veneno_enemy_instanciada)
		_nube_veneno_enemy_instanciada.position = $"/root/GameState".posicion_rata
		await get_tree().create_timer(0.5).timeout
		_velocidad_rata = 100
		
