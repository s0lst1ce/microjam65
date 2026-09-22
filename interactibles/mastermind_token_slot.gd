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
		tooltip_text = token.tooltip


func _get_drag_data(_at_position: Vector2) -> Variant:
	if not token:
		return

	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(64,64)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, slot: Variant) -> void:
	var tmp = token
	token = slot.token
	slot.token=tmp

	if token==correct:
		Enigma.mastermind_puzzle[idx] = 1
		if not Enigma.mastermind_completed and Enigma.mastermind_complete():
			Enigma.close_mastermind.emit()
			ItemExchange.add_item.emit(preload("res://items/necklace.tres"))
			ItemExchange.add_item.emit(preload("res://items/medal.tres"))
			ItemExchange.add_item.emit(preload("res://items/sword.tres"))

	else:
		Enigma.table_puzzle[idx] = 0

	slot.icon.show()
	update_ui()
	slot.update_ui()
