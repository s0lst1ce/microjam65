extends Node

@warning_ignore_start("unused_signal")

signal add_item(item: ItemData)
signal can_give(furniture)
signal walk_to(pos: Vector2, furniture: Interactible)
signal prepare_use_item(data: Variant)
signal drop_item(data: Variant)
signal start_furniture_hover(furniture: Interactible)

@warning_ignore_restore("unused_signal")
