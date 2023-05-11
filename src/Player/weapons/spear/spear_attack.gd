extends Node2D

func _process(delta):
	pass

func attack() -> void:
	$Effect.visible = true
	$AnimationPlayer.play("attack")
	get_parent().start_attack_cooldown()
	for hitcheck in $Hitchecks.get_children():
		print(hitcheck.is_colliding())
		if(hitcheck.is_colliding()):
			get_parent().do_collision_launch(hitcheck.get_collision_normal())

func _on_animation_player_animation_finished(anim_name):
	$Effect.visible = false
