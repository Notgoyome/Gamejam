extends Area2D

class_name Pipe

enum state {
	VERT, #Horizontal
	HORIZ, #Vertical
	HG, # Haut - Gauche
	GB, # Gauche - Bas
	BD, # Bas - Droite
	DH  # Droite - Haut
}

@export var actual_state: Array
@export var expected_state: Array
@export var tiles: Dictionary

var WORKING = false

func getNextState(stat):
	if stat == state.VERT:
		return state.HORIZ
	elif stat == state.HORIZ:
		return state.VERT
	elif stat == state.HG:
		return state.GB
	elif stat == state.GB:
		return state.BD
	elif stat == state.BD:
		return state.DH
	else:
		return state.HG

func isWorking() -> bool:
	if actual_state == expected_state:
		WORKING = true
		return true
	WORKING = false
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func on_pipe_change(index):
	if (index >= actual_state.size() or index < 0):
		return
	actual_state[index] = getNextState(actual_state[index])
	isWorking()
	print(actual_state)
	print(expected_state)
	var tile: TileMap = find_child(tiles[index])
	# radians = degrees * pi / 180
	if actual_state[index] == state.VERT:
		tile.rotate(90 * PI / 180)
	elif actual_state[index] == state.HORIZ:
		tile.rotate(90 * PI / 180)
	elif actual_state[index] == state.HG:
		tile.rotate(-90 * PI / 180)
	elif actual_state[index] == state.GB:
		tile.rotate(-90 * PI / 180)
	elif actual_state[index] == state.BD:
		tile.rotate(-90 * PI / 180)
	elif actual_state[index] == state.DH:
		tile.rotate(-90 * PI / 180)

	print(actual_state[index])


var b = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if WORKING:
		print("gg le sang")
		b = true
	
