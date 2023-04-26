extends Node

class_name State

var can_move: bool = true:
	set = _set_can_move
var acceleration: float:
	set = _set_acceleration
var friction: float:
	set = _set_friction
	
var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var state_machine: CharacterStateMachine
var wall_check: RayCast2D 

func update(delta):
	pass
	
func physics_update(delta):
	pass

func handle_input(event: InputEvent):
	pass
	
func enter(args: Dictionary = {}):
	pass

func exit():
	pass

func _set_can_move(s: bool):
	can_move = s

func _set_friction(s: float):
	friction = s
	
func _set_acceleration(s: float):
	acceleration = s
