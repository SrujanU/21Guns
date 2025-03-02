extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()
	$levelup_screen/KeepCoins.pressed.connect(_on_keep_coins_pressed)
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		print("wow")
		Global.player_exp -= Global.exp_thresholds[Global.player_level]
		Global.player_level += 1
		var reward = Global.exp_thresholds[Global.player_level]/10
		Global.coins += reward
		print("$" + str(Global.coins))
		$".".show()
		get_tree().paused = true
	

func _on_keep_coins_pressed():
	hide()
	get_tree().paused = false
