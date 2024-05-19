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
		pipe.WORKING = true
	timer.start(1.0)

func _turn_off_lamp():
	activated = false
	if pipe:
		pipe.WORKING = false
	timer.stop()
