extends Interactible

func _interact_with(_item: ItemData) -> void:
	print(_item)
	$Calendar.show()
