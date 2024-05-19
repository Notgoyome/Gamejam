extends CharacterBody2D

class_name Player

enum state {
	MOVE,
	PIPE_MOVE
}

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0
@export var SPEED_COEFFICIENT = 1.4

#get child animatedsprite2D
@onready var animatedsprite2D = $AnimatedSprite2D
@onready var lifetimer = $LifeTimer
@onready var fire_component = $FireComponent
@onready var hotParticle : GPUParticles2D = $hot
var constant_heal = false
var player_state = state.MOVE
var alive = true
var is_running = false

@export var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	lifetimer.start()
	lifetimer.connect("timeout", _on_lifetimer_timeout)
	animatedsprite2D.play("idle")
	#sprite animatedsprite2D

func _physics_process(delta):
	if player_state == state.MOVE:
		print("state move")
		animatedsprite2D.visible = true
		hotParticle.emitting = false
	elif player_state == state.PIPE_MOVE:
		#enable hot particle
		hotParticle.emitting = true
		animatedsprite2D.visible = false
	if dead():
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("run"):
		is_running = true
	elif Input.is_action_just_released("run"):
		is_running = false
	if direction:
		velocity.x = direction * SPEED
		if is_running:
			print("shift key pressed")
			velocity.x *= SPEED_COEFFICIENT
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction < 0:
		animatedsprite2D.flip_h = true
	elif direction > 0:
		animatedsprite2D.flip_h = false
	move_and_slide()

func _on_lifetimer_timeout():
	if constant_heal:
		heal(20)
	else:
		health -= 1
	fire_component.set_particle_scale(float(health)/100.0, float(2 * health)/100.0)
	fire_component.set_particle_lifetime(float(health)/100.0, float(health)/100.0)
	if health <= 50:
		animatedsprite2D.play("idle2")
	if health <= 0:
		alive = false
		# queue_free()

func dead() -> bool:
	if alive:
		return false
	else:
		return true

func heal(number: int):
	health += number
	if health > 100:
		health = 100
	fire_component.set_particle_scale(float(health)/100.0, float(2 * health)/100.0)
	fire_component.set_particle_lifetime(float(health)/100.0, float(health)/100.0)
	if health > 50:
		animatedsprite2D.play("idle")

func constantheal(boolean : bool):
	constant_heal = boolean
