extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	update_attackp_bar()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_attackp_bar()

func update_attackp_bar():
	$".".value = Global.attack_power
	$".".max_value = 35
	
	
