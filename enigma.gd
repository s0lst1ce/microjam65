extends Node


@onready var table_puzzle = [0, 0, 0, 0, 0, 0, 1]
@onready var table_puzzle_completed = false

func table_puzzle_complete():
	#the seventh item doesn't matter, it's just there for the code not to crash (yes it's aweful)
	if table_puzzle == [1, 1, 1, 1, 1, 1, 1] or table_puzzle == [1, 1, 1, 1, 1, 1, 0]:
		print("table puzzle completed!")
		table_puzzle_completed = true
		return true
	else:
		return false
