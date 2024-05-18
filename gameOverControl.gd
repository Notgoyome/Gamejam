extends Control

@onready var gameover = $GameOver
# Called when the node enters the scene tree for the first time.
func _ready():
	gameover.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func end_game():
	gameover.show()
