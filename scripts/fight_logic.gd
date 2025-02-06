extends Control

func _ready() -> void:
	var enemy := PlayerVariables.enemy
	var player := PlayerVariables.player

	player.in_fight = true

	get_tree().root.add_child(enemy)
	$PlayerContainer.add_child(player)

func _process(_delta: float) -> void:
	pass
