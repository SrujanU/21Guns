extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_bullet_speed_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_bullet_speed_bar()
	
func update_bullet_speed_bar():
	$".".value = Global.bullet_speed
	$".".max_value = 1200
