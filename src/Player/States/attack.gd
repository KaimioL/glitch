extends State
class_name AttackState

@export var attack_animation = "attack_forward"

func enter(args: Dictionary = {}):
	playback.travel(attack_animation)

func _on_animation_tree_animation_finished(anim_name):
	state_machine.change_state("Ground")
