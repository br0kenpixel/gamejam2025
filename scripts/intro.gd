extends Control

const IMAGES := [
	"res://sprites/intro/1.png",
	"res://sprites/intro/2.png",
	"res://sprites/intro/3.png",
	"res://sprites/intro/4.png"
]
var index := 0

func _ready() -> void:
	$Image.texture = load(IMAGES[index])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fight_start"):
		index += 1
		if index >= IMAGES.size():
			get_tree().change_scene_to_file("res://scenes/new_world.tscn")
		else:
			_ready()