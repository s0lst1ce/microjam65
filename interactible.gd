@icon("res://assets/editor/click.svg")
#@tool
extends Sprite2D

class_name Interactible

@export var interacts_with: Array[String]
@export var gives: Array[ItemData] = []
@export var click_sound: AudioStream

@onready var area = $Area2D

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if area == null:
		warnings.append("Furniture must have a child Area2D")
	elif $Area2D/CollisionShape2D == null:
		warnings.append("Furniture must have a CollisionShape2D")
	elif $Area2D/CollisionShape2D.shape == null:
		warnings.append("A shape must be provided for CollisionShape2D")
	
	if interacts_with == null:
		warnings.append("Interaction candidate(s) must be set. Otherwise it should be turned into a Sprite2D.")

	return warnings

func _ready() -> void:
	var warnings = _get_configuration_warnings()
	if not warnings.is_empty():
		for warning in warnings:
			push_warning(warning)
		push_error(self.name, " is incorrectly configured and cannot be safely constructed")
		queue_free()
		return

	area.connect("mouse_entered", _on_mouse_enter)
	var shape = $Area2D/CollisionShape2D.shape
	if shape == null:
		shape = RectangleShape2D.new()
		shape.size = self.texture.get_size()

func _on_mouse_enter():
	print("mouse entered")
	ItemExchange.start_furniture_hover.emit(self)

func _interact_with(_item: ItemData) -> void:
	pass

func catch_item(data: Variant) -> void:
	print(name, process_mode, get_tree().paused)
	if data.item.name in interacts_with:
		print(data.item, " is interacting with ", self)
		_interact_with(data.item)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and get_rect().has_point(get_global_mouse_position()-position):
		get_viewport().set_input_as_handled()
		print("empty-handed interaction")
		empty_handed_interaction()

func empty_handed_interaction():
		if len(gives) > 0:
			print("giving items")
			for item in gives:
				if item.pickup_sound != null:
					Conductor.play_sfx.emit(item.pickup_sound)
				ItemExchange.add_item.emit(item)
			gives.clear()

		else:
			print("empty-hand interaction")
			if click_sound != null:
				Conductor.play_sfx.emit(click_sound)
			_on_click()

func _on_click() -> void:
	pass
