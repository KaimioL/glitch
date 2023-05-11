extends Node

@export var max_health: int = 3

signal health_changed(new_value)
signal health_depleted

var current_health: int

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	health_changed.emit(current_health)
	if(current_health < 0):
		health_depleted.emit()
