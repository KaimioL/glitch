extends Node2D

@export var pickup_name: String
@export var texture: CompressedTexture2D

@export var persisting: bool = false
@export var has_pickup_pause: bool = false
@export var size: Vector2 = Vector2(0, 0)
@export_multiline var pickup_pause_text: String = ""

@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

signal collected(pickup)

func _ready():
	$Sprite2D.texture = texture
	size = $Sprite2D.texture.get_size()
	collision_shape.shape.size = size
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		_get_pickup(body)

func _get_pickup(player):
	collected.emit(self)

func terminate():
	queue_free()
