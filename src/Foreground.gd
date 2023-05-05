extends TileMap

var img = preload("res://assets/palettes/player_pal.png")

func _ready():
	material.set_shader_parameter("palette", img)
