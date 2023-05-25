extends Node2D

var current_weapon: Weapon = null

func shoot():
	if current_weapon:
		current_weapon.shoot()

func look_up():
	if current_weapon:
		current_weapon.look_up()
		
func look_down():
	if current_weapon:
		current_weapon.look_down()
		
func look_forward():
	if current_weapon:
		current_weapon.look_forward()

func change_weapon(weapon_name: String):
	for weapon in get_children():
		if weapon.name == weapon_name:
			weapon.visible = true
			current_weapon = weapon
		else:
			weapon.visible = false

func change_player_velocity(velocity: Vector2):
	get_parent().velocity = velocity
