extends Area3D

@onready var label = $"../Control/Label"

#var timer = Time.new()

func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		label.visible = true
		await get_tree().create_timer(2.5).timeout
		label.visible = false
		queue_free()

