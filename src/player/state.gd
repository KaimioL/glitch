extends Node

class_name State

var can_move: bool = true:
	set = _set_can_move
var can_turn: bool = true:
	set = _set_can_move
var can_attack: bool = true:
	set = _set_can_attack
var can_aim_down: bool = true:
	set = _set_can_aim_down
var acceleration: float = 40:
	set = _set_acceleration
var friction: float = 1:
	set = _set_friction
var max_speed: float = 90:
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

func _set_can_aim_down(s: bool):
	can_aim_down = s

func _set_can_move(s: bool):
	can_move = s

func _set_friction(s: float):
	friction = s
	
func _set_acceleration(s: float):
	acceleration = s
	
func _set_max_speed(s: float):
	max_speed = s
	
func _set_can_attack(s: bool):
	can_attack = s
