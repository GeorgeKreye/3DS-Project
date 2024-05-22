extends RigidBody3D


@onready var rocks = $Rocks



func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		rocks.play()
