extends CharacterBody2D

signal took_damage(amount)
signal pickup_collected(pickup_name)

@onready var animation_tree:  AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var collision_box: CollisionShape2D = $CollisionBox
@onready var hurt_box: Area2D = $HurtBox
@onready var wall_raycasts: Node2D = $WallRayCasts
@onready var inside_wall_raycasts: Node2D = $InsideWallRayCasts
@onready var weapon: Weapon = $Spear

var direction: Vector2
var flipped: bool = false
var crouching: bool = false

var previous_direction: float = 0
var starting_pos: Vector2

func _ready():
	animation_tree.active = true
	starting_pos = position

func _physics_process(delta):
	if Input.is_action_pressed("glitch_key") or is_inside_wall():
		disable_collision_shapes()
	else:
		enable_collision_shapes()
	
	update_velocity(delta)
	update_facing_direction()
	move_and_slide()
	update_animation()

func _process(delta):
	# Respawn for debugging
	if Input.is_action_pressed("debug_spawn"):
		position = starting_pos	
	
	if(state_machine.can_move):
		if Input.is_action_pressed("up"):
			weapon.look_up()
		elif Input.is_action_pressed("down") && state_machine.can_aim_down:
			weapon.look_down()
		else:
			weapon.look_forward()
		
		if Input.is_action_just_pressed("attack"):
			weapon.shoot()
	
func update_animation() -> void:
	animation_tree.set("parameters/move/blend_position", direction.x)
	animation_tree.set("parameters/crouch/blend_position", direction.x)	

func update_facing_direction() -> void:
	if(direction.x > 0 && flipped):
		flip_character()
	elif(direction.x < 0 && !flipped):
		flip_character()
	
func flip_character() -> void:
	if state_machine.can_move:
		sprite.scale.x *= -1
		weapon.scale.x *= -1
		flipped = !flipped
	
func update_velocity(delta) -> void:
	var friction = state_machine.friction
	var acceleration = state_machine.acceleration
	var can_move = state_machine.can_move
	var max_speed = state_machine.max_speed
	
	direction.x = Input.get_axis("left", "right")
	
	# Slow down if velocity is over max speed
	if max_speed < abs(velocity.x):
		velocity.x = sign(velocity.x) * max_speed
	
	if can_move:
		if direction.x:
			# Accelerate if speed is not over speed limit or to wrong direction
			velocity.x = velocity.x + direction.x * acceleration if(max_speed > velocity.x * direction.x) else velocity.x
			
			# Apply friction for one frame if player changed directions during one frame to prevent sliding
			if direction.x != previous_direction and previous_direction != 0:
				velocity.x *= friction
			previous_direction = direction.x
		
		else:
			velocity.x *= friction
		
		# Stop momentum if direction is not held 
		if direction.x != sign(velocity.x):
			velocity.x *= 0.5
			
	else:
		velocity.x *= friction
		
			
func is_near_wall() -> int:
	for raycast in wall_raycasts.get_children():
		if raycast.is_colliding():
			if raycast.name == "LeftWallRayCast":
				return 1
			elif raycast.name == "RightWallRayCast":
				return -1
	return 0
	
func is_inside_wall() -> bool:
	for raycast in inside_wall_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func disable_collision_shapes() -> void:
	collision_box.disabled = true
		
func enable_collision_shapes() -> void:
	collision_box.disabled = false
	
func resize_collision_box(s: float) -> void:
	collision_box.shape.size.y -= s
	collision_box.position.y += s/2
	
func resize_inside_wall_raycasts(s: float) -> void:
	for raycast in inside_wall_raycasts.get_children():
		raycast.target_position.y -= s
		raycast.position.y += s

func take_damage(amount: int) -> void:
	took_damage.emit(amount)
	
func get_current_health() -> int:
	return $Health.current_health

func die() -> void:
	state_machine.change_state("Dead")
	
func get_current_state() -> String:
	return state_machine.state.name

func get_pickup(pickup_name: String):
	pickup_collected.emit(pickup_name)
