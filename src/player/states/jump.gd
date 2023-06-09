extends State

class_name JumpState

@export var jump_velocity: float = 300
@export var jump_animation: String = "jump"

func update(delta):
	state_machine.change_state("AirRise")

func enter(args: Dictionary = {}):
	$JumpAudio.play()
	playback.travel(jump_animation)
	
	character.velocity.y = -jump_velocity
