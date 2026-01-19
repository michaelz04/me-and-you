extends Node2D

@onready var sprite = $NPCSprite
@onready var dialogue_panel = $DialogueUI/DialoguePanel
@onready var dialogue_label = $DialogueUI/DialoguePanel/DialogueLabel
@onready var close_button = $DialogueUI/DialoguePanel/CloseButton

var player: Node2D = null
const INTERACTION_DISTANCE = 150.0
var is_dialogue_open = false

# Dialogue lines - you can customize these
var dialogue_lines = [
	"Hello there, traveler!",
	"Welcome to our world.",
	"How can I help you today?"
]
var current_dialogue_index = 0

func _ready():
	# Play idle animation
	if sprite:
		sprite.play("idle")
	
	# Hide dialogue panel initially
	if dialogue_panel:
		dialogue_panel.visible = false
	
	# Find the player in the scene tree
	call_deferred("find_player")

func find_player():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		# Try to find player by path as fallback
		var game_node = get_node_or_null("../../Player")
		if game_node:
			player = game_node

func _process(_delta):
	if not player:
		return
	
	# Check if player is near
	var distance = global_position.distance_to(player.global_position)
	var is_near = distance < INTERACTION_DISTANCE
	
	# Show dialogue when player is near and presses E
	if is_near and not is_dialogue_open:
		show_dialogue()
	elif not is_near and is_dialogue_open:
		hide_dialogue()

func show_dialogue():
	is_dialogue_open = true
	current_dialogue_index = 0
	if dialogue_panel:
		dialogue_panel.visible = true
	update_dialogue_text()

func hide_dialogue():
	is_dialogue_open = false
	if dialogue_panel:
		dialogue_panel.visible = false

func update_dialogue_text():
	if dialogue_label and current_dialogue_index < dialogue_lines.size():
		dialogue_label.text = dialogue_lines[current_dialogue_index]
