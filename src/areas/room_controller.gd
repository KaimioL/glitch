extends Node

var current_area = preload("res://src/areas/castle/castle.ldtk")
var current_room

signal room_changed(room)

func _ready():
	var area_instance = current_area.instantiate()
	area_instance.name = "Area"
	add_child(area_instance)
	
	# Temporary
	for room in area_instance.get_children():
		if room.name == "Room_0":
			_enable_room(room)
			current_room = room
			room_changed.emit(current_room)
		else:
			_disable_room(room)

func change_room(room_id: int):
	for room in $Area.get_children():
		print(room.name)
		if room.name == "Room_" + str(room_id):		
			# Disable previous room and load new room in
			_disable_room(current_room)
			current_room = room
			_enable_room(current_room)
			room_changed.emit(current_room)
			return
			
	print("No room found with given id")

func _disable_room(room):
	room.set_process_mode(PROCESS_MODE_DISABLED)
	room.hide()
	
func _enable_room(room):
	room.set_process_mode(PROCESS_MODE_INHERIT)
	room.show()
