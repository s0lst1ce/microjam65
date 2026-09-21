extends Interactible

func _process(_delta: float) -> void:
	if len(gives) == 0:
		queue_free()
