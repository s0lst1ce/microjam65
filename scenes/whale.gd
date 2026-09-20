extends Interactible


func _on_click() -> void:
	print(Dialogic.VAR.NextDialogue.whale)
	if Dialogic.VAR.NextDialogue.whale != null:
		Dialogic.start(Dialogic.VAR.NextDialogue.whale)
	#Dialogic.VAR.NextDialogue.whale = null
