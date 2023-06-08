extends State

class_name LandingState

func enter(args: Dictionary = {}):
	if args["jump_buffer"] > 0:
		state_machine.change_state("Jump")
	elif Input.is_action_pressed("down") and state_machine.pickups["crouch"]:
		state_machine.change_state("Crouch")
	else:
		state_machine.change_state("Ground")
