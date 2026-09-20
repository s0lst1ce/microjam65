extends Interactible

func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.sharko)
	if Dialogic.VAR.NextDialogue.sharko != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.sharko)
