extends State

class_name HurtState

@onready var hurt_timer: Timer = $HurtTimer

@export var hurt_launch_velocity: Vector2 = Vector2(100, -100)

func enter(args: Dictionary = {}):
	can_move = false
	friction = 1
	if(args.has("direction")):
		character.velocity = hurt_launch_velocity * Vector2(1 * sign(args["direction"].x), 1)
	hurt_timer.start()

func update(delta):
	if hurt_timer.is_stopped():
		if character.alive:
			state_machine.change_state("AirFall")
		else:
			state_machine.change_state("Dead")
