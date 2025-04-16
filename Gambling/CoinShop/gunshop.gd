extends Node2D
@onready var buy_sound: AudioStreamPlayer2D = $BuySound

#var buttons = get_tree().get_nodes_in_group("buy_buttons")
var gun1_bought = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("gunshop")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("gunshop" + str(self.process_mode))
	


func _on_spitter_button_pressed() -> void:
	if Global.coins >= 300:
		
		Global.coins -= 300
		Global.gun_type = 1
		buy_sound.play()
	else:
		
		print("Insufficient Funds.")


func _on_meteor_button_pressed() -> void:
	if Global.coins >= 900:
		
		Global.coins -= 900
		Global.gun_type = 2
		buy_sound.play()
	else:
		
		print("Insufficient Funds.")




func _on_piercer_button_pressed() -> void:
	if Global.coins >= 1000:
		
		Global.coins -= 1000
		Global.gun_type = 3
		buy_sound.play()
	else:
		
		print("Insufficient Funds.")
	



func _on_ammo_button_pressed() -> void:
	if Global.coins >= 400:
		Global.ammo += 300
		Global.coins -= 400
		buy_sound.play()
	else:
		print("Insufficient Funds.")
	
	
