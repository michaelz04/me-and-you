extends Node2D

func _on_enter_battle_button_pressed():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
