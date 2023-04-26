extends State

class_name AirFallState

@export var fall_acceleration: float = 1200
@export var fall_velocity_max: float = 2000
@export var coyote_time: float = 0.1
@export var jump_buffer: float = 0.2
@export var air_friction = 0.99
@export var acceleration_x = 10

@export var fall_animation: String = "fall"

var coyote_time_timer: float = 0
var jump_buffer_timer: float = 0

func physics_update(delta):
	apply_gravitation(delta)
	
func update(delta):
	update_timers(delta)
	
	if(character.is_on_floor()):
		if(jump_buffer_timer > 0):
			jump_buffer_timer = 0
			state_machine.change_state("Jump")
		else:
			state_machine.change_state("Ground")

func enter(args: Dictionary = {}):
	playback.travel(fall_animation)
	
	friction = air_friction
	acceleration = acceleration_x
	
	if(args.has('coyote_time')):    
		if(args['coyote_time']):
			coyote_time_timer = coyote_time
	else:
		coyote_time_timer = 0
	

func handle_input(event: InputEvent):
	if(event.is_action_pressed("jump") && coyote_time_timer > 0 ):
		state_machine.change_state("Jump")
	if(event.is_action_pressed("jump") && character.is_near_wall()):
		state_machine.change_state("WallJump")
	elif(event.is_action_pressed("jump")):
		jump_buffer_timer = jump_buffer
		

func apply_gravitation(delta: float):
	var applied_gravity: float = 0
	
	applied_gravity = fall_acceleration * delta
	
	if(character.velocity.y > fall_velocity_max):
		applied_gravity = 0
	
	character.velocity.y += applied_gravity
	
func update_timers(delta):
	coyote_time_timer -= delta
	jump_buffer_timer -= delta
