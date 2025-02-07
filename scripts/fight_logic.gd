extends Control

var current_opponent_insect: Insect = null
var current_player_insect: Insect = null
var turn := false # False = player, True = opponent

func _ready() -> void:
	load_next_opponent_insect()
	load_next_player_insect()

func _process(_delta: float) -> void:
	if turn:
		# Opponent's turn
		print("Opponent will now attack")
		opponent_turn_exec()
	else:
		# Player's turn
		print("Player will now attack")
	
	update_insect_stats()

	if current_opponent_insect.health <= 0:
		print("Opponent insect died")
		if !load_next_opponent_insect():
			print("Opponent does not have any insects left, player wins")
			PlayerVariables.player.level += 1
			exit_fight()
			return
			
	if current_player_insect.health <= 0:
		print("Player's insect died")
		if !load_next_player_insect():
			print("Player does not have any insects left, opponent wins")
			PlayerVariables.player.level -= 1
			if PlayerVariables.player.level < 0:
				PlayerVariables.player.level = 0
			exit_fight()
			return

func opponent_turn_exec() -> void:
	var attack := randi_range(1, 3)

	print("Opponent chose attack #", attack)

	match attack:
		1: attack1()
		2: attack2()
		3: attack3()
		_: push_error("bug?")

func attack1() -> void:
	if turn:
		current_opponent_insect.attack1(current_player_insect)
	else:
		current_player_insect.attack1(current_opponent_insect)
	
	turn = !turn

func attack2() -> void:
	if turn:
		current_opponent_insect.attack2(current_player_insect)
	else:
		current_player_insect.attack2(current_opponent_insect)

	turn = !turn

func attack3() -> void:
	if turn:
		current_opponent_insect.attack3(current_player_insect)
	else:
		current_player_insect.attack3(current_opponent_insect)

	turn = !turn

func load_next_player_insect() -> bool:
	if current_player_insect != null:
		current_player_insect.call_deferred("queue_free")
		PlayerVariables.player.insects.remove_at(0)

	current_player_insect = get_next_player_insect()
	if current_player_insect == null:
		return false

	current_player_insect.health_bar = $PlayerStats/HealthBar/HPBar
	current_player_insect.info_label = $PlayerStats/StatsDisplay
	$PlayerTexture.texture = current_player_insect.sprite

	var x := 320 / 2
	var y := (get_viewport_rect().size.y) - 400
	$PlayerTexture.position = Vector2(x, y)
	return true

func load_next_opponent_insect() -> bool:
	if current_opponent_insect != null:
		current_opponent_insect.call_deferred("queue_free")
		PlayerVariables.enemy.insects.remove_at(0)

	current_opponent_insect = get_next_opponent_insect()
	if current_opponent_insect == null:
		return false

	current_opponent_insect.health_bar = $EnemyStats/HealthBar/HPBar
	current_opponent_insect.info_label = $EnemyStats/StatsDisplay
	$OpponentTexture.texture = current_opponent_insect.sprite

	var x := get_viewport_rect().size.x - 400
	var y := 320 / 2
	$OpponentTexture.position = Vector2(x, y)
	return true

func get_next_player_insect() -> Insect:
	if PlayerVariables.player.insects.is_empty():
		return null
	return PlayerVariables.player.insects[0]

func get_next_opponent_insect() -> Insect:
	if PlayerVariables.enemy.insects.is_empty():
		return null
	return PlayerVariables.enemy.insects[0]

func update_insect_stats() -> void:
	current_opponent_insect.update_ui()
	current_player_insect.update_ui()

func cancel_fight() -> void:
	PlayerVariables.enemy = null
	exit_fight()

func exit_fight() -> void:
	get_tree().change_scene_to_file("res://scenes/new_world.tscn")
	print("ending fight")
