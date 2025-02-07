class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var insects: Array[Insect]
var in_fight := false

func _physics_process(_delta: float) -> void:
	handle_move()
	handle_fight_start()

func handle_move() -> void:
	if in_fight:
		return
	
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
	
	move_and_slide()

func handle_fight_start() -> void:
	if in_fight:
		return

	if Input.is_action_just_pressed("fight_start"):
		var nearest_enemy := get_nearest_enemy()

		if nearest_enemy == null:
			push_warning("no enemies near")
		else:
			get_tree().change_scene_to_file("res://scenes/fight.tscn")
			print("starting fight")
			PlayerVariables.player = self.duplicate()
			PlayerVariables.enemy = nearest_enemy.duplicate()
			return

func get_nearest_enemy() -> Enemy:
	var enemies := get_tree().get_nodes_in_group("enemies")

	for enemy in enemies:
		if enemy.global_position.distance_to(global_position) <= 200:
			return enemy
	
	return null
