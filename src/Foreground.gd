extends TileMap

var img = preload("res://assets/palettes/temp_foreground_pal.png")

func _ready():
	material.set_shader_parameter("palette", img)
