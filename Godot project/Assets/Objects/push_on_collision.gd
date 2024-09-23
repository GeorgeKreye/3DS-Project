extends RigidBody3D

var push_vel: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	linear_velocity = push_vel
	push_vel = Vector3.ZERO



func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		push_vel = body.linear_velocity
