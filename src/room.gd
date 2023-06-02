extends Node2D

@export var index: int

var room_data: Dictionary = {}
@export var neighbours: Dictionary = {
	"w": null,
	"e": null,
	"s": null,
	"n": null,
}

signal pickup_collected(pickup)
signal transitioned(direction)

func _ready():
	var level_data :Dictionary = get_meta("LDtk_raw_data")
	# Rename level to use iid for neighbours
	name = level_data.iid
	for neighbour in level_data.__neighbours:
		neighbours[neighbour.dir] = neighbour.levelIid

func get_room_size() -> Vector2:
	return get_node("LevelArea/LevelAreaCollissionShape").shape.size
