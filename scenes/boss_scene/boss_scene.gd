extends Node2D

@onready var ratas_maximas: int = $"/root/GameState".ratas_maximas_gs
var tirando_veneno = false
var puerta_abierta = false

const nube_veneno = preload("res://scenes/nube_veneno_player/nube_veneno_player.tscn")
const botones_android = preload("res://scenes/controles_android/controles_android.tscn")
const nitolas = preload("res://scenes/player/nitolas.tscn")
const totolas = preload("res://scenes/totolas/totolas.tscn")

var interfaz: Control
var player: CharacterBody2D
 
func _ready() -> void:
	#ovni
	var alien = $AlienBoss
	var manager = $OvniManager
	$BossMap/TextureRect3.hide()
	$TpZonaInicial.monitoring = false

	alien.request_ovni_phase.connect(manager.start_phase)
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
	player.position = Vector2(-180, 180)
	add_child(player)		
	
func _physics_process(_delta: float) -> void:
	#actualizar interfaz
	$Interfaz.actualizar_vida($"/root/GameState".player_hp)
	$Interfaz.actualizar_botellas_veneno($"/root/GameState".cantidad_botellas_veneno)
	
	if $"/root/GameState".boss_hp == 0 and puerta_abierta == false:
		$BossMap/TextureRect3.show()
		$BossMap/TextureRect2.hide()
		$TpZonaInicial.monitoring = true
		puerta_abierta = true
	
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


func _on_tp_zona_inicial_body_entered(body: Node2D) -> void:
	player.position = Vector2(-200, 200)
	get_tree().change_scene_to_file("res://scenes/main_scene/main_scene.tscn")
	
