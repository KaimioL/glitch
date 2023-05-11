extends State
class_name DeadState

@export var fall_max_speed: float = 120
@export var fall_acceleration: float = 1200
@export var fall_velocity_max: float = 350
@export var coyote_time: float = 0.1
@export var jump_buffer: float = 0.08
@export var air_friction = 0.1
@export var acceleration_x = 10

func enter(args: Dictionary = {}):
	can_move = false
	can_turn = false
	
	playback.travel("death")
	
func physics_update(delta):
	apply_gravitation(delta)
	
func apply_gravitation(delta: float):
	var applied_gravity: float = 0
	
	applied_gravity = fall_acceleration * delta
	
	if(character.velocity.y > fall_velocity_max):
		applied_gravity = 0
	
	character.velocity.y += applied_gravity
