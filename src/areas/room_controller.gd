extends Node

var current_area = preload("res://src/areas/castle/castle.ldtk")
var current_room

var rooms = {}

signal room_changed(room, direction)
signal pickup_collected(pickup)

func _ready():
	var world_instance = current_area.instantiate()
	
	# Add world instance as child and iterate through rooms
	add_child(world_instance)
	
	for room in world_instance.get_children():
		
		# Save rooms in dictionary as packed scenes
		var packed_room = PackedScene.new()
		packed_room.pack(room)
		rooms[room.name] = packed_room
		
		# Temporary for instancing starting room
		if room.name == "Level_0":
			_load_room(packed_room)
			
			room_changed.emit(current_room, "")
	
	world_instance.queue_free()

func change_room(room_id: String):
	var prev_room = current_room
	_load_room(rooms[room_id])

func _load_room(packed_room: PackedScene):
	# Create new instance of packed room
	current_room = packed_room.instantiate()
	_connect_to_room_signals(current_room)
	add_child(current_room)
	
func _unload_room(room):
	# Free queue from given room
	room.queue_free()
	
func _connect_to_room_signals(room):
	room.transitioned.connect(_on_room_transitioned)
	room.pickup_collected.connect(_on_room_pickup_connected)

func _on_room_transitioned(target_room, direction):
	var prev_room = current_room	
	var next_room = rooms["Level_" + str(target_room)]
	_load_room(next_room)
	room_changed.emit(current_room, direction)
	_unload_room(prev_room)

func _on_room_pickup_connected(pickup):
	pickup_collected.emit(pickup)
