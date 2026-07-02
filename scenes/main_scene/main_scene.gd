extends Node2D

@onready var ratas_maximas: int = $"/root/GameState".ratas_maximas_gs
var spawn1 
var spawn2 
var spawn3
var spawn4
var spawn5
var spawn6
var spawn7
var tirando_veneno = false
var tirando_veneno_enemy = false

const rata_escena = preload("res://scenes/rata/rata.tscn")
const spawn_escena = preload("res://scenes/animacion_spawn/animacion_spawn.tscn")
const atun_escena = preload("res://scenes/atun/atun.tscn")
const spawn_escena_atun = preload("res://scenes/animacion_spawn_pez/animacion_spawn_pez.tscn")
const lata_tuna = preload("res://scenes/lata_tuna/lata_tuna.tscn")
const caja_llave = preload("res://scenes/caja_llave/caja_llave.tscn")
var botella_veneno = preload("res://scenes/botella_veneno/botella_veneno.tscn")
const nube_veneno = preload("res://scenes/nube_veneno_player/nube_veneno_player.tscn")
const botones_android = preload("res://scenes/controles_android/controles_android.tscn")
const nitolas = preload("res://scenes/player/nitolas.tscn")
const totolas = preload("res://scenes/totolas/totolas.tscn")
@export var interfaz: Control
@export var player: CharacterBody2D
 

func _ready() -> void:
	print("personaje record ", $"/root/GameState".personaje_seleccionado_record)
	print("personaje normal ", $"/root/GameState".personaje_seleccionado)
	#Ajustar para movil
	if $"/root/GameState".android == true:
		var botones_android_instanciados = botones_android.instantiate()
		add_child(botones_android_instanciados)
		$Camera2D.zoom = Vector2(1.05,1.05)
		$Camera2D.position = Vector2(0, 95)
		
	#Meter personaje
	if $"/root/GameState".personaje_seleccionado == 1:
		player = nitolas.instantiate()
		$"/root/GameState".max_hp = 7
		$"/root/GameState".max_botellas_veneno = 3
	else:
		player = totolas.instantiate()
		$"/root/GameState".max_hp = 14
		$"/root/GameState".max_botellas_veneno = 5
	add_child(player)
	player.enemigo_menos.connect(_on_player_enemigo_menos)
	
	#reiniciar numero de enemigos y botellas de veneno
	if $"/root/GameState".boss_hp > 0:
		$"/root/GameState".enemigos_muertos = 0
		$"/root/GameState".cantidad_botellas_veneno = 0
		$"/root/GameState".player_hp = $"/root/GameState".max_hp
		$"/root/GameState".cantidad_botellas_veneno_usadas = 0
	
	if $"/root/GameState".boss_hp <= 0:
		player.position = Vector2(-180, -160)
		$TPBoss.get_node("Area2D").monitoring = false
		$TPBoss/Area2D/PuertaCerrada.show()
		$TPBoss/Area2D/PuertaAbierta.hide()
		
	
func _physics_process(_delta: float) -> void:
	$Interfaz.actualizar_vida($"/root/GameState".player_hp)
	$Interfaz.actualizar_botellas_veneno($"/root/GameState".cantidad_botellas_veneno)
	
		#aumentar spawn de ratas
	if $"/root/GameState".enemigos_muertos > 140:
		$SpawnEnemigo.wait_time = 0.45
	elif $"/root/GameState".enemigos_muertos > 120:
		$SpawnEnemigo.wait_time = 0.55
	elif $"/root/GameState".enemigos_muertos > 100:
		$SpawnEnemigo.wait_time = 0.65
	elif $"/root/GameState".enemigos_muertos > 80:
		$SpawnEnemigo.wait_time = 0.85
	elif $"/root/GameState".enemigos_muertos > 60:
		$SpawnEnemigo.wait_time = 1
	elif $"/root/GameState".enemigos_muertos > 40:
		$SpawnEnemigo.wait_time = 1.3
	elif $"/root/GameState".enemigos_muertos > 20:
		$SpawnEnemigo.wait_time = 1.5
		
	contar_enemigos()

	#ataque veneno
	if Input.is_action_just_pressed("circulo") and tirando_veneno == false:
		tirando_veneno = true
		if $"/root/GameState".cantidad_botellas_veneno > 0:
			player.get_node("PeoPlayer").play()
			var _nube_veneno_instanciada = nube_veneno.instantiate()
			add_child(_nube_veneno_instanciada)
			_nube_veneno_instanciada.position = $"/root/GameState".posicion_jugador
			$"/root/GameState".cantidad_botellas_veneno -= 1
			$"/root/GameState".cantidad_botellas_veneno_usadas += 1
			await get_tree().create_timer(1).timeout
		tirando_veneno = false

	
