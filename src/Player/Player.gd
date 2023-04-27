extends CharacterBody2D

@export var max_speed: float = 90.0

@onready var animation_tree:  AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var collision_shape: CollisionShape2D = $NormalCollisionShape
@onready var crouch_collision_shape: CollisionShape2D = $CrouchCollisionShape
@onready var wall_raycasts: Node2D = $WallRayCasts
@onready var inside_wall_raycasts: Node2D = $InsideWallRayCasts

var direction: Vector2
var flipped: bool = false
var crouching: bool = false

var previous_direction: float = 0
var starting_pos: Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	animation_tree.active = true
	starting_pos = position

func _physics_process(delta):
	update_velocity(delta)
	update_facing_direction()
	move_and_slide()
	update_animation()

func _process(delta):
	is_inside_wall()
	# Respawn for debugging
	if(Input.is_action_pressed("debug_spawn")):
		position = starting_pos
	
	if(Input.is_action_pressed("glitch_key") || is_inside_wall()):
		disable_collision_shapes()
	else:
		enable_collision_shapes()

func update_animation() -> void:
	animation_tree.set("parameters/move/blend_position", direction.x)
	animation_tree.set("parameters/crouch/blend_position", direction.x)	

func update_facing_direction() -> void:
	if(direction.x > 0 && flipped):
		flip_character()
	elif(direction.x < 0 && !flipped):
		flip_character()
	
func flip_character() -> void:
	sprite.scale.x *= -1
	flipped = !flipped
	
func update_velocity(delta) -> void:
	var friction = state_machine.friction
	var acceleration = state_machine.acceleration
	var can_move = state_machine.can_move
	
	direction.x = Input.get_axis("left", "right")
	
	if(can_move):
		if direction.x:
			# Accelerate if speed is not over speed limit or to wrong direction
			velocity.x = velocity.x + direction.x * acceleration if(max_speed > velocity.x * direction.x) else velocity.x
			
			# Apply friction for one frame if player changed directions during one frame to prevent sliding
			if(direction.x != previous_direction && previous_direction != 0):
				velocity.x *= friction
			previous_direction = direction.x
			
		# Apply friction if nothing is hold or speed is over speed limit
		elif(max_speed < abs(velocity.x)):
			velocity.x = max(velocity.x * friction, sign(velocity.x) * max_speed)
		
		else:
			velocity.x *= friction
		
		# Stop momentum if direction is not held 
		if direction.x != sign(velocity.x):
			velocity.x *= 0.1
			
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
	collision_shape.disabled = true
	crouch_collision_shape.disabled = true
		
func enable_collision_shapes() -> void:
	if crouching:
		collision_shape.disabled = true
		crouch_collision_shape.disabled = false
	else:
		collision_shape.disabled = false
		crouch_collision_shape.disabled = true
