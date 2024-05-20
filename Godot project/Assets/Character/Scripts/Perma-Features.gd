extends Node3D

#@onready var fade = $Control/AnimationPlayer


var scene2 = preload("res://Assets/Scenes/destroyed_scene.tscn")

#signal fadeEnd

#var count = 0


# Called when the node enters the scene tree for the first time.

#func _on_body_entered(body):
	

#func fader():
	#fade.play("FadeOut")
	

#func _on_animation_player_animation_finished(anim_name):
	#if anim_name == "Fade out":
		#emit_signal("fadeEnd")
		#fader().play("Fade in")


#func _on_area_3d_body_entered(body):

#func _change

func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		#fader()
		#await fadeEnd
		#get_tree().change_scene_to_file("res://Assets/Scenes/destroyed_scene.tscn")
		get_tree().change_scene_to_packed(scene2)
	


#func _on_animation_player_animation_finished(anim_name):
	#if anim_name == "FadeOut":
		#emit_signal("fadeEnd")
		#fade.play("FadeIn")
