extends Camera2D

@export var player: CharacterBody2D
@export var area: Node

@onready var player_grid_pos = get_player_grid_pos()

var window_size = Vector2(256, 224)

func _ready():
#	$Music.play()
	
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_grid_pos * window_size

func _process(delta):
	update_camera()
	
func get_player_grid_pos():
	var pos = player.get_position()
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	
	return Vector2(x, y)
	
func update_camera():
	var new_player_grid_pos = get_player_grid_pos()
	var transition_direction = new_player_grid_pos - player_grid_pos
	if new_player_grid_pos != player_grid_pos:
		area.change_room(transition_direction)
		player_grid_pos = new_player_grid_pos
		if(player_grid_pos == Vector2(3, 1)):
			$VictoryFanfare.play()
			$RichTextLabel.visible = true
		position = player_grid_pos * window_size
	
	
