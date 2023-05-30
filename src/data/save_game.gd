extends Node

signal data_changed(data)

var data = {
	"pickups":{
		"crouch": false,
		"spear": false,
	},
	"areas": {
		"test_area": {
			"5": {
				"spear": true,
				"star": true
			},
			"10": {
				"crouch": true,
			},
			"13": {
				"star": true,
			}
		}
	}
}

func _ready():
	save_game()
	load_game()

func _process(delta):
	if Input.is_action_just_pressed("debug_save"):
		save_game()
	if Input.is_action_just_pressed("debug_load"):
		load_game()

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")	
	var json_string = JSON.stringify(data)	
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("No save file found")
		return
		
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		
		# Helper class to interact with json
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		data = json.get_data()
		print(data)
		data_changed.emit(data)
		
func set_pickup_data(pickup_name, value):
	data["pickups"][pickup_name] = value
	
func get_pickup_data(pickup_name):
	return data["pickups"][pickup_name]

func _on_area_data_changed(area_data, current_area):
	data["areas"][current_area] = area_data

func _on_area_pickup_collected(pickup):
	data["pickups"][pickup.pickup_name] = true
	data_changed.emit(data)
