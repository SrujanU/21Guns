extends TextureProgressBar
@onready var levelup_screen: CanvasLayer = %levelup_screen
var tween:Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	update_exp_bar()
	print(Global.player_exp)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	update_exp_bar()
	

func gain_exp(amount: int):
	Global.player_exp += amount
	
	update_exp_bar()

func update_exp_bar():
	
	#$".".value = Global.player_exp
	
	if tween:
		tween.kill()
	var tween = get_tree().create_tween()
	if Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		tween.tween_property(self, "fill_mode", 0, 0.25)
		await tween.finished
		
		value = 0
		max_value = Global.exp_thresholds[Global.player_level]
		
	else:
		self.max_value = Global.exp_thresholds[Global.player_level]
		tween.tween_property(self, "value", Global.player_exp, 0.5)
	
	
func reset_for_level_up():
	value = Global.player_exp
	max_value = Global.exp_thresholds[Global.player_level]
	





		
	
		
		
		
		
		
	
		
		
		
		
	
	
