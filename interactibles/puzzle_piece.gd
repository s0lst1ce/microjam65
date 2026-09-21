extends Interactible

func _on_click() -> void:
	if Dialogic.VAR.puzzle_pieces_count == 0:
		Dialogic.start("puzzle_piece_first")
	Dialogic.VAR.puzzle_pieces_count += 3
	if Dialogic.VAR.puzzle_pieces_count == 36:
		Dialogic.start("puzzle_piece_last")

	queue_free()
