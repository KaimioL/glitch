extends Node

const areas_folder: String = "res://src/areas/"

@export var width:  int = 0
@export var height: int = 0
@export var room_size: Vector2 = Vector2(256,224)

@export var starting_room: Vector2i
@export var area_name: String

var current_area_folder: String
var current_room_index: int = 0
var current_room_coords: Vector2i
var current_room

func _ready():
	current_area_folder = areas_folder + area_name + "/"
	current_room = _load_starting_room(_get_room_index_from_coordinates(starting_room))
	current_room.position = Vector2(0, 0)
	_load_rooms_around_current_room()

func change_room(direction: Vector2i):
	current_room_index = _get_room_index_from_coordinates(current_room_coords + direction)
	current_room_coords = current_room_coords + direction
	_unload_other_rooms(current_room_index)
	print(current_room)
	_load_rooms_around_current_room()

func _get_room_index_from_coordinates(coords: Vector2i) -> int:
	coords = _get_absolute_coordinates(coords)
	return coords.x + width * coords.y

func _get_room_coordinates(index: int) -> Vector2i:
	return Vector2i(index % height, index / width)

func _get_absolute_coordinates(coords: Vector2i) -> Vector2i:
	return Vector2i(fposmod(coords.x,width), fposmod(coords.y,height))

func _load_rooms_around_current_room():
	for x in [1, -1]:
		_load_room(_get_room_index_from_coordinates(current_room_coords + Vector2i(x, 0)), Vector2(x, 0))
	for y in [1, -1]:
		_load_room(_get_room_index_from_coordinates(current_room_coords + Vector2i(0, y)), Vector2(0, y))
	
func _unload_other_rooms(index: int):
	for _i in get_children():
		if _i.index != index:
			remove_child(_i)
		else:
			current_room = _i
			
func _load_room(index: int, direction_from_current_room: Vector2):
	var room = load(current_area_folder + str(index) + ".tscn")
	var instance = room.instantiate()
	instance.index = index
	instance.position = current_room.position + room_size * direction_from_current_room
	add_child(instance)	
	return instance
	
func _load_starting_room(index: int):
	var room = load(current_area_folder + str(index) + ".tscn")
	var instance = room.instantiate()
	instance.index = index
	add_child(instance)
	return instance
