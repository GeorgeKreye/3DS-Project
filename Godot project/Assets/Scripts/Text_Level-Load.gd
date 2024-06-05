extends Label

@onready var label = $"."


func _ready():
	pass

func _process(delta):
	await get_tree().create_timer(5.0).timeout
	label.visible = false
	
