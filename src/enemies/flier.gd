extends Area2D

@export var damage = 25
@export var health = 3

func _ready():
	$AnimatedSprite2D.frame = randi() % 5
	$AnimatedSprite2D.play("idle")

func _process(delta):
	pass

func take_damage(amount: int, direction: Vector2):
	health -= amount
	if(health <= 0):
		die()
		
func die():
	queue_free()

func _on_area_entered(area):
	if(area.has_method("take_damage")):
		area.take_damage(damage, global_position.direction_to(area.global_position))
