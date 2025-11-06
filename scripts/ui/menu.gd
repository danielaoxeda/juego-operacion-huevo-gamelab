extends Node


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_credits_pressed() -> void:
	Transition.change_scene_with_transition("res://scenes/Creditos.tscn")
