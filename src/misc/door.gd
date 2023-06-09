extends Node2D

@export var direction: String
@export var target_room: int

var is_open: bool = false
# Maybe find better solution for checking if door is flipped, probably its because duplicating node doesnt call process and negative scale is not saved after transform
var is_flipped: bool = false 

signal transitioned(target_room, direction)

func _process(delta):
	if direction == "w" and not is_flipped:
		scale.x *= -1
		is_flipped = true

func play_open_animation():
	$AnimationPlayer.play("open")
	is_open = true

func play_close_animation():
	$AnimationPlayer.play_backwards("open")
	is_open = false

func open():
	$AnimationPlayer.play("INSTANT_OPENED")
	is_open = true
	
func close():
	$AnimationPlayer.play("RESET")
	is_open = false

func take_damage(amount: int, direction: Vector2):
	if not is_open:
		play_open_animation()

func _on_transition_area_body_entered(body):
	get_parent().get_parent().transitioned.emit(get_meta("entity_data").fields.TargetRoom, direction)
