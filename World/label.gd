extends Node2D

@onready var kill_label = $Label
@onready var player = get_node("/root/World/Player")  # Adjust the path if necessary

func _ready():
	kill_label.add_theme_font_size_override("font_size", 30)  # Set font size
	kill_label.set_position(Vector2(20, 20))  # Initial UI position

func _process(_delta):
	if player:
		# Set the label's position relative to the player's position
		kill_label.position = player.global_position + Vector2(50, -100)
	
	# Update kill count text
	kill_label.text = "Kills: " + str(GameManager.kill_count)
