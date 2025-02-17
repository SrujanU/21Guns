extends CanvasLayer

@onready var kill_label = $KillCounterLabel  # Adjust based on your node hierarchy

func _process(_delta):
	kill_label.text = "Kills: " + str(GameManager.kill_count)
