extends Control

@onready var numero_vida = $BoxContainer/NumeroVida
@onready var numero_ratas = $BoxContainer/NumeroRatasMuertas

func actualizar_vida(vida: int):
	numero_vida.text = str(vida)

func actualizar_ratas_muertas(ratas_muertas):
	numero_ratas.text = str(ratas_muertas)
