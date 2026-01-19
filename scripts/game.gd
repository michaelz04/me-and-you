extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D

var fixed_camera_y = 0.0

func _ready():
	# Initialize camera to player position and store fixed Y
	if camera and player:
		camera.global_position = player.global_position
		fixed_camera_y = camera.global_position.y

func _process(_delta):
	if not player or not camera:
		return
	
	var player_pos = player.global_position
	
	# Set camera position directly (follow player X, vertical fixed)
	camera.global_position = Vector2(
		player_pos.x,
		fixed_camera_y
	)

func _on_enter_battle_button_pressed():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
