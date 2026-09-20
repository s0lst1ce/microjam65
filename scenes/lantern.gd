extends Interactible

func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.lantern)
	if Dialogic.VAR.NextDialogue.lantern != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.lantern)
