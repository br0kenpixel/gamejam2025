extends Control

@onready var inventory := preload("res://player_inventory/player_inventory.tres")
@onready var slots := $NinePatchRect/GridContainer.get_children()

var is_open := false

func _ready() -> void:
	update_slots()
	close()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory_trigger"):
		print("i")
		if is_open:
			close()
		else:
			open()

func update_slots() -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open() -> void:
	visible = true
	is_open = true

func close() -> void:
	visible = false
	is_open = false
