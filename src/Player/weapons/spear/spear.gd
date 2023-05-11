extends Weapon

@export var collision_launch_power = 300

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
	print(get_parent().velocity)
	direction.x = -direction.x
	if(direction.y != 0):
		$HitSound.play()
		get_parent().velocity.y = direction.y * collision_launch_power
	if(direction.x != 0):
		$HitSound.play()
		get_parent().velocity.x = -direction.x * collision_launch_power
#	get_parent().velocity = direction * collision_launch_power
	print(get_parent().velocity)
	
