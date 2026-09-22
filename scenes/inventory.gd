extends Panel

@onready var grid_container: GridContainer = $"./MarginContainer/GridContainer"



func _ready() -> void:	
	ItemExchange.add_item.connect(_on_add_item)
	Dialogic.signal_event.connect(_on_dialogic_signal)

#func _process(delta: float) -> void:
#	if Input.get_current_cursor_shape() == CURSOR_FORBIDDEN:
#		DisplayServer.cursor_set_shape(DisplayServer.CURSOR_ARROW)

var data_bk
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if data_bk:
			print("droppping ", data_bk)
			ItemExchange.drop_item.emit(data_bk)
			data_bk.icon.show()
			data_bk = null

func _on_add_item(item: ItemData):
	print("adding ", item)
	for slot in grid_container.get_children():
		if slot.item == null:
			slot.item = item
			slot.item_highlight.visible = true
			slot.update_ui()
			return
	assert(false)

func _on_dialogic_signal(argument:String):
	if argument == "gain_can":
		ItemExchange.add_item.emit(preload("res://items/shrimp_can.tres"))

func _toggle_visibility():
	visible = not visible
