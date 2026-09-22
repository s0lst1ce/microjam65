extends CanvasLayer

@onready var solved = false

func _ready() -> void:
	Dialogic.text_signal.connect(_on_dialogic_text_signal)
	Enigma.close_mastermind.connect(_on_close_button_pressed)

func _on_visibility_changed() -> void:
	if is_node_ready():
		print("changing mastermind puzzle visibility")
		get_tree().paused = not get_tree().paused
		SceneSwitching.toggle_hud_visibility.emit()

func _on_close_button_pressed() -> void:
	hide()

func _on_dialogic_text_signal(argument: String):
	if argument == "leave_mastermind":
		visible=false
