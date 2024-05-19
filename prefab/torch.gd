extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var is_healing = true

func _on_interaction_area_body_shape_entered(body_rid:RID, body:Node2D, body_shape_index:int, local_shape_index:int):
	print("Entered")
	#print the name of the body that entered the area
	print(body.name)
	if body.is_in_group("player"):
		body.get_node("Player").set("can_interact", true)
	pass # Replace with function body.


func _on_interaction_area_area_entered(area:Area2D):
	#get the parent of the area
	var parent = area.get_parent()
	if parent.is_in_group("player"):
		var player: Player = parent
		parent.constantheal(true)
	pass # Replace with function body.



func _on_interaction_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	var parent = area.get_parent()
	if parent.is_in_group("player"):
		var player: Player = parent
		parent.constantheal(false)
	pass # Replace with function body.
