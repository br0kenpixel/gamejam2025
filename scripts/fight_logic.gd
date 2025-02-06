extends Control

func _ready() -> void:
	var enemy := PlayerVariables.enemy
	var player := PlayerVariables.player

	player.in_fight = true

	get_tree().root.add_child(enemy)
	get_tree().root.add_child(player)

	var x = 256
	var y = get_viewport_rect().size.y - 256
	player.position = Vector2(x, y)

	x = get_viewport_rect().size.x - 256
	y = 128
	enemy.position = Vector2(x, y)

func _process(_delta: float) -> void:
	pass
