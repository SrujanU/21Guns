extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_coin_reward()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_coin_reward()
	

func update_coin_reward():
	text = "+ " + str(Global.exp_thresholds[Global.player_level]/10) + " Coins!"
