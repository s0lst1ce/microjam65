extends Interactible


func _ready() -> void:
	super ._ready()
	Enigma.remove_shrimp_frame.connect(_complete_shrimp_puzzle)

func _on_click() -> void:
	if Dialogic.VAR.collected_shrimps_counts == 5:
		$ShrimpPuzzle.show()
	else:
		Dialogic.start("missing_shrimp")

func _complete_shrimp_puzzle():
	queue_free()
