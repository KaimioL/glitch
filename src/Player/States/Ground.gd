extends State

class_name GroundState

@export var speed: float = 200
@export var start_friction: float = 1
@export var normal_friction: float = 0.1
@export var ground_acceleration: float = 40

@export var move_animation: String = "move"

var first_tick: bool = false

func update(delta):
	if(!character.is_on_floor() && !Input.is_action_pressed("glitch_key")):
		state_machine.change_state("AirFall", {"double_jump": true, "coyote_time": true})
	if(Input.is_action_pressed("jump")):
		_jump()

func physics_update(delta):
	if(first_tick):
		first_tick = false
	else:
		friction = normal_friction

func handle_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		_jump()

func enter(args: Dictionary = {}):
	friction = start_friction
	acceleration = ground_acceleration
	playback.travel(move_animation)

func _jump():
	state_machine.change_state("Jump", {"jump": true, "double_jump": true})
