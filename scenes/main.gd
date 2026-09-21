extends Node2D

@onready var map = $Map
@onready var hud = $HUD

@onready var current_room: String = "corridor"

@onready var scenes = {
	"cafeteria": preload("res://scenes/cafeteria.tscn").instantiate(),
	"garden": preload("res://scenes/garden.tscn").instantiate(),
	"corridor": preload("res://scenes/corridor.tscn").instantiate(),
	"bedroom_couple": preload("res://scenes/bedroom_couple.tscn").instantiate(),
	"bedroom_sharko": preload("res://scenes/bedroom_sharko.tscn").instantiate(),
	"bedroom_swordfish": preload("res://scenes/bedroom_swordfish.tscn").instantiate(),
	"bedroom_shrimp": preload("res://scenes/bedroom_shrimp.tscn").instantiate(),
	"library": preload("res://scenes/library.tscn").instantiate(),
}

@onready var sfx = $SFX
@onready var hovered_furniture: Interactible = null
@onready var dia_style: DialogicStyle = preload("res://addons/dialogic/Modules/DefaultLayoutParts/Style_VN_Default/default_vn_style.tres")

func _ready() -> void:
	dia_style.prepare()

	SceneSwitching.goto_room.connect(_on_change_room)
	SceneSwitching.toggle_map.connect(_on_toggle_map)
	SceneSwitching.toggle_hud_visibility.connect(_on_toggle_hud_visibility)
	ItemExchange.drop_item.connect(_on_drop_item)
	ItemExchange.start_furniture_hover.connect(_on_furniture_enter)

	self.add_child(scenes[current_room])
	Dialogic.preload_timeline("arrival")
	Dialogic.start("whale_greets")


func change_scene(room: String) -> void:
	self.remove_child(scenes[current_room])
	current_room = room
	print(scenes[current_room])
	self.add_child(scenes[current_room])

func _on_change_room(room: String) -> void:
	print("Going to ", room)
	change_scene(room)

func _on_toggle_map():
	#MAP
	get_tree().paused = not get_tree().paused
	scenes[current_room].visible = not scenes[current_room].visible
	#$Map/Control.modulate.a=0.0
	#map.modulate.a = 0.0
	map.visible = not map.visible
	#create_tween().tween_property($Map/Control, "modulate:a", 1.0, 0.15)
	
	#Map Button
	var button =$HUD/MapButton
	button.is_open = not button.is_open
	if button.is_open:
		button.texture_normal = button.opened
	else:
		button.texture_normal = button.closed

func _on_toggle_hud_visibility():
	hud.visible = not hud.visible
	
func _on_drop_item(data: Variant):
	print("Hovered ", hovered_furniture)
	if hovered_furniture != null and is_instance_valid(hovered_furniture) and hovered_furniture.get_rect().has_point(get_global_mouse_position()-hovered_furniture.position) and not get_tree().paused:
		print("hey man!")
		hovered_furniture.catch_item(data)

func _on_furniture_enter(furniture: Interactible):
	hovered_furniture = furniture
