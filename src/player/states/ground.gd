extends State

class_name GroundState

@export var ground_friction: float = 0.1
@export var ground_acceleration: float = 40
@export var ground_max_speed: float = 90

@export var move_animation: String = "move"

func update(delta):
	character.velocity.y = 0
	if !character.is_on_floor() && !Input.is_action_pressed("glitch_key") && !character.is_inside_wall():
		state_machine.change_state("AirFall", {"double_jump": true, "coyote_time": true})
	
	if Input.is_action_pressed("down") and state_machine.pickups["crouch"]:
		_crouch()

func handle_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		_jump()

func enter(args: Dictionary = {}):
	can_aim_down = false
	acceleration = ground_acceleration
	friction = ground_friction
	max_speed = ground_max_speed
	playback.travel(move_animation)

func _jump():
	state_machine.change_state("Jump")

func _crouch():
	state_machine.change_state("Crouch")
