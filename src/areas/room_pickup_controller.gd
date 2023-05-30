extends Node2D

@onready var room = get_parent()

func _ready():
	for pickup in get_children():
		
		# Connect to persisting pickups
		pickup.collected.connect(_pickup_collected)
		
		# Remove pickups which are false in room data
		for pickup_name in room.room_data.keys():
			if pickup.pickup_name == pickup_name && !room.room_data[pickup_name]:
				pickup.queue_free()
	
func _pickup_collected(pickup):
	if(pickup.persisting):
		room.pickup_collected.emit(pickup)
		
func _pickup_terminated(pickup):
	pickup.queue_free()
