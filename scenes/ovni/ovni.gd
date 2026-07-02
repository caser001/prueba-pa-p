extends CharacterBody2D
	
@onready var collision = $CollisionShape2D

func _physics_process(delta: float) -> void:
	pass
	
func set_lane(y: float):
	global_position.y = y
