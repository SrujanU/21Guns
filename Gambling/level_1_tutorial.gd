extends CanvasLayer


#tutorial screen will have three pages explaining the system upon the first level up. 
#ok button will transition screens. using the tutorial_screen variable, we can just check when we are on the last page, and if the button is pressed again, we will just close the tutorial entirely.


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

func _ready() -> void:
	$Button.pressed.connect(_on_ok_button_pressed)
	self.visible == false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

var tutorial_screen = 0
var texture_paths = ["res://Gambling/sprites/level1_cutscene_0.png", 
"res://Gambling/sprites/level1_cutscene_1.png", 
"res://Gambling/sprites/level1_cutscene_2.png"]
var tutorial_texts = ["Level Up! You've reached level 2.\nYou win 200 coins!", 
"Gamble these coins in Blackjack\nfor upgrades and more.", 
"Or keep your coins for later."]
func _on_visibility_changed() -> void:
	
	if tutorial_screen != 0:
		return
	#show first screen of tutorial
	sprite_2d.texture = load(texture_paths[tutorial_screen])
	label.text = tutorial_texts[tutorial_screen]
	
	
	

func _on_ok_button_pressed():
	tutorial_screen += 1
	if tutorial_screen == 3:
		$".".visible = false
		return
	sprite_2d.texture = load(texture_paths[tutorial_screen])
	label.text = tutorial_texts[tutorial_screen]
	
	
	
		

	
	
	
	
	
