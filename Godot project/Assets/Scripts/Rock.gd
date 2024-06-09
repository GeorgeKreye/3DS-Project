extends RigidBody3D

@onready var rocks = $rocks





func _on_body_entered(body):
	print(body)
	if body.is_in_group("Mouse"):
		rocks.play()
