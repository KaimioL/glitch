extends Node2D

@export var pickup_name: String
@export var texture: CompressedTexture2D

func _ready():
	$Sprite2D.texture = texture

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		_get_pickup(body)

func _get_pickup(player):
	await player.get_pickup(pickup_name)
	queue_free()
