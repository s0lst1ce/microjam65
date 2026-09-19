extends Node2D

@onready var map = $Map
@onready var hud = $HUD

@onready var current_room: String = "garden"

@onready var scenes = {
	"cafeteria": preload("res://scenes/cafeteria.tscn").instantiate(),
	"garden": preload("res://scenes/garden.tscn").instantiate()
}


func _ready() -> void:
	SceneSwitching.goto_room.connect(_on_change_room)
	SceneSwitching.toggle_map.connect(_on_toggle_map)

func _on_intro_video_finished() -> void:
	self.add_child(scenes[current_room])

func change_scene(room: String) -> void:
	self.remove_child(scenes[current_room])
	current_room = room
	print(scenes[current_room])
	self.add_child(scenes[current_room])

func _on_change_room(room: String) -> void:
	print("changing room")
	change_scene(room)

func _on_toggle_map():
	if map.opened:
		map.paused=true
		map.hide()
		scenes[current_room].paused = true
	else:
		map.paused=false
		map.show()
		scenes[current_room].paused = false
