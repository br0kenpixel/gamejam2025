extends Panel

func update(item: InventoryItem) -> void:
	if item == null:
		$ItemDisplay.visible = false
	else:
		$ItemDisplay.visible = true
		$ItemDisplay.texture = item.texture