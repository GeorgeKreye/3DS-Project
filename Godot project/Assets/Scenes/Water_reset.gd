extends Area3D


@onready var water_character = $"../Water_Character"
@onready var mouse = $"../Mouse"




# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		mouse.global_position = water_character.global_position
