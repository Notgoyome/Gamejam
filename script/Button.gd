extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer
@export var pipe: Pipe
@export var index: int

var _activated: bool = false

@export var activated: bool:
	get:
		return _activated
	set(value):
		_activated = value
		if sprite:
			if value:
				sprite.play("on")
			else:
				sprite.play("off")

func _ready():
	sprite.play("off")
	interaction_area.interact = Callable(self, "_toggle_lamp")
	timer.connect("timeout", Callable(self, "_turn_off_lamp"))

func _toggle_lamp():
	activated = true
	if pipe:
		pipe.on_pipe_change(index)
	timer.start(1.0)

func _turn_off_lamp():
	activated = false
	timer.stop()
