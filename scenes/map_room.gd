extends TextureButton

@export var room: String

func _on_pressed() -> void:
	print("clicked")
	SceneSwitching.goto_room.emit(room)
