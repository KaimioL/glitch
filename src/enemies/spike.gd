extends Node2D

@export var damage = 25

func _process(delta):
	for raycast in $RayCasts.get_children():
		if raycast.is_colliding():
			if raycast.get_collider().has_method("take_damage"):
				
				# Launch player straight up
				raycast.get_collider().take_damage(damage, Vector2(0, 1))
				break
