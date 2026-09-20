extends Interactible

func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.couple)
	if Dialogic.VAR.NextDialogue.couple != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.couple)
