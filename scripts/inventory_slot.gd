extends Panel

@onready var item_visual := $CenterContainer/Panel/ItemDisplay

func update(item: InventoryItem) -> void:
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
