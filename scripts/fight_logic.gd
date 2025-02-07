extends Control

var current_opponent_insect: Insect = null
var current_player_insect: Insect = null

var turn := false # False = player_insects, True = opponent_insects

func _ready() -> void:
	load_next_opponent_insect()
	load_next_player_insect()

func _process(_delta: float) -> void:
	if current_opponent_insect.health == 0:
		load_next_opponent_insect()
	if current_player_insect.health == 0:
		load_next_player_insect()

	update_insect_stats()

func attack1() -> void:
	if turn:
		current_opponent_insect.attack1(current_player_insect)
	else:
		current_player_insect.attack1(current_opponent_insect)

func attack2() -> void:
	pass

func attack3() -> void:
	pass

func load_next_player_insect() -> void:
	if current_player_insect != null:
		current_player_insect.call_deferred("queue_free")

	current_player_insect = get_next_player_insect()

	var x := 256
	var y := get_viewport_rect().size.y - 256
	current_player_insect.position = Vector2(x, y)

func load_next_opponent_insect() -> void:
	if current_opponent_insect != null:
		current_opponent_insect.call_deferred("queue_free")

	current_opponent_insect = get_next_opponent_insect()

	var x := get_viewport_rect().size.x - 256
	var y := 128
	current_opponent_insect.position = Vector2(x, y)

func get_next_player_insect() -> Insect:
	return PlayerVariables.player.insects[0]

func get_next_opponent_insect() -> Insect:
	return PlayerVariables.enemy.insects[0]

func update_insect_stats() -> void:
	current_opponent_insect.update_ui()
	current_player_insect.update_ui()