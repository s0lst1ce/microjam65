extends Interactible

func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.sharko)
	if Dialogic.VAR.NextDialogue.sharko != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.sharko)

func _interact_with(item: ItemData) -> void:
	if item.name == "shrimp_can":
		Dialogic.VAR.sharko_got_can = true
		Dialogic.start("sharko_bribed")
