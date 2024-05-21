extends CharacterBody3D

@export_category("Lateral movement")
## Movement speed on the ground
@export var movement_speed : float = 7.0

@export_category("Vertical movement")
## Vertical velocity to apply on jump
@export var jump_force: float = 10.0
## Magnitude of effect gravity should have
@export var grav_modifier: float = 2.0

@export_category("Camera")
## Mouse sensitivity for camera
@export var camera_sensitivity: float = 0.005
## Whether to invert mouse movement required to look up or down (default is mouse up to look down)
@export var invert_vertical : bool = false
var camera_look_input : Vector2


# variables to create on ready
@onready var camera : Camera3D = $Camera3D
@onready var game_gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * grav_modifier

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.rotation = Vector3(0,0,0) # ensure camera does not flip

# Called every physics update
func _physics_process(delta):
	# apply gravity
	if not is_on_floor():
		velocity.y -= game_gravity * delta
		
	# determine whether to jump this frame
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# determine 2D (lateral) movement
	var movement = determine_movement()
	velocity.x = movement.x
	velocity.z = movement.z
	
	# perform movement
	move_and_slide()
	
	# change y rotation based on camera
	var camera_rotation : float
	if invert_vertical: # check for inverted vertical camera movement controls
		camera_rotation = camera_look_input.x * -1
	else:
		camera_rotation = camera_look_input.x
	rotate_y(-camera_rotation * camera_sensitivity)
	
	# change camera vertical orientation
	camera.rotate_x(-camera_look_input.y * camera_sensitivity)
	camera.rotation.x = clamp (camera.rotation.x, -.6, .6)
	
	# reset look input
	camera_look_input = Vector2.ZERO

# Determines 2D/lateral movement for a frame.
func determine_movement() -> Vector3:
	# determine movement from inputs
	var movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward")
	
	# create movement vector & return
	return (transform.basis * Vector3(movement_input.x,0,movement_input.y)).normalized() * movement_speed
	
# handles mouse input
func _unhandled_input(event):
	# if unhandled event is mouse being moved, set look input to the change
	if event is InputEventMouseMotion:
		camera_look_input = event.relative
	
