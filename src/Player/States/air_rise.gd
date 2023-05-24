extends State

class_name AirRiseState

@export var air_max_speed: float = 90
@export var air_acceleration: float = 750
@export var air_velocity: float = 1400
@export var air_velocity_max: float = 500
@export var air_cut: float = 0.5
@export var air_hang_treshold: float = 5
@export var air_hang_gravity_mult : float = 0.1
@export var air_friction: float = 0.8
@export var acceleration_x = 10

@export var jump_animation: String = "jump"

var lock_movement_timer = 0

func update(delta):
	update_timers(delta)
	
	if(lock_movement_timer < 0):
		can_move = true
	
	if(character.velocity.y > 0):
		state_machine.change_state("AirFall")

func physics_update(delta):
	apply_gravitation(delta)
	if(!Input.is_action_pressed("jump")):
		character.velocity.y -= character.velocity.y * air_cut

func handle_input(event: InputEvent):
	if(event.is_action_pressed("jump") && character.is_near_wall() && !character.is_inside_wall()):
		state_machine.change_state("WallJump")
		
func enter(args: Dictionary = {}):
	if(args.has("cant_move")):
		lock_movement_timer = args['cant_move']
		can_move = false
	
	friction = air_friction
	acceleration = acceleration_x
	max_speed = air_max_speed

func apply_gravitation(delta: float):
	var applied_gravity: float = 0
	
	applied_gravity = air_acceleration * delta
	
	if(character.velocity.y > air_velocity_max):
		applied_gravity = 0
		
	if(abs(character.velocity.y) < air_hang_treshold):
		applied_gravity *= air_hang_gravity_mult
	
	character.velocity.y += applied_gravity
	
func update_timers(delta: float):
	lock_movement_timer -= delta
