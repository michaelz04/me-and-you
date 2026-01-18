extends Node2D

# Simple battle scene placeholder

var player_hp: int = 100
var player_max_hp: int = 100
var enemy_hp: int = 100
var enemy_max_hp: int = 100

@onready var player_hp_label = $PlayerHPLabel
@onready var enemy_hp_label = $EnemyHPLabel

func _ready():
	update_hp_display()

func update_hp_display():
	player_hp_label.text = "HP: %d / %d" % [player_hp, player_max_hp]
	enemy_hp_label.text = "HP: %d / %d" % [enemy_hp, enemy_max_hp]

func _on_back_to_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_attack_button_pressed():
	print("Attack button pressed!")

func _on_item_button_pressed():
	print("Item button pressed!")
