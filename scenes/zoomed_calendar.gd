extends CanvasLayer

func _on_visibility_changed() -> void:
	if is_node_ready():
		get_tree().paused = not get_tree().paused
		SceneSwitching.toggle_hud_visibility.emit()

func _on_close_button_pressed() -> void:
	hide()
