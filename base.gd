extends Node2D

@onready var gameover = $gameOverControl
@onready var player = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.dead():
		gameover.end_game()
		pass
	pass

func _on_button_pressed():
	#reload the scene
	get_tree().reload_current_scene()
	pass


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Menus/Menu.tscn")
