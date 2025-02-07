extends Control

func _ready() -> void:
	_auto_size_bg()

func _auto_size_bg():
	var viewport_size := get_viewport_rect().size
	$Background.size = viewport_size

func _start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/new_world.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("exit_game"):
		_quit_game()

func _quit_game():
	get_tree().quit()
