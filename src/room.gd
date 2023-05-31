extends Node2D

@export var index: int

var room_data: Dictionary = {}

signal pickup_collected(pickup)

func get_room_size() -> Vector2:
	return get_node("LevelArea/LevelAreaCollissionShape").shape.size
