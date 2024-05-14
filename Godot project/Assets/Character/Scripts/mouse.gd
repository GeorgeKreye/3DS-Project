extends CharacterBody3D

@export_category("Lateral movement")
## Movement speed on the ground
@export var movement_speed : float = 5.0

@export_category("Vertical movement")
## Vertical velocity to apply on jump
@export var jump_force: float = 5.0
## Magnitude of effect gravity should have
@export var grav_modifier: float = 1.0

@onready var game_gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * grav_modifier

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

# Determines 2D/lateral movement for a frame.
func determine_movement() -> Vector3:
	# determine movement from inputs
	var movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward")
	
	# create movement vector & return
	return (transform.basis * Vector3(movement_input.x,0,movement_input.y)).normalized() * movement_speed
