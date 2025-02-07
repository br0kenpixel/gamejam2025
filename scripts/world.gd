extends Node2D

func _ready() -> void:
	if PlayerVariables.player != null:
		$Player.insects = PlayerVariables.player.insects
		$Player.level = PlayerVariables.player.level
		print("syncing player instance")
		PlayerVariables.player = null
	
	if PlayerVariables.enemy != null:
		PlayerVariables.defeated_enemies.push_back(PlayerVariables.enemy)

	if get_enemies().is_empty():
		PlayerVariables.player.die()
	
	var fightable_enemy_found := false
	for child in get_enemies():
		if child.level <= $Player.level:
			fightable_enemy_found = true
			break
	
	if !fightable_enemy_found:
		PlayerVariables.player.die()

func get_enemies() -> Array[Enemy]:
	var children := get_children()
	var result: Array[Enemy] = []

	for child in children:
		if child is Enemy:
			result.push_back(child as Enemy)
	
	return result
