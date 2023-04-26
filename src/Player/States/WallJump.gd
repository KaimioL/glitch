extends JumpState

class_name WallJump

@export var wall_jump_velocity: Vector2 = Vector2(150, -200)
@export var duration: float = 0.1

var duration_timer: float = 0

func update(delta):
	_update_timers(delta)
	if(duration_timer < 0):
		state_machine.change_state("AirRise")

func enter(args: Dictionary = {}):
	character.velocity = wall_jump_velocity
	can_move = false
	duration_timer = duration

func _update_timers(delta):
	duration_timer -= delta
