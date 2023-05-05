extends Node

class_name State

var can_move: bool = true:
	set = _set_can_move
var acceleration: float = 0:
	set = _set_acceleration
var friction: float = 0:
	set = _set_friction
var max_speed: float = 0:
	set = _set_max_speed
	
var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var state_machine: CharacterStateMachine

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
	
func _set_max_speed(s: float):
	max_speed = s
