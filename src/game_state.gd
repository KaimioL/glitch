extends Node

signal health_changed(old_amount, current_amount)

@export var max_health = 255
@export var player: Node

var current_health

func _ready():
	current_health = max_health
	health_changed.emit(0, current_health)

func _process(delta):
	pass

func _on_player_took_damage(amount):
	_change_current_health(-amount)
	if(current_health < 0):
		player.die()
		
func _change_current_health(amount):
	var old_health = current_health
	current_health += amount
	health_changed.emit(old_health, current_health)
