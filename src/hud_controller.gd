extends CanvasLayer

@export var player: Node
var current_health = 3

func _process(delta):
	current_health = player.get_current_health()
	
	if current_health < 3:
		$HBoxContainer/TextureRect.visible = false
	else:
		$HBoxContainer/TextureRect.visible = true
		
	if current_health < 2:
		$HBoxContainer/TextureRect2.visible = false
	else:
		$HBoxContainer/TextureRect2.visible = true

	if current_health < 1:
		$HBoxContainer/TextureRect3.visible = false
		$LowHealthEffect.visible = true
	else:
		$HBoxContainer/TextureRect3.visible = true
		$LowHealthEffect.visible = false
		
	if current_health < 0:
		$GameOverScreen.visible = true
