extends Node2D
class_name Weapon

# 0 forward, 1 up, 2 down
var direction: int = 0

func look_forward() -> void:
	direction = 0
	$SpriteUp.visible = false
	$SpriteDown.visible = false
	$SpriteFront.visible = true

func look_up() -> void:
	direction = 1
	$SpriteUp.visible = true
	$SpriteDown.visible = false
	$SpriteFront.visible = false
	
func look_down() -> void:
	direction = 2
	$SpriteUp.visible = false
	$SpriteDown.visible = true
	$SpriteFront.visible = false

func shoot() -> void:
	if(direction == 0):
		_shoot_forward()
	elif(direction == 1):
		_shoot_up()
	elif(direction == 2):
		_shoot_down()

func _shoot_forward() -> void:
	pass
	
func _shoot_up() -> void:
	pass
	
func _shoot_down() -> void:
	pass
	
