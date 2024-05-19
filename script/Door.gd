extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@export var scene_path_file: String = "default"
@onready var parent: Pipe = get_parent()
@onready var animation = $AnimatedSprite

func _ready():
	animation.play("closed")
	interaction_area.interact = Callable(self, "_switch_scene")

func _process(delta):
	parent = get_parent()
	print(parent.WORKING)
	if parent.WORKING:
		animation.play("open")
	else:
		animation.play("closed")

func _switch_scene():
	if scene_path_file != "default" and parent.WORKING:
		
		var error = get_tree().change_scene_to_file(scene_path_file)
		if error != OK:
			print("Failed to load scene: " + scene_path_file)
	elif not parent.WORKING:
		print("Pipe is not working.")
	else:
		print("No scene specified.")
