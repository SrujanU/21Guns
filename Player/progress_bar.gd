extends TextureProgressBar
@onready var levelup_screen: CanvasLayer = %levelup_screen

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
	$".".max_value = Global.exp_thresholds[Global.player_level]
	$".".value = Global.player_exp
	






		
	
		
		
		
		
		
	
		
		
		
		
	
	
