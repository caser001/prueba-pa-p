extends Node2D

var ratas_maximas = 12
var spawn1 
var spawn2 
var spawn3
var spawn4
var spawn5
var spawn6
var spawn7

const rata_escena = preload("res://scenes/enemy/rata.tscn")
const spawn_escena = preload("res://scenes/animacion_spawn/animacion_spawn.tscn")
@export var interfaz: Control


func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
		#aumentar spawn de ratas
	if $"/root/GameState".ratas_muertas > 140:
		$SpawnRata.wait_time = 0.45
	elif $"/root/GameState".ratas_muertas > 120:
		$SpawnRata.wait_time = 0.55
	elif $"/root/GameState".ratas_muertas > 100:
		$SpawnRata.wait_time = 0.65
	elif $"/root/GameState".ratas_muertas > 80:
		$SpawnRata.wait_time = 0.85
	elif $"/root/GameState".ratas_muertas > 60:
		$SpawnRata.wait_time = 1
	elif $"/root/GameState".ratas_muertas > 40:
		$SpawnRata.wait_time = 1.3
	elif $"/root/GameState".ratas_muertas > 20:
		$SpawnRata.wait_time = 1.5
		
	contar_ratas()
	
func numero_random():
	return randi_range(1, 7)


func spawnear_rata(numero_aleatorio):
	if $"/root/GameState".numero_ratas_en_pantalla < ratas_maximas:
		spawn1 = $Lapida
		spawn2 = $Lapida2
		spawn3 = $Lapida3
		spawn4 = $Lapida4
		spawn5 = $Lapida5
		spawn6 = $Lapida6
		spawn7 = $Lapida7
		if numero_aleatorio == 1:
			posicion_spawn_rata(spawn1)
		if numero_aleatorio == 2:
			posicion_spawn_rata(spawn2)
		if numero_aleatorio == 3:
			posicion_spawn_rata(spawn3)
		if numero_aleatorio == 4:
			posicion_spawn_rata(spawn4)
		if numero_aleatorio == 5:
			posicion_spawn_rata(spawn5)
		if numero_aleatorio == 6:
			posicion_spawn_rata(spawn6)
		if numero_aleatorio == 7:
			posicion_spawn_rata(spawn7)
			
func _on_spawn_rata_timeout() -> void:
	spawnear_rata(numero_random())

func _on_player_enemigo_menos() -> void:
	$"/root/GameState".ratas_muertas += 1
	interfaz.actualizar_ratas_muertas($"/root/GameState".ratas_muertas)
	
func contar_ratas():
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
						
