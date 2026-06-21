extends Control

@onready var numero_vida = $BoxContainer/BoxContainer3/NumeroVida
@onready var numero_enemigos = $BoxContainer/BoxContainer2/NumeroEnemigosMuertas

func actualizar_vida(vida: int):
	numero_vida.text = str(vida)

func actualizar_ratas_muertas(ratas_muertas):
	numero_enemigos.text = str(ratas_muertas)
