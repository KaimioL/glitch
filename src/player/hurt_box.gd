extends Area2D

@export var player: Node

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func take_damage(damage: int, direction: Vector2):
	player.take_damage(damage, direction)

func resize(s: float):
	collision_shape.shape.size.y -= s
	collision_shape.position.y += s/2
