extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@export var scene_path_file: String = "default"

func _ready():
	interaction_area.interact = Callable(self, "_switch_scene")

func _switch_scene():
	if scene_path_file != "default":
		var error = get_tree().change_scene_to_file(scene_path_file)
		if error != OK:
			print("Failed to load scene: " + scene_path_file)
	else:
		print("No scene specified.")
