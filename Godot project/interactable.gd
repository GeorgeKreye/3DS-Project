extends Node3D

@export var interaction_range: float = 0.3

# signals
signal do_interaction
signal can_interact

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# send interaction signal if in range and button pressed
	if in_interaction_range() and Input.is_action_just_pressed("interact"):
		do_interaction.emit()

func in_interaction_range() -> bool:
	# get player object
	var player : CharacterBody3D = get_node("Mouse")
	
	# check if close enough for interaction and return
	var within_interaction_range = abs(player.position - position) <= interaction_range
	if within_interaction_range:
		can_interact.emit() # send signal that interaction is possible
	return within_interaction_range
