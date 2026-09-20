extends Panel

@onready var icon: TextureRect = $Icon
#@onready var item_highlight: ColorRect = $Icon/ItemHighlight
@export var token: TokenData
@export var correct: TokenData
@export var idx: int

func _ready() -> void:
#	connect("mouse_entered", _on_mouse_entered)
	update_ui()

func update_ui():
	if token == null:
		icon.texture=null
	else:
		icon.texture = token.icon
		#TODO update this based on collected clues
		if Dialogic.VAR.table_puzzle_enabled:
			tooltip_text = token.tooltip


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

	if token==correct:
		Enigma.table_puzzle[idx] = 1
		if not Enigma.table_puzzle_completed and Enigma.table_puzzle_complete():
			Dialogic.start("table_success").process_mode = Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			ItemExchange.add_item.emit(preload("res://items/donut.tres"))
			ItemExchange.add_item.emit(preload("res://items/donut.tres"))
			
	else:
		Enigma.table_puzzle[idx] = 0

	slot.icon.show()
	update_ui()
	slot.update_ui()
	#print("Dropped ", item, slot.item)

#func _on_mouse_entered() -> void:
#	item_highlight.visible=false
