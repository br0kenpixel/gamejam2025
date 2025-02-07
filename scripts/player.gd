class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var front_view: Texture2D
@export var back_view: Texture2D
@export var left_view: Texture2D
@export var right_view: Texture2D
@export var insects: Array[Insect]
@export var level: int = 1

@onready var fight_guide := $FightGuide

var in_fight := false
var last_direction := Vector2.ZERO

func _ready() -> void:
	fight_guide.visible = false

func _physics_process(_delta: float) -> void:
	handle_move()
	handle_fight_start()

func handle_move() -> void:
	if in_fight:
		return
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		last_direction.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = direction * SPEED
		last_direction.y = direction
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	update_sprite_texture()
	move_and_slide()

func update_sprite_texture() -> void:
	if last_direction.x > 0:
		$Image.texture = right_view
	elif last_direction.x < 0:
		$Image.texture = left_view
	elif last_direction.y > 0:
		$Image.texture = front_view
	elif last_direction.y < 0:
		$Image.texture = back_view
	last_direction = Vector2.ZERO

func handle_fight_start() -> void:
	if in_fight:
		return
	
	var nearest_enemy := get_nearest_enemy()
	if nearest_enemy != null:
		if Input.is_action_just_pressed("fight_start") and level >= nearest_enemy.level:
			get_tree().change_scene_to_file("res://scenes/fight.tscn")
			print("starting fight")
			PlayerVariables.player = self.duplicate()
			PlayerVariables.enemy = nearest_enemy.duplicate()
			return
		elif level >= nearest_enemy.level:
			fight_guide.visible = true
			fight_guide.text = "Press [ENTER] to begin fight"
		else:
			fight_guide.visible = true
			fight_guide.text = "Requires LVL " + str(nearest_enemy.level)
	else:
		fight_guide.visible = false

func get_nearest_enemy() -> Enemy:
	var enemies := get_tree().get_nodes_in_group("enemies")

	for enemy in enemies:
		if enemy.global_position.distance_to(global_position) <= 150:
			return enemy
	
	return null