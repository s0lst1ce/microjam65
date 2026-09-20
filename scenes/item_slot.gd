extends Panel

@onready var icon: TextureRect = $Icon
@onready var item_highlight: ColorRect = $ItemHighlight
@export var item: ItemData

func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	update_ui()
	
func update_ui():
	if not item:
		icon.texture=null
	else:
		icon.texture = item.icon
		tooltip_text = item.name


func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item:
		return

	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	# half the size of a slot -> makes it centered
	preview.position -= Vector2(25,25)
	# trasparent background instead of the slot bg
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	icon.hide()
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data.item != null and item !=null and data.item.combines_with == item.name:
		if item.combines_into.combine_sound != null:
			Conductor.play_sfx.emit(item.combines_into.combine_sound)
		item = item.combines_into
		data.item=null
	else:
		var tmp = item
		item = data.item
		data.item=tmp

	data.icon.show()
	update_ui()
	data.update_ui()
	#print("Dropped ", item, data.item)

func _on_mouse_entered() -> void:
	item_highlight.visible=false
