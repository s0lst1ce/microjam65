extends Interactible

func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.swordfish)
	if Dialogic.VAR.NextDialogue.swordfish != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.swordfish)
