extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#get child animatedsprite2D
@onready var animatedsprite2D = $AnimatedSprite2D
@onready var lifetimer = $LifeTimer

var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	lifetimer.start()
	lifetimer.connect("timeout", _on_lifetimer_timeout)
	animatedsprite2D.play("idle")
	#sprite animatedsprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction < 0:
		animatedsprite2D.flip_h = true
	elif direction > 0:
		animatedsprite2D.flip_h = false
	move_and_slide()

func _on_lifetimer_timeout():
	print("Life timer timeout")
	health -= 10
	if health <= 0:
		get_tree().change_scene_to_file("res://Menus/Menu.tscn")
