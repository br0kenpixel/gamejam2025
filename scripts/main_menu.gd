extends Control

func _ready() -> void:
	_auto_size_bg()

func _auto_size_bg():
	var viewport_size := get_viewport_rect().size
	$Background.size = viewport_size

func _process(_delta):
	if Input.is_action_just_pressed("exit_game"):
		_quit_game()

func _quit_game():
	get_tree().quit()
