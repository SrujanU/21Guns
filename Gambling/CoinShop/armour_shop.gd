extends Node2D

var armor_items = ["iron_marshals_rig", "nova_trailblazer", "doomriders_onslaught", "sundown_armor"]

@onready var buy_sound: AudioStreamPlayer2D = $BuySound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#for button in get_tree().get_nodes_in_group("buy_buttons"):
	#	if button.button_pressed:
	#		button.text = "SOLD"
			
		
	pass




func _on_iron_rig_button_pressed() -> void:
	if Global.coins >= 200:
		
		Global.coins -= 200
		Global.armor_set = 1
		buy_sound.play()
	else:
		
		print("Insufficient Funds.")
	

func _on_nova_button_pressed() -> void:
	if Global.coins >= 300:
		buy_sound.play()
		Global.armor_set = 2
		
	else:
		print("Insufficient Funds.")



func _on_doomrider_button_pressed() -> void:
	if Global.coins >= 450:
		buy_sound.play()
		Global.armor_set = 3
	else:
		print("Insufficient Funds.")



func _on_sundown_button_pressed() -> void:
	
	if Global.coins >= 600:
		buy_sound.play()
		Global.armor_set = 4
	else:
		print("Insufficient Funds.")
