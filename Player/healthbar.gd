extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".max_value = Global.max_health
	$".".value = Global.max_health
	set_health_bar()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_health_bar()
	
	

func set_health_bar():
	$".".max_value = Global.max_health
	$".".value = Global.health
	
