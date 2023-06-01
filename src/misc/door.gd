extends Node2D

enum Direction{
	RIGHT = 0,
	LEFT = 1,
	UP = 2,
	DOWN = 3,
}

@export var direction: int

var is_open: bool = false

func _ready():
	if direction == 1:
		scale.x *= -1

func open():
	$AnimationPlayer.play("open")
	is_open = true

func close():
	$AnimationPlayer.play_backwards("open")
	is_open = false

func take_damage(amount: int, direction: Vector2):
	if is_open:
		close()
	else:
		open()
