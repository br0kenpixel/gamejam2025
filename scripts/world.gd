extends Node2D

func _ready() -> void:
	if PlayerVariables.player != null:
		$Player.insects = PlayerVariables.player.insects
		$Player.level = PlayerVariables.player.level
		print("syncing player instance")
		PlayerVariables.player = null
	
	if PlayerVariables.enemy != null:
		var children := get_children()
		for child in children:
			if child is Enemy:
				if child.person_name == PlayerVariables.enemy.person_name:
					child.call_deferred("queue_free")
					print("syncing enemies")
					PlayerVariables.enemy = null
					return
