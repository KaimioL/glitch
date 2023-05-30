extends CanvasLayer

var hex_decimals = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]

func _on_game_state_health_changed(old_amount, current_amount):
	$Health.text = _int_to_hex(current_amount)
	
	if current_amount < 20:
		$LowHealthEffect.visible = true

	if current_amount < 0:
		$GameOverScreen.visible = true
		$Health.text = "ERROR"

func _int_to_hex(i: int) -> String:
	return hex_decimals[i/16] + hex_decimals[i%16]

func _on_game_state_pickup_pause_started(pickup_text):
	$PickupText.text = pickup_text
	$PickupText.visible = true

func _on_game_state_pickup_pause_ended():
	$PickupText.visible = false
