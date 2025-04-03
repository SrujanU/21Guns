extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ammo_label()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_ammo_label()

func update_ammo_label():
	text = str(get_parent().get_parent().icespear_ammo)
	
