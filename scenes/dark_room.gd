extends Interactible

func _interact_with(_item: ItemData) -> void:
	print("interacting")
	queue_free()
