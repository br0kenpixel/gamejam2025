extends Control

@onready var slots := [
	$GridContainer/TextureButton,
	$GridContainer/TextureButton2,
	$GridContainer/TextureButton3,
	$GridContainer/TextureButton4
]

signal item_selected(n: int)

func fill_with_inventory(iv: Array[Insect]) -> void:
	for item_index in iv.size():
		slots[item_index].texture_normal = iv[item_index].sprite
		slots[item_index].tooltip_text = iv[item_index].enemy_name

func open() -> void:
	visible = true
	z_index = 1

func close() -> void:
	visible = false

func inventory_item_selected(n: int) -> void:
	print("(ll) inventory item ", n, " clicked")
	item_selected.emit(n)