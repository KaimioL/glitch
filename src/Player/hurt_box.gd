extends Area2D

@export var player: Node

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func take_damage(damage: int):
	player.take_damage(damage)

func resize(s: float):
	collision_shape.shape.size.y -= s
	collision_shape.position.y += s/2
