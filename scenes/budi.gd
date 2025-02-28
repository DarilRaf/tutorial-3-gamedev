extends CharacterBody2D

@export var gravity = 1000.0
@export var walk_speed = 200
@export var crouch_speed = 100
@export var jump_speed = -400

@export var dash_speed = 600
@export var dash_duration = 0.2
@export var dash_cooldown = 0.3

# Normal variables
var crouching = false
var double_jump = true
var can_dash = false
var is_dashing = false
var last_move_dir = 0

# Onready variables should come after exported variables
@onready var dash_timer: Timer = $DashTimer
@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var sprite_budi: AnimatedSprite2D = $SpriteBudi
@onready var collision_budi: CollisionShape2D = $CollisionShape2D


func _physics_process(delta):
	velocity.y += delta * gravity

	var move_dir = 0
	if Input.is_action_pressed("ui_left"):
		move_dir = -1
		sprite_budi.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		move_dir = 1
		sprite_budi.flip_h = false

	if Input.is_action_just_pressed("ui_down"):
		crouching = true
		sprite_budi.play("crouch")
	elif Input.is_action_just_released("ui_down"):
		crouching = false
		sprite_budi.play("idle")

	# Double-tap dash check
	if Input.is_action_just_pressed("ui_right") and can_dash and last_move_dir == 1 and !crouching:
		start_dash(1)
	elif (
		Input.is_action_just_pressed("ui_left") and can_dash and last_move_dir == -1 and !crouching
	):
		start_dash(-1)

	if is_dashing:
		# Instead of gradually accelerating, instantly set dash velocity
		velocity.x = dash_speed * last_move_dir
		if !crouching:
			sprite_budi.play("running")
	else:
		# Normal horizontal movement
		if move_dir != 0:
			if crouching:
				velocity.x = move_dir * crouch_speed
				gravity = 5000
			else:
				sprite_budi.play("running")
				velocity.x = move_dir * walk_speed
				gravity = 1000
		else:
			# No input -> smoothly stop
			velocity.x = lerp(velocity.x, 0.0, delta * 10)
			if !crouching:
				sprite_budi.play("idle")

	# Jump logic
	if is_on_floor():
		double_jump = true
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
	elif not is_on_floor() and Input.is_action_just_pressed("ui_up") and double_jump:
		velocity.y = jump_speed
		double_jump = false

	if not is_on_floor() and !crouching:
		sprite_budi.play("jump")

	# Start dash window once movement key is released
	if Input.is_action_just_released("ui_right") and last_move_dir == 1:
		start_dash_window()
	elif Input.is_action_just_released("ui_left") and last_move_dir == -1:
		start_dash_window()

	last_move_dir = move_dir if move_dir != 0 else last_move_dir

	move_and_slide()


func start_dash_window():
	can_dash = true
	dash_timer.start()


func _on_dash_timer_timeout():
	can_dash = false


func start_dash(_direction):
	is_dashing = true
	can_dash = false
	dash_duration_timer.start()


func _on_dash_duration_timer_timeout():
	is_dashing = false
