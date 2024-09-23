extends Node3D

var scene6 = preload("res://Assets/Scenes/END.tscn")
#@onready var chill_mouse = $Area3D/MouseHappy




var count = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass





func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		#mouse_happy.play()
		#await(get_tree().create_timer(2).timeout)
		
		#fader()
		#await fadeEnd
		#get_tree().change_scene_to_file("res://Assets/Scenes/destroyed_scene.tscn")
		get_tree().change_scene_to_packed(scene6)
		count += 1
		print(count)
