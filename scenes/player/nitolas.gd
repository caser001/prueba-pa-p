extends CharacterBody2D

var _velocidad: float = 220
var player_position: Vector2 = position
var atacando: bool = false
var _ataque_instanciado_posicion: Vector2
var direccion_ataque: Vector2
var rata: CharacterBody2D
var interfaz: Control
var recieving_damage: bool
var numero_parpadeos: int = 6


const ataque = preload("res://scenes/attack/attack.tscn")


signal enemigo_menos


func _ready() -> void:
	interfaz = get_parent().get_node("Interfaz")
	$AnimatedSprite2D.play("idle_down")
	if $"/root/GameState".nitolas_corona == true:
		$Corona.show()
	else:
		$Corona.hide()

func _physics_process(_delta: float) -> void:
	$"/root/GameState".posicion_jugador = self.position
	interfaz.actualizar_ratas_muertas($"/root/GameState".enemigos_muertos)
	
	#movimiento	
	var direccion: Vector2
	if Input.is_action_pressed("right"):
		direccion.x += 1
	if Input.is_action_pressed("left"):
		direccion.x += -1
	if Input.is_action_pressed("down"):
		direccion.y += 1
	if Input.is_action_pressed("up"):
		direccion.y += -1


	#animaciones
	if direccion_ataque.y < 0:
		if velocity.y == 0:
			$AnimatedSprite2D.play("idle_up")
		else:
			$AnimatedSprite2D.play("move_up")
	if direccion_ataque.y > 0:
		if velocity.y == 0:
			$AnimatedSprite2D.play("idle_down")
		else:
			$AnimatedSprite2D.play("move_down")
	if direccion_ataque.x < 0:
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle_left")
		else:
			$AnimatedSprite2D.play("move_left")
	if direccion_ataque.x > 0:
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle_right")
		else:
			$AnimatedSprite2D.play("move_right")
			
		
	direccion = direccion.normalized()
	velocity = direccion * _velocidad
	move_and_slide()
	
	if direccion != Vector2.ZERO:
		direccion_ataque = direccion
	
		
	#ataque
	if Input.is_action_just_pressed("equis") and atacando == false:
		$EfectoAranazo.play()
		atacando = true
		var _ataque_instanciado = ataque.instantiate()
		add_child(_ataque_instanciado)
		_ataque_instanciado.impacto.connect(_on_ataque_impacto)
		_ataque_instanciado.position.y = 35
		if direccion_ataque.x > 0:
			_ataque_instanciado.position = Vector2(35, 0)
		if direccion_ataque.x < 0:
			_ataque_instanciado.position = Vector2(-35, 0)
		if direccion_ataque.y > 0:
			_ataque_instanciado.position =  Vector2(0, 45)
		if direccion_ataque.y < 0:
			_ataque_instanciado.position  = Vector2(0, -35)
		await get_tree().create_timer(0.15).timeout
		_ataque_instanciado_posicion = _ataque_instanciado.position
		_ataque_instanciado.queue_free()
		await get_tree().create_timer(0.1).timeout
		atacando = false

	#recibir dano y sonido
	if !recieving_damage:
		for body in $Hitbox.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				recibir_dano()
				$EfectoMaullido.play()
				parpadeo()
			break
			
			
	#cambiar de escena al morir
	if $"/root/GameState".player_hp == 0:
		get_tree().change_scene_to_file("res://scenes/game_over_screen/game_over_screen.tscn")


func _on_ataque_impacto(body):
	if body.is_in_group("enemies"):
		$"/root/GameState".posicion_enemigo_muerto = body.position
		$"/root/GameState".ultimo_enemigo_muerto = body
		body.queue_free()
		enemigo_menos.emit()


func recibir_dano():
	recieving_damage = true
	$"/root/GameState".player_hp -= 1
	if $"/root/GameState".player_hp < 0:
		$"/root/GameState".player_hp = 0
	await get_tree().create_timer(1.5).timeout
	recieving_damage = false
	

	
func parpadeo():
	for i in numero_parpadeos:
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.show()
		await get_tree().create_timer(0.1).timeout

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyattack"):
		recibir_dano()
		$EfectoMaullido.play()
		parpadeo()
