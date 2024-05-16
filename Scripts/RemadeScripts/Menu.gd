extends Node2D



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/RemadeScenes/main.tscn")


func _on_controls_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
