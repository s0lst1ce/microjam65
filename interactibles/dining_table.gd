extends Interactible

@onready var puzzle = $TablePuzzle

func _on_click() -> void:
	puzzle.show()
