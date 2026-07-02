extends Node

signal player_entered_area(area)

func _ready():
	for child in get_children():
		if child is Area2D:
			child.body_entered.connect(_on_body_entered.bind(child))
			
func _on_body_entered(body, area):
	if body.is_in_group("player"):
		player_entered_area.emit(area)