func numero_random_posicion():
	return randi_range(1, 7)
	
func numero_random_enemigo():
	return randi_range(0, 100)
	
func numero_random_spawn_objeto():
	return randi_range(0, 100)


func spawnear_enemigo(numero_aleatorio_posicion, numero_aleatorio_enemigo):
	if $"/root/GameState".numero_ratas_en_pantalla < ratas_maximas:
		spawn1 = $Lapida
		spawn2 = $Lapida2
		spawn3 = $Lapida3
		spawn4 = $Lapida4
		spawn5 = $Lapida5
		spawn6 = $Lapida6
		spawn7 = $Lapida7
		if numero_aleatorio_posicion == 1:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn1)
			else:
				posicion_spawn_atun(spawn1)
		if numero_aleatorio_posicion == 2:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn2)
			else:
				posicion_spawn_atun(spawn2)
		if numero_aleatorio_posicion == 3:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn3)
			else:
				posicion_spawn_atun(spawn3)
		if numero_aleatorio_posicion == 4:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn4)
			else:
				posicion_spawn_atun(spawn4)
		if numero_aleatorio_posicion == 5:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn5)
			else:
				posicion_spawn_atun(spawn5)
		if numero_aleatorio_posicion == 6:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn6)
			else:
				posicion_spawn_atun(spawn6)
		if numero_aleatorio_posicion == 7:
			if numero_aleatorio_enemigo < 85:
				posicion_spawn_rata(spawn7)
			else:
				posicion_spawn_atun(spawn7)
				

func _on_spawn_enemigo_timeout() -> void:
	spawnear_enemigo(numero_random_posicion(),numero_random_enemigo())
	
#spawnear items de enemigos
func _on_player_enemigo_menos() -> void:
	$"/root/GameState".enemigos_muertos += 1
	interfaz.actualizar_ratas_muertas($"/root/GameState".enemigos_muertos)
	if $"/root/GameState".ultimo_enemigo_muerto.is_in_group("atun"):
		if numero_random_spawn_objeto() >= 80 and $"/root/GameState".enemigos_muertos > 150 and $"/root/GameState".caja_llave_spawneada == false:
				$"/root/GameState".caja_llave_spawneada = true
				var caja_llave_instanciada = caja_llave.instantiate()
				caja_llave_instanciada.position = $"/root/GameState".posicion_enemigo_muerto
				add_child(caja_llave_instanciada)
		if $"/root/GameState".player_hp < $"/root/GameState".max_hp:
			if numero_random_spawn_objeto() <= 35:
				var lata_tuna_instanciada = lata_tuna.instantiate()
				lata_tuna_instanciada.position = $"/root/GameState".posicion_enemigo_muerto
				add_child(lata_tuna_instanciada)
			
	interfaz.actualizar_ratas_muertas($"/root/GameState".enemigos_muertos)
	if $"/root/GameState".ultimo_enemigo_muerto.is_in_group("rata"):
		if $"/root/GameState".cantidad_botellas_veneno < $"/root/GameState".max_botellas_veneno:
			if numero_random_spawn_objeto() <= 10:
				var botella_veneno_instanciada = botella_veneno.instantiate()
				botella_veneno_instanciada.position = $"/root/GameState".posicion_enemigo_muerto
				add_child(botella_veneno_instanciada)

func contar_enemigos():
	var ratas_temporal: int
	for i in get_tree().get_nodes_in_group("enemies"):
		ratas_temporal += 1
	$"/root/GameState".numero_ratas_en_pantalla = ratas_temporal
	ratas_temporal = 0

func posicion_spawn_rata(spawn_numero):
	var rata = rata_escena.instantiate()
	var spawn_animacion = spawn_escena.instantiate()
	spawn_animacion.global_position = spawn_numero.global_position
	add_child(spawn_animacion)
	await get_tree().create_timer(0.8).timeout
	spawn_animacion.queue_free()
	rata.global_position = spawn_numero.global_position + Vector2(0, 20)
	add_child(rata)
	
	
func posicion_spawn_atun(spawn_numero):
	var atun = atun_escena.instantiate()
	var spawn_animacion = spawn_escena_atun.instantiate()
	spawn_animacion.global_position = spawn_numero.global_position
	add_child(spawn_animacion)
	await get_tree().create_timer(0.8).timeout
	spawn_animacion.queue_free()
	atun.global_position = spawn_numero.global_position + Vector2(0, 20)
	add_child(atun)
