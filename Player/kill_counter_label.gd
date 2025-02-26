extends Label

@onready var player = get_node("/root/World/Player")  # Adjust path if needed

func _process(_delta):
	if player:
		position = player.global_position + Vector2(50, -100)  # Offset to keep it above the player
