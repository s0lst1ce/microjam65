extends Node

@onready var table_puzzle = [0, 0, 0, 0, 0, 0]

func table_puzzle_complete():
	if table_puzzle == [1, 1, 1, 1, 1, 1]:
		print("table puzzle completed!")
		return true
	else:
		return false
