extends CanvasLayer

@onready var solved = false

func _ready() -> void:
	Dialogic.text_signal.connect(_on_dialogic_text_signal)

func _on_visibility_changed() -> void:
	if is_node_ready():
		get_tree().paused = not get_tree().paused
		SceneSwitching.toggle_hud_visibility.emit()

func _on_close_button_pressed() -> void:
	print("closing")
	hide()


func _on_dialogic_text_signal(argument: String):
	if argument == "leave_shrimp":
		visible=false
