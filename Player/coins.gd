extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_wealth()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_wealth()
	pass

func show_wealth():
	text = "Coins: " + str(Global.coins)
