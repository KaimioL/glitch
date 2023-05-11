extends Node2D

var _active_frame: bool = false

func _process(delta):
	if(_active_frame):
		for hitcheck in $Hitchecks.get_children():
			if(hitcheck.is_colliding()):
				if(hitcheck.get_collider().has_method("take_damage")):
					hitcheck.get_collider().take_damage(1)
				_active_frame = false
				get_parent().do_collision_launch(hitcheck.get_collision_normal())
				break

func attack() -> void:
	$Effect.visible = true
	$AnimationPlayer.play("attack")
	_active_frame = true
	get_parent().start_attack_cooldown()

func _on_animation_player_animation_finished(anim_name):
	$Effect.visible = false
	_active_frame = false
