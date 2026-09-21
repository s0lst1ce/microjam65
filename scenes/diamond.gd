extends Interactible

func _ready():
	super ._ready()
	Enigma.drop_diamond.connect(_appear)
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()

func _process(_delta:float) -> void:
	if len(gives)== 0:
		queue_free()

func _appear():
	process_mode = Node.PROCESS_MODE_INHERIT
	show()
