extends State

class_name CrouchState

@export var crouch_offset: int = 4
@export var crouch_friction: float = 0.1
@export var crouch_acceleration: float = 40

@export var crouch_animation: String = "crouch"
@export var crouch_collision_shape: CollisionShape2D
@export var normal_collision_shape: CollisionShape2D

func handle_input(event: InputEvent):
	if(event.is_action_released("down")):
		state_machine.change_state("Ground")
		
	if(event.is_action_pressed("jump")):
		_jump()
		
func update(delta):
	character.velocity.y = 0
	if(!character.is_on_floor() && !Input.is_action_pressed("glitch_key") && !character.is_inside_wall()):
		state_machine.change_state("AirFall", {"double_jump": true, "coyote_time": true})

func enter(args: Dictionary = {}):
	playback.travel(crouch_animation)
	character.crouching = true
	
	_scale_character_nodes(1)
	
	acceleration = crouch_acceleration
	friction = crouch_friction
	
func exit():
	character.crouching = false
	_scale_character_nodes(-1)
	
func _scale_character_nodes(direction: int):
	character.sprite.offset.y += direction * crouch_offset
	for raycast in character.inside_wall_raycasts.get_children():
		raycast.target_position.y -= direction * crouch_offset
		raycast.position.y += direction * crouch_offset
		
func _jump():
	state_machine.change_state("Jump")
	
