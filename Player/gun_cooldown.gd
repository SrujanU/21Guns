extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$".".hide()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $".".visible:
		var timer = get_parent().get_node("%IceSpearAttackTimer")
		if timer.time_left >= 0:
			
			set_cooldown_bar(timer.wait_time - timer.time_left, timer.wait_time)
	else:
		$".".hide()
	
		
func set_cooldown_bar(value, max_value):
	
	$".".max_value = max_value
	$".".show()
	$".".value = value
	
	
