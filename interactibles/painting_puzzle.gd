extends CanvasLayer

@onready var solved = false
var pieces = []

func _ready() -> void:
	Dialogic.text_signal.connect(_on_dialogic_text_signal)
	for i in range(0, 36):
		pieces.append(i)
	pieces.shuffle()
	print(pieces)
	var children = $Painting/GridContainer.get_children()
	for i in range(0, 36):
		#TODO is this always in order
		children[i].correct = load("res://puzzle_pieces_tokens/%s.tres" % i)
		children[i].token = load("res://puzzle_pieces_tokens/%s.tres" % pieces[i])
		children[i].check_validity()
		children[i].update_ui()

func _on_visibility_changed() -> void:
	if is_node_ready():
		get_tree().paused = not get_tree().paused
		SceneSwitching.toggle_hud_visibility.emit()

func _on_close_button_pressed() -> void:
	print("closing")
	hide()

func _on_dialogic_text_signal(argument: String):
	if argument == "leave_table":
		hide()
