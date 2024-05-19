extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@export var scene_path_file: String = "default"
@onready var parent: Pipe = get_parent()
@onready var animation = $AnimatedSprite
@onready var left: GPUParticles2D = $left
@onready var right: GPUParticles2D = $right

func _ready():
	if left != null and right != null:
		left.emitting = false
		right.emitting = false
	animation.play("closed")
	interaction_area.interact = Callable(self, "_switch_scene")

func _process(delta):
	parent = get_parent()
	if parent.WORKING:
		animation.play("open")
		if left != null and right != null:
			left.emitting = true
			right.emitting = true
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
