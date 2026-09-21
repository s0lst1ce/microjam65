extends Panel

@onready var icon: TextureRect = $Icon
#@onready var item_highlight: ColorRect = $Icon/ItemHighlight
@export var token: ShrimpToken
@export var correct: ShrimpToken
@export var correct_mirrored: bool
@export var idx: int

func _ready() -> void:
#	connect("mouse_entered", _on_mouse_entered)
	connect("gui_input", _on_gui_input)
	update_ui()

func update_ui():
	if token == null:
		icon.texture=null
	else:
		icon.texture = token.icon
		tooltip_text = token.tooltip
		icon.flip_h = token.mirrored


func _get_drag_data(_at_position: Vector2) -> Variant:
	if not token:
		print("no token")
		return

	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	# half the size of a slot -> makes it centered
	preview.position -= Vector2(64,64)
	# trasparent background instead of the slot bg
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	#icon.hide()
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, slot: Variant) -> void:
	var tmp = token
	token = slot.token
	slot.token=tmp

	verify()

	slot.icon.show()
	update_ui()
	slot.update_ui()
	#print("Dropped ", item, slot.item)

#func _on_mouse_entered() -> void:
#	item_highlight.visible=false

func verify():
	print(Enigma.shrimp_puzzle)
	if token.mirrored == correct_mirrored and token==correct:
		Enigma.shrimp_puzzle[idx] = 1
		if not Enigma.shrimp_puzzle_completed and Enigma.shrimp_puzzle_complete():
			Enigma.remove_shrimp_frame.emit()

	else:
		Enigma.table_puzzle[idx] = 0

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		print("clicked")
		if token.name != "shrimpaired":
			token.mirrored = not token.mirrored
			verify()
		update_ui()
