extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $AnimatedSprite2D

@export var activated: bool:
	get:
		return sprite.animation == "on"
	set(value):
		sprite.play("on" if value else "off")

func _ready():
	sprite.play("off")
	interaction_area.interact = Callable(self, "_toggle_lamp")

func _toggle_lamp():
	activated = not activated
