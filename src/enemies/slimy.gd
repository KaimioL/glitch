extends StaticBody2D

@export var damage: int = 15
@export var health: int = 2

@export var movement_speed: float = 20

@export var flipped: bool = false

func _ready():
	if flipped:
		scale *= Vector2(-1, 1)

func _process(delta):
	for area in $HitBox.get_overlapping_areas():
		if(area.has_method("take_damage")):
			area.take_damage(damage, global_position.direction_to(area.global_position))

func _physics_process(delta):
	var direction = -1 if flipped else 1
	if !$FloorRayCast.is_colliding() or $WallRayCast.is_colliding():
		_flip()
	move_and_collide(Vector2(movement_speed * delta * direction, 0))	

func take_damage(amount: int, direction: Vector2):
	health -= amount
	if(health <= 0):
		_die()

func _flip():
	flipped = !flipped
	scale *= Vector2(-1, 1)

func _die():
	queue_free()
