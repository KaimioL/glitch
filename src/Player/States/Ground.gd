extends State

class_name GroundState

@export var start_friction: float = 1
@export var normal_friction: float = 0.1
@export var ground_acceleration: float = 40

@export var move_animation: String = "move"

func update(delta):
	
	
	character.velocity.y = 0
	if(!character.is_on_floor() && !Input.is_action_pressed("glitch_key") && !character.is_inside_wall()):
		state_machine.change_state("AirFall", {"double_jump": true, "coyote_time": true})
	
	if(Input.is_action_pressed("down")):
		_crouch()
	
#	if(Input.is_action_pressed("jump")):
#		_jump()

func physics_update(delta):
	friction = normal_friction

func handle_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		_jump()
		
#	if(event.is_action_pressed("down")):
#		_crouch()

func enter(args: Dictionary = {}):
	acceleration = ground_acceleration
	playback.travel(move_animation)

func _jump():
	state_machine.change_state("Jump")

func _crouch():
	state_machine.change_state("Crouch")
