extends Node2D

func _ready() -> void:
	if PlayerVariables.player != null:
		$Player.insects = PlayerVariables.player.insects
		PlayerVariables.player = null
	
	if PlayerVariables.enemy != null:
		var children := get_children()
		for child in children:
			if child.name == PlayerVariables.enemy.name:
				child.call_deferred("queue_free")
				PlayerVariables.enemy = null
