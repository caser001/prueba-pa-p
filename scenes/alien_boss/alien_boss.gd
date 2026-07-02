extends CharacterBody2D

signal request_ovni_phase

@export var speed :int
@export var balas_max :int

var areas = []
var current_area : Area2D
var moving := false
var player_area : Area2D
var recargando := false
var moviendose := true
var balas :int
var zonas_visitadas: int = 0
var muerto = false

@onready var agent = $NavigationAgent2D
@onready var timer = $Timer

const disparo_alien = preload("res://scenes/disparo_alien/disparo_alien.tscn")
const pistola_item = preload("res://scenes/pistola_item/pistola_item.tscn")

func _ready():
	balas = balas_max
	var area_controller = get_parent().get_node("GrupoAreas")
	area_controller.player_entered_area.connect(_on_player_entered_area)
	
	areas = area_controller.get_children().filter(func(n): return n is Area2D)

	$TimerMovimiento.timeout.connect(_on_timer_movimiento_timeout)

	current_area = areas.pick_random()
	call_deferred("move_to_random_area")
	restar_vida_boss()


func _physics_process(delta):
	if muerto == false:
		if velocity != Vector2.ZERO:
			moviendose = true
		else:
			moviendose = false
		if recargando == false:
			var next = agent.get_next_path_position()
			var dir = global_position.direction_to(next)
			if agent.is_navigation_finished():
				actualizar_idle_jugador()
				velocity = Vector2.ZERO
				move_and_slide()
				if $TimerMovimiento.is_stopped():
					$TimerMovimiento.start()
				return
				
			actualizar_animacion(dir)
			velocity = dir * speed
			move_and_slide()
		
func move_to_random_area():
	var possible = areas.filter(
		func(a):
			if a == current_area or a == player_area:
				return false

			if a.name == "AreaOvni" and zonas_visitadas < 8:
				return false

			return true
	)

	if possible.is_empty():
		return

	current_area = possible.pick_random()
	print(current_area.name)
	print("zonas visitadas:", zonas_visitadas)

	if current_area.name == "AreaOvni":
		zonas_visitadas = 0
	else:
		zonas_visitadas += 1

	var target = current_area.get_node("Marker2D").global_position
	agent.target_position = target
	$TimerMovimiento.stop()


func _on_player_entered_area(area):
	player_area = area

	if current_area == player_area:
		$TimerMovimiento.stop()
		move_to_random_area()

	if current_area == player_area:
		$TimerMovimiento.stop()
		move_to_random_area()

func _on_timer_disparo_timeout() -> void:
	if muerto == false:
		if balas > 0 and recargando == false and moviendose == false:
			var disparo_alien_instanciado = disparo_alien.instantiate()
			disparo_alien_instanciado.position = self.global_position
			get_parent().add_child(disparo_alien_instanciado)
			balas -= 1
		elif recargando == false and moviendose == false:
			$AnimatedSprite2D.play("recargando_down")
			balas = balas_max
			recargando = true
			await get_tree().create_timer(2.5).timeout
			recargando = false
		

func _on_timer_movimiento_timeout() -> void:
	move_to_random_area()
	$TimerMovimiento.wait_time = random_float_1_5_to_3()
	print($TimerMovimiento.wait_time)

func actualizar_animacion(dir: Vector2):
	var anim = ""

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim = "move_right"
		else:
			anim = "move_left"
	else:
		if dir.y > 0:
			anim = "move_down"
		else:
			anim = "move_up"

	if $AnimatedSprite2D.animation != anim:
		$AnimatedSprite2D.play(anim)
		
func actualizar_idle_jugador():
	var jugador = $"/root/GameState".posicion_jugador
	var dir = global_position.direction_to(jugador)

	var anim = ""

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim = "idle_right"
		else:
			anim = "idle_left"
	else:
		if dir.y > 0:
			anim = "idle_down"
		else:
			anim = "idle_up"

	if $AnimatedSprite2D.animation != anim:
		$AnimatedSprite2D.play(anim)

func restar_vida_boss():
	if $"/root/GameState".boss_hp == 17:
		$SpriteVida.play("17")
	if $"/root/GameState".boss_hp == 16:
		$SpriteVida.play("16")
	if $"/root/GameState".boss_hp == 15:
		$SpriteVida.play("15")
	if $"/root/GameState".boss_hp == 14:
		$SpriteVida.play("14")
	if $"/root/GameState".boss_hp == 13:
		$SpriteVida.play("13")
	if $"/root/GameState".boss_hp == 12:
		$SpriteVida.play("12")
	if $"/root/GameState".boss_hp == 11:
		$SpriteVida.play("11")
	if $"/root/GameState".boss_hp == 10:
		$SpriteVida.play("10")
	if $"/root/GameState".boss_hp == 9:
		$SpriteVida.play("09")
	if $"/root/GameState".boss_hp == 8:
		$SpriteVida.play("08")
	if $"/root/GameState".boss_hp == 7:
		$SpriteVida.play("07")
	if $"/root/GameState".boss_hp == 6:
		$SpriteVida.play("06")
	if $"/root/GameState".boss_hp == 5:
		$SpriteVida.play("05")
	if $"/root/GameState".boss_hp == 4:
		$SpriteVida.play("04")
	if $"/root/GameState".boss_hp == 3:
		$SpriteVida.play("03")
	if $"/root/GameState".boss_hp == 2:
		$SpriteVida.play("02")
	if $"/root/GameState".boss_hp == 1:
		$SpriteVida.play("01")
	if $"/root/GameState".boss_hp == 0:
		muerte()
		
func muerte():
	$SpriteVida.hide()
	$AnimatedSprite2D.play("muerto")
	$Hitbox.queue_free()
	$CollisionShape2D.queue_free()
	muerto = true
	var pistola_item_instanciada = pistola_item.instantiate()
	add_child(pistola_item_instanciada)

func random_float_1_5_to_3() -> float:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return round(rng.randf_range(1.5, 4.0) * 100.0) / 100.0
