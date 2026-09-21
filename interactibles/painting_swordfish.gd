extends Interactible

func _on_click() -> void:
	if Dialogic.VAR.puzzle_pieces_count == 36:
		$PaintingPuzzle.show()
	else:
		Dialogic.start("puzzle_not_enough_pieces")
