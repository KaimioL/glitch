extends Weapon

@export var collision_launch_power: Vector2 = Vector2(50, 300)

func _process(delta) -> void:
	pass

func _shoot_forward() -> void:
	if($Cooldown.is_stopped()):
		$AttackFront.attack()

func _shoot_up() -> void:
	if($Cooldown.is_stopped()):
		$AttackUp.attack()

func _shoot_down() -> void:
	if($Cooldown.is_stopped()):
		$AttackDown.attack()
		
func start_attack_cooldown() -> void:
	$Cooldown.start()
	
func do_collision_launch(direction: Vector2) -> void:
	if(direction.y != 0):
		get_parent().velocity.y = direction.y * collision_launch_power.y
	if(direction.x != 0):
		get_parent().velocity.x = direction.x * collision_launch_power.x

func play_hit_sound() -> void:
	$HitSound.play()
