extends Node2D


@export var firing_position : Marker2D

#@onready var player : Player = get_owner()

var bullet_scene : PackedScene = preload("res://scenes/projectiles/test_projectile.tscn")

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		
		# If we're aiming at a different side, flip the firing position across the X axis
		#if sign(player.aim_position.x) != sign(firing_position.position.x):
			#firing_position.position.x *= -1
		
		# Spawn a bullet and give it a rotation based on the angle between the firing position and
		# the cursor's position.
		# The bullet will use this rotation to decide its direction.
		var spawned_bullet := bullet_scene.instantiate()
		var mouse_direction := get_global_mouse_position() - firing_position.global_position
		
		get_tree().root.add_child(spawned_bullet)
		spawned_bullet.global_position = firing_position.global_position
		spawned_bullet.rotation = mouse_direction.angle()
		
		
		##################################################
		# Strategy Relevant Code:
		# Here, we loop over all of the upgrades currently
		# on the player, and apply their upgrade to the
		# spawned bullet.
		##################################################
		
