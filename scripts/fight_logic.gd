extends Control

var current_opponent_insect: Insect = null
var current_player_insect: Insect = null

var turn := false # False = player_insects, True = opponent_insects

func _ready() -> void:
	load_next_opponent_insect()
	load_next_player_insect()

func _process(_delta: float) -> void:
	if current_opponent_insect.health <= 0:
		load_next_opponent_insect()
	if current_player_insect.health <= 0:
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
		PlayerVariables.player.insects.remove_at(0)

	current_player_insect = get_next_player_insect()
	current_player_insect.health_bar = $EnemyStats/HealthBar/HPBar
	current_player_insect.info_label = $PlayerStats/ExperienceDisplay/XPDisplay
	$PlayerTexture.texture = current_player_insect.sprite

	var x := 256
	var y := get_viewport_rect().size.y - 256
	$PlayerTexture.position = Vector2(x, y)

func load_next_opponent_insect() -> void:
	if current_opponent_insect != null:
		current_opponent_insect.call_deferred("queue_free")
		PlayerVariables.enemy.insects.remove_at(0)

	current_opponent_insect = get_next_opponent_insect()
	current_opponent_insect.health_bar = $EnemyStats/HealthBar/HPBar
	current_opponent_insect.info_label = $PlayerStats/ExperienceDisplay/XPDisplay
	$OpponentTexture.texture = current_opponent_insect.sprite

	var x := get_viewport_rect().size.x - 256
	var y := 128
	$OpponentTexture.position = Vector2(x, y)

func get_next_player_insect() -> Insect:
	return PlayerVariables.player.insects[0]

func get_next_opponent_insect() -> Insect:
	return PlayerVariables.enemy.insects[0]

func update_insect_stats() -> void:
	current_opponent_insect.update_ui()
	current_player_insect.update_ui()
