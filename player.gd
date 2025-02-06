extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	
	position.x = clamp(position.x, ($Sprite2D.texture.get_width() / 2), (get_viewport_rect().size.x) - ($Sprite2D.texture.get_width() / 2))
	position.y = clamp(position.y, ($Sprite2D.texture.get_height() / 2), (get_viewport_rect().size.y) - ($Sprite2D.texture.get_height() / 2))