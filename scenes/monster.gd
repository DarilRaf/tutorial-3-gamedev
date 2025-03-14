extends CharacterBody2D

@export var SPEED := 100
@export var GRAVITY := 1200
@export var WALK_TIME := 2.0  # Time to walk in one direction (seconds)
@export var WALK_DISTANCE := 200  # Alternative: Distance to walk in pixels
@onready var animplayer = $AnimatedSprite2D
@onready var audio_hit: AudioStreamPlayer2D = $AudioHit

var direction := -1  # Start moving left
var time_walking := 0.0
var start_position := Vector2.ZERO
var using_time_based := true  # Set to false to use distance-based movement

func _ready():
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += delta * GRAVITY
	
	# Handle movement based on timer or distance
	if using_time_based:
		_handle_time_based_movement(delta)
	else:
		_handle_distance_based_movement()
	
	# Set animation
	var animation = "idle"
	animplayer.play(animation)
	
	# Set sprite direction
	if direction > 0:
		animplayer.flip_h = true
	else:
		animplayer.flip_h = false
	
	# Apply movement
	move_and_slide()

func _handle_time_based_movement(delta: float) -> void:
	# Update the walking timer
	time_walking += delta
	
	# Check if it's time to change direction
	if time_walking >= WALK_TIME:
		direction *= -1  # Change direction
		time_walking = 0.0  # Reset timer
	
	# Set velocity based on direction
	velocity.x = direction * SPEED

func _handle_distance_based_movement() -> void:
	# Calculate the distance walked from starting point
	var distance_walked = abs(global_position.x - start_position.x)
	
	# Check if we've walked far enough in current direction
	if distance_walked >= WALK_DISTANCE:
		direction *= -1  # Change direction
		start_position = global_position  # Reset starting position
	
	# Set velocity based on direction
	velocity.x = direction * SPEED


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Budi":
		audio_hit.play()
		body.set_collision_mask_value(1, false)
