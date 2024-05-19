extends Area2D

var WORKING = false

enum nstate {
	VERT, #Horizontal
	HORIZ #Vertical
}
enum cstate {
	HG, # Haut - Gauche
	GB, # Gauche - Bas
	BD, # Bas - Droite
	DH  # Droite - Haut
}

var actual_state = [nstate.VERT]

var expected_state = [nstate.HORIZ]

func getNextState(state):
	if typeof(state) is nstate:
		if state == nstate.VERT:
			return nstate.HORIZ
		else:
			return nstate.VERT
	else:
		if state == cstate.HG:
			return cstate.GB
		elif state == cstate.GB:
			return cstate.BD
		elif state == cstate.BD:
			return cstate.DH
		else:
			return cstate.HG
		

func isWorking() -> bool:
	if actual_state == expected_state:
		WORKING = true
		return true
	WORKING = false
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	isWorking()

func on_pipe_change(pipe: Array, index):
	if (index >= pipe.size() or index < 0):
		print("pipe null")
		return
	print("pipe change")
	pipe[index] = getNextState(pipe[index])
	isWorking()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
