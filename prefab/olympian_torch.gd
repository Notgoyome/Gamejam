extends StaticBody2D
enum state {
	ON,
	OFF
}

@onready var orange: GPUParticles2D = $FireTorch/orange
@onready var yellow: GPUParticles2D = $FireTorch/yellow

var fired = false
# Called when the node enters the scene tree for the first time.
func _ready():
	orange.emitting = false
	yellow.emitting = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var is_healing = true

func _on_interaction_area_area_entered(area:Area2D):
	#get the parent of the area
	
	var parent = area.get_parent()
	if parent.is_in_group("player"):
		orange.emitting = true
		yellow.emitting = true
		var player: Player = parent
		parent.constantheal(true)
	pass # Replace with function body.



func _on_interaction_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	var parent = area.get_parent()
	if parent.is_in_group("player"):
		var player: Player = parent
		parent.constantheal(false)
	pass # Replace with function body.
