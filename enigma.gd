extends Node


@onready var table_puzzle = [0, 0, 0, 0, 0, 0, 1]
@onready var table_puzzle_completed = false
var painting_puzzle: Array = []
@onready var correct_painting_puzzle = []
@onready var painting_puzzle_completed=false


signal drop_diamond

func _ready() -> void:
	for i in range(0, 36):
		painting_puzzle.append(0)
		correct_painting_puzzle.append(1)

func table_puzzle_complete():
	#the seventh item doesn't matter, it's just there for the code not to crash (yes it's aweful)
	if table_puzzle == [1, 1, 1, 1, 1, 1, 1] or table_puzzle == [1, 1, 1, 1, 1, 1, 0]:
		print("table puzzle completed!")
		table_puzzle_completed = true
		return true
	else:
		return false

func painting_puzzle_complete():
	if painting_puzzle == correct_painting_puzzle:
		print("painting puzzle completed")
		painting_puzzle_completed=true
		return true
	else:
		return false
