extends State

class_name CrouchState

@export var crouch_offset: float = 4
@export var crouch_friction: float = 0.1
@export var crouch_acceleration: float = 40
@export var crouch_max_speed: float = 45
@export var crouch_animation: String = "crouch"
@export var crouch_collision_shape: CollisionShape2D
@export var normal_collision_shape: CollisionShape2D

func handle_input(event: InputEvent):
	if event.is_action_released("down"):
		state_machine.change_state("Ground")
		
	if event.is_action_pressed("jump"):
		_jump()
		
func update(delta):
	character.velocity.y = 0
	if !character.is_on_floor() and !Input.is_action_pressed("glitch_key") and !character.is_inside_wall():
		state_machine.change_state("AirFall", {"double_jump": true, "coyote_time": true})

func enter(args: Dictionary = {}):
	$CrouchAudio.play()
	playback.travel(crouch_animation)
	character.crouching = true
	can_aim_down = false
	
	_scale_character_nodes(1)
	
	acceleration = crouch_acceleration
	friction = crouch_friction
	max_speed = crouch_max_speed
	
func exit():
	character.crouching = false
	_scale_character_nodes(-1)
	
func _scale_character_nodes(direction: int):
	# Resize collisionbox
	character.resize_collision_box(direction * crouch_offset)
	
	# Resize hurtbox
	character.hurt_box.resize(direction * crouch_offset)
	
	# Resize inside wall raycasts
	character.resize_inside_wall_raycasts(direction * crouch_offset)
		
func _jump():
	state_machine.change_state("Jump")
	
