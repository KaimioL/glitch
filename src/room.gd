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
	for neighbour in level_data.__neighbours:
		neighbours[neighbour.dir] = neighbour.levelIid
	
	# Add pickups under pickup controller
	for entity in $Entities.get_children():
		if entity.get_meta("type") == "pickup":
			$PickupController.add_child(entity.duplicate())
			entity.queue_free()
	
	# Connect pickup signals
	$PickupController.setup_pickups()
	
func get_room_size() -> Vector2:
	return get_node("LevelArea/LevelAreaCollissionShape").shape.size
