extends Interactible

@onready var filled = preload("res://assets/furniture/painting_completed.png")

func _ready() -> void:
	super ._ready()
	Enigma.drop_diamond.connect(_complete_painting)

func _on_click() -> void:
	if Dialogic.VAR.puzzle_pieces_count == 36:
		$PaintingPuzzle.show()
	else:
		Dialogic.start("puzzle_not_enough_pieces")

func _complete_painting():
	texture = filled
