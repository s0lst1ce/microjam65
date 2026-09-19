extends TextureButton

@onready var opened = preload("res://assets/misc/map_open.png")
@onready var closed = preload("res://assets/misc/map_close.png")
@onready var is_open = false

func _on_pressed():
	SceneSwitching.toggle_map.emit()
