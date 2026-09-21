extends Interactible

@onready var opened = preload("res://assets/furniture/ventilation_open.png")

func _interact_with(_item: ItemData) -> void:
	texture = opened
