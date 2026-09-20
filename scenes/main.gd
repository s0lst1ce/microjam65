extends Node2D

@onready var map = $Map
@onready var hud = $HUD

@onready var current_room: String = "corridor"

@onready var scenes = {
	"cafeteria": preload("res://scenes/cafeteria.tscn").instantiate(),
	"garden": preload("res://scenes/garden.tscn").instantiate(),
	"corridor": preload("res://scenes/corridor.tscn").instantiate(),
	"bedroom_couple": preload("res://scenes/bedroom_couple.tscn").instantiate(),
}

@onready var sfx = $SFX
@onready var hovered_furniture: Interactible = null

func _ready() -> void:
	SceneSwitching.goto_room.connect(_on_change_room)
	SceneSwitching.toggle_map.connect(_on_toggle_map)
	change_scene("corridor")

func _on_intro_video_finished() -> void:
	self.add_child(scenes[current_room])

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
