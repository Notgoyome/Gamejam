extends Control

var transition_duration = 0.5
var menu_max_travel = 60

var center_of_screen = Vector2(0, 0)
var menu_origin_position = Vector2(0, 0)
var menu_origin_size = Vector2(0, 0)

var current_menu
var menu_stack := []

@onready var menu1 = $Menu1
@onready var menu2 = $Menu2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rect = get_viewport_rect()
	center_of_screen = position + rect.size / 2
	menu_origin_position = Vector2(0, 0)
	menu_origin_size = get_viewport_rect().size
	current_menu = menu1

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	var dist_to_mouse = ((get_global_mouse_position() - center_of_screen)* -1).clamp(Vector2(-menu_max_travel, -menu_max_travel), Vector2(menu_max_travel, menu_max_travel))
	global_position = lerp(global_position, dist_to_mouse, delta * 2)

func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_id(next_menu_id)
	var tween = get_tree().create_tween()
	tween.tween_property(current_menu, "position", Vector2(-menu_origin_size.x, 0), transition_duration)
	tween.tween_property(next_menu, "position", menu_origin_position, transition_duration)
	tween.play()
	menu_stack.append(current_menu)
	current_menu = next_menu

func move_to_previous_menu():
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		var tween = get_tree().create_tween()
		tween.tween_property(current_menu, "position", Vector2(menu_origin_size.x, 0), transition_duration)
		tween.tween_property(previous_menu, "position", menu_origin_position, transition_duration)
		tween.play()
		current_menu = previous_menu

func get_menu_from_id(menu_id: String) -> Control:
	match menu_id:
		"menu1":
			return menu1
		"menu2":
			return menu2
		_:
			return menu1

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://base.tscn")

func _on_options_button_pressed():
	# get_tree().change_scene("res://Menus/Options.tscn")
	move_to_next_menu("menu2")

func _on_back_button_pressed():
	move_to_previous_menu()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_x_1080_pressed():
	menu1.scale = Vector2(1, 1)
	menu2.scale = Vector2(1, 1)
	get_window().set_size(Vector2(1920, 1080))

func _on_x_1440_pressed():
	menu1.scale = Vector2(1.3333333333333333, 1.3333333333333333)
	menu2.scale = Vector2(1.3333333333333333, 1.3333333333333333)
	get_window().set_size(Vector2(2560, 1440))

func _on_x_720_pressed():
	menu1.scale = Vector2(0.6666666666666666, 0.6666666666666666)
	menu2.scale = Vector2(0.6666666666666666, 0.6666666666666666)
	get_window().set_size(Vector2(1280, 720))
	get_window().get_viewport().set_size(Vector2(1280, 720))

