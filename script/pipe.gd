extends TileMap

@onready var timer = $Timer

var coords_list = [[4,5],[7,5],[7,9], [4,9]] # rotated pipe clockwise (down to right), (right to down), (up to left), (left to up)
var output_list = [[coords_list[0], coords_list[1]], # upper pipe can only be linked with these
				   [coords_list[1], coords_list[2]], # right pipe can only be linked with these
				   [coords_list[2], coords_list[3]], # lower pipe can only be linked with these
				   [coords_list[3], coords_list[0]]] # left pipe can only be linked with these
var pipe_output_list = [[4,8],[5,5],[7,6],[6,9]] # output of the pipe
var pipe_input : Vector2i = Vector2i(1, 7)

# Called when the node enters sthe scene tree for the first time.
func _ready():
	timer.start()
	pass # Replace with function body.

func spread_gas():
	#look for pipe input in the map
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spread_gas()
	pass

func get_next_rotation(atlas_coord):
	for i in range(0, 4):
		if atlas_coord == Vector2i(coords_list[i][0], coords_list[i][1]):
			return Vector2i(coords_list[(i+1)%4][0], coords_list[(i+1)%4][1])
	return Vector2i(-1, -1)

func _on_timer_timeout():
    # Itérer sur toutes les cellules du TileMap et appliquer la rotation
	print("test")
    
    # Example coordinates for a 2x2 region
	var start_coords = Vector2i(12, 29)
	var end_coords = Vector2i(12, 29) # Inclusive range

	for x in range(start_coords.x, end_coords.x + 1):
			var coords = Vector2i(x, start_coords.y)
			var atlas_coords = get_cell_atlas_coords(0, coords)
			print("atlas cord: ", atlas_coords)
			if atlas_coords != Vector2i(-1, -1) and [atlas_coords.x, atlas_coords.y] in coords_list:
				var new_atlas_coords = get_next_rotation(atlas_coords)
				set_cell(0, coords, 0, new_atlas_coords)

	pass # Replace with function body.
