extends Panel

@onready var icon: TextureRect = $Icon
#@onready var item_highlight: ColorRect = $Icon/ItemHighlight
@export var token: PuzzlePiece
@export var correct: PuzzlePiece
@export var idx: int

func _ready() -> void:
	update_ui()

func update_ui():
	if token == null:
		icon.texture=null
	else:
		icon.texture = token.icon


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
	
	check_validity()

	slot.icon.show()
	update_ui()
	slot.update_ui()
	#print("Dropped ", item, slot.item)

func check_validity():
	if token==correct:
		Enigma.painting_puzzle[token.idx]=1
		if not Enigma.painting_puzzle_completed and Enigma.painting_puzzle_complete():
			Enigma.drop_diamond.emit()
			ItemExchange.add_item.emit(preload("res://items/diamond.tres"))
			
	else:
		Enigma.painting_puzzle[token.idx]=0

	#print(Enigma.painting_puzzle)

#func _on_mouse_entered() -> void:
#	item_highlight.visible=false
