extends RigidBody3D


@onready var rocks = $Rocks

#@onready var rock = $"../RigidBody3D/rock"



func _on_body_entered(body):
	print(body)
	if body.is_in_group("Mouse"):
		
		rocks.play()
