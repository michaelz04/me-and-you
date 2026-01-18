extends Node2D

# Simple battle scene placeholder

func _on_back_to_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_attack_button_pressed():
	print("Attack button pressed!")

func _on_item_button_pressed():
	print("Item button pressed!")
