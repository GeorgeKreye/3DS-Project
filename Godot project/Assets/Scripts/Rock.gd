extends RigidBody3D


@onready var rock_sound = $"../Rock/rock/Rock_Sound"



func _on_body_entered(body):
	print(body)
	if body.is_in_group("Mouse"):
		
		rock_sound.play()
