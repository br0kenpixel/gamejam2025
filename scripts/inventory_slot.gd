extends Panel

@onready var item_display := $CenterContainer/Panel/ItemDisplay

func update(item: InventoryItem) -> void:
	if item == null:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.texture