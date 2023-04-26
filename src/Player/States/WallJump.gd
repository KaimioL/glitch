extends JumpState

class_name WallJump

@export var wall_jump_velocity: Vector2 = Vector2(150, -300)
@export var duration: float = 0.1

func enter(args: Dictionary = {}):
	character.velocity = wall_jump_velocity * Vector2(character.is_near_wall(), 1)
	can_move = false
	state_machine.change_state("AirRise", {"cant_move": duration})

