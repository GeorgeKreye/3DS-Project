extends Area3D

@export var reset_position : Vector3 = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func change_reset_position(new_pos: Vector3):
	reset_position = new_pos


func _on_body_entered(body):
	# check if player
	if body.is_in_group("Mouse"):
		# reset player position
		body.position = reset_position
		
