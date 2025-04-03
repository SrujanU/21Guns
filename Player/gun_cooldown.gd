extends TextureProgressBar
var is_active = false
var tween:Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hide()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not is_active and visible:
		hide()
		
	
		
func set_cooldown_bar(duration):
	var timer = get_parent().get_node("%IceSpearAttackTimer")
	
	value = 0
	#max_value = duration
	show()
	is_active = true
	#$".".value = value
	
	if tween:
		tween.kill() # Stop any existing tween
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "value", 100, duration)
	tween.tween_callback(hide)
	
	
	
