class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_just_pressed("fight_start"):
		var nearest_enemy := get_nearest_enemy()

		if nearest_enemy == null:
			push_warning("no enemies near")
		else:
			get_tree().change_scene_to_file("res://scenes/fight.tscn")
			print("starting fight")
			return

	move_and_slide()

func get_nearest_enemy() -> Node:
	var enemies := get_tree().get_nodes_in_group("enemies")

	for enemy in enemies:
		if enemy.global_position.distance_to(global_position) <= 200:
			return enemy
	
	return null
