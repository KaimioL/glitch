extends Node

var current_area = preload("res://src/areas/castle/castle.ldtk")
var current_room

var rooms = []

signal room_changed(room, direction)

func _ready():
	var area_instance = current_area.instantiate()
	var packed_scene = PackedScene.new()
	area_instance.name = "Area"
	add_child(area_instance)
	# Temporary
	for room in area_instance.get_children():
		room = room.duplicate()
		rooms.push_back(room)
		if room.name == "c9cac800-ed50-11ed-a7c2-1f1cdacb1221":
			_load_room(room)
			
			room_changed.emit(current_room, "")
	area_instance.queue_free()
	add_child(current_room)

func change_room(room_id: String):
	for room in rooms:
		if room.name == room_id:		
			# Disable previous room and load new room in
#			_disable_room(current_room)
			_unload_room(current_room)
			_load_room(room)
			return
			
	print("No room found with given id")

func _load_room(room):
	current_room = room.duplicate()
	current_room.transitioned.connect(_on_room_transitioned)
	add_child(current_room)
	
func _unload_room(room):
	room.queue_free()

func _disable_room(room):
#	room.close_doors()
	room.set_process_mode(PROCESS_MODE_DISABLED)
	room.hide()
	
func _enable_room(room):
	room.set_process_mode(PROCESS_MODE_INHERIT)
	room.show()
	
func _on_room_transitioned(direction):
#	get_tree().paused = true
	change_room(current_room.neighbours[direction])
	room_changed.emit(current_room, direction)
	
