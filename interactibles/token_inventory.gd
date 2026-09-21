extends Panel

@onready var grid_container: GridContainer = $"./MarginContainer/GridContainer"

func _ready() -> void:
	pass
	#ItemExchange.add_item.connect(_on_add_item)


var data_bk
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if data_bk:
			data_bk.icon.show()
			data_bk = null

func _on_add_item(item: ItemData):
	print("adding ", item)
	for slot in grid_container.get_children():
		if is_instance_of(slot, TextureButton):
			return
		print(slot)
		if slot.item == null:
			slot.item = item
			slot.item_highlight.visible = true
			slot.update_ui()
			return
	assert(false)
