extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_balance()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_balance()

func update_balance():
	text = str(Global.coins)
	
