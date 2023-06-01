extends Node

signal health_changed(old_amount, current_amount)

@export var max_health = 255
@export var player: Node

var current_health

signal pickup_collected(pickup)
signal pickup_pause_started(pickup_text)
signal pickup_pause_ended
signal player_died

func _ready():
	current_health = max_health
	health_changed.emit(0, current_health)

func _process(delta):
	pass

func _on_player_took_damage(amount):
	_change_current_health(-amount)
	if(current_health < 0):
		player_died.emit()
		
func _change_current_health(amount):
	var old_health = current_health
	current_health += amount
	health_changed.emit(old_health, current_health)

func _on_area_pickup_collected(pickup):
	pickup_collected.emit(pickup)
	if pickup.has_pickup_pause == true:
		get_tree().paused = true
		$PickupPauseTimer.start()
		$PickupFanfare.play()
		pickup_pause_started.emit(pickup.pickup_pause_text)
		
		await $PickupPauseTimer.timeout
		get_tree().paused = false
		pickup_pause_ended.emit()
		pickup.terminate()
