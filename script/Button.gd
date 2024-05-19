extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer
@export var pipe: Pipe

var _activated: bool = false

@export var activated: bool:
	get:
		return _activated
	set(value):
		_activated = value
		sprite.play("on" if value else "off")

func _ready():
	sprite.play("off")
	interaction_area.interact = Callable(self, "_toggle_lamp")
	timer.connect("timeout", Callable(self, "_turn_off_lamp"))

func _toggle_lamp():
	activated = true
	if pipe:
		var lab: Label = find_child("Label")
		print(lab.text)
		pipe.on_pipe_change(pipe.actual_state, int(lab.text))
	timer.start(1.0)

func _turn_off_lamp():
	activated = false
	if pipe:
		pipe.WORKING = false
	timer.stop()
