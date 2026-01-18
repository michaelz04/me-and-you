extends Node2D

# Simple battle scene placeholder

var player_hp: int = 100
var player_max_hp: int = 100
var enemy_hp: int = 100
var enemy_max_hp: int = 100

const LIGHT_ATTACK_DAMAGE = 10
const HEAVY_ATTACK_DAMAGE = 30
const SPECIAL_ATTACK_DAMAGE = 50

@onready var player_hp_label = $PlayerHPLabel
@onready var enemy_hp_label = $EnemyHPLabel
@onready var battle_menu = $UI/BattleMenu
@onready var attack_submenu = $UI/AttackSubmenu

func _ready():
	update_hp_display()
	show_main_menu()

func update_hp_display():
	player_hp_label.text = "HP: %d / %d" % [player_hp, player_max_hp]
	enemy_hp_label.text = "HP: %d / %d" % [enemy_hp, enemy_max_hp]

func show_main_menu():
	battle_menu.visible = true
	attack_submenu.visible = false

func show_attack_submenu():
	battle_menu.visible = false
	attack_submenu.visible = true

func player_attack(damage: int, attack_name: String):
	enemy_hp -= damage
	
	# Make sure HP doesn't go below 0
	if enemy_hp < 0:
		enemy_hp = 0
	
	update_hp_display()
	
	print("Player uses %s for %d damage! Enemy HP: %d / %d" % [attack_name, damage, enemy_hp, enemy_max_hp])
	
	# Check if enemy is defeated
	if enemy_hp <= 0:
		print("Enemy defeated!")
	
	# Return to main menu after attack
	show_main_menu()

func _on_back_to_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_attack_button_pressed():
	show_attack_submenu()

func _on_item_button_pressed():
	print("Item button pressed!")

func _on_light_attack_button_pressed():
	player_attack(LIGHT_ATTACK_DAMAGE, "Light Attack")

func _on_heavy_attack_button_pressed():
	player_attack(HEAVY_ATTACK_DAMAGE, "Heavy Attack")

func _on_special_attack_button_pressed():
	player_attack(SPECIAL_ATTACK_DAMAGE, "Special Attack")

func _on_attack_submenu_back_pressed():
	show_main_menu()
