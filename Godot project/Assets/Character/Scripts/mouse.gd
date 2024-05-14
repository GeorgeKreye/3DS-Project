extends CharacterBody3D

@export_category("Lateral movement")
@export var movement_speed : float = 5.0

@onready var game_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# apply gravity
	if not is_on_floor():
		velocity.y -= game_gravity * delta
	
	# determine 2D (lateral) movement
	var movement = determine_movement(delta)
	velocity.x = movement.x
	velocity.z = movement.z
	
	# perform movement
	move_and_slide()


# Determines 2D/lateral movement for a frame.
func determine_movement(delta) -> Vector3:
	# determine movement from inputs
	var movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward")
	
	# create movement vector & return
	return (transform.basis * Vector3(movement_input.x,0,movement_input.y)).normalized() * movement_speed
