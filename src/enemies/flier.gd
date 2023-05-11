extends Area2D

@export var damage = 1
@export var health = 3

func _ready():
	$AnimatedSprite2D.frame = randi() % 5
	$AnimatedSprite2D.play("idle")

func _process(delta):
	pass

func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage(damage)

func take_damage(amount: int):
	health -= amount
	print(health)
	if(health <= 0):
		die()
		
func die():
	queue_free()
