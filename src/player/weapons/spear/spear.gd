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
	var velocity = Vector2()
	
	if(direction.y != 0):
		velocity.y = direction.y * collision_launch_power.y
	if(direction.x != 0):
		velocity.x = direction.x * collision_launch_power.x
	
	get_parent().change_player_velocity(velocity)

func play_hit_sound() -> void:
	$HitSound.play()
