extends Control

@onready var numero_vida = $BoxContainerPadre/BoxContainer1/NumeroVida
@onready var numero_enemigos = $BoxContainerPadre/BoxContainer2/NumeroEnemigosMuertas
@onready var botellas_veneno = $BoxContainerPadre/BoxContainer3/NumeroBotellasVeneno

func actualizar_vida(vida: int):
	numero_vida.text = str(vida)

func actualizar_ratas_muertas(ratas_muertas):
	numero_enemigos.text = str(ratas_muertas)

func actualizar_botellas_veneno(variable):
	botellas_veneno.text = str(variable)
