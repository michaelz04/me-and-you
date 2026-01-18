extends Node2D

# Simple battle scene placeholder

var player_hp: int = 100
var player_max_hp: int = 100
var enemy_hp: int = 100
var enemy_max_hp: int = 100

const LIGHT_ATTACK_DAMAGE = 10
const HEAVY_ATTACK_DAMAGE = 30
const SPECIAL_ATTACK_DAMAGE = 50

const ENEMY_LIGHT_ATTACK_DAMAGE = 8
const ENEMY_HEAVY_ATTACK_DAMAGE = 20
const ENEMY_SPECIAL_ATTACK_DAMAGE = 35

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
		show_main_menu()
		return
	
	# Return to main menu after attack
	show_main_menu()
	
	# Enemy turn - attack after player
	await get_tree().create_timer(0.5).timeout  # Small delay before enemy attack
	enemy_attack()

func enemy_attack():
	# Randomly choose an enemy attack
	var attack_choice = randi() % 3
	var damage = 0
	var attack_name = ""
	
	match attack_choice:
		0:
			damage = ENEMY_LIGHT_ATTACK_DAMAGE
			attack_name = "Light Attack"
		1:
			damage = ENEMY_HEAVY_ATTACK_DAMAGE
			attack_name = "Heavy Attack"
		2:
			damage = ENEMY_SPECIAL_ATTACK_DAMAGE
			attack_name = "Special Attack"
	
	player_hp -= damage
	
	# Make sure HP doesn't go below 0
	if player_hp < 0:
		player_hp = 0
	
	update_hp_display()
	
	print("Enemy uses %s for %d damage! Player HP: %d / %d" % [attack_name, damage, player_hp, player_max_hp])
	
	# Check if player is defeated
	if player_hp <= 0:
		print("Player defeated!")

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
