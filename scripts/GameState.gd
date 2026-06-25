extends Node

var enemigos_muertos: int
var player_hp: int
var max_hp: int
var max_botellas_veneno: int
var numero_ratas_en_pantalla: int
var ratas_maximas_gs: int = 16
var posicion_enemigo_muerto :Vector2
var ultimo_enemigo_muerto
var cantidad_botellas_veneno: int
var cantidad_botellas_veneno_usadas: int
var cantidad_botellas_veneno_usadas_record: int = 0
var posicion_jugador: Vector2
var posicion_rata: Vector2
var android: bool = false
var volumen_general: float = 2
var personaje_seleccionado: int
var personaje_seleccionado_record: int = 0
var record: int = 0
var nitolas_corona: bool = false
var totolas_corona: bool = false


func _ready() -> void:
	cargar_datos()

func _physics_process(delta: float) -> void:
	pass
 
func cargar_datos():
	if FileAccess.file_exists("user://save.dat"):
		var archivo = FileAccess.open("user://save.dat", FileAccess.READ)
		var datos = archivo.get_var()
		print("Cargando:", datos)
		record = datos.get("record", 0)
		personaje_seleccionado_record = datos.get("personaje_seleccionado_record", 1)
		cantidad_botellas_veneno_usadas_record = datos.get("cantidad_botellas_veneno_usadas_record", 0)
		nitolas_corona = datos.get("nitolas_corona", false)
		totolas_corona = datos.get("totolas_corona", false)
