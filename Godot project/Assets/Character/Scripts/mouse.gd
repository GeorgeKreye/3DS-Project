extends CharacterBody3D

@export_category("Movement")
@export var movement_speed : float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# determine 2D movement
	var movement = determine_movement(delta)

	# perform 2D movement
	velocity.x = movement.x
	velocity.z = movement.z
	move_and_slide()


# Determines 2D movement for a frame.
func determine_movement(delta) -> Vector3:
	# determine movement from inputs
	var movement_input = Input.get_vector("move_left","move_right","move_up","move_down")
	
	# create movement vector & return
	var movement = (transform.basis * movement_input).normalized() * movement_speed
	return movement
