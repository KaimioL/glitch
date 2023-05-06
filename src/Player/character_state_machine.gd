extends Node

class_name CharacterStateMachine

signal transitioned(state_name)

@export var character: CharacterBody2D
@export var animation_tree: AnimationTree
@export var wall_raycasts: Node
@export var initial_state:= NodePath()

@onready var state: State = get_node(initial_state)

var can_move: float: 
	get: 
		return state.can_move
		
var acceleration: float:
	get:
		return state.acceleration
		
var friction: float:
	get:
		return state.friction
		
var max_speed: float:
	get:
		return state.max_speed

func _ready():
	for child in get_children():
		if(child is State):
			child.state_machine = self
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _unhandled_input(event: InputEvent):
	state.handle_input(event)

func _physics_process(delta):
	state.physics_update(delta)
	
func _process(delta):
	state.update(delta)

func change_state(target_state_name: String, args: Dictionary = {}):
	if !has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(args)
	emit_signal("transitioned", state.name)
