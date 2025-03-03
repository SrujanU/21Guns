extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()
	$levelup_screen/KeepCoins.pressed.connect(_on_keep_coins_pressed)
	for button in get_tree().get_nodes_in_group("bet_buttons"):
		button.pressed.connect(_on_bet_button_pressed.bind(button))
	
		
	
	
	
	
	
	
	
var level_path = "res://Gambling/Blackjack/blackjack.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		print("wow")
		Global.player_exp -= Global.exp_thresholds[Global.player_level]
		Global.player_level += 1
		var reward = Global.exp_thresholds[Global.player_level]/10
		Global.coins += reward
		print("$" + str(Global.coins))
		$AudioStreamPlayer2D.play()
		if Global.player_level != previous_level:
			previous_level = Global.player_level  # Update stored level
			_on_visibility_changed()  # Call function when level changes
		$".".show()
		
		get_tree().paused = true
	

func _on_bet_button_pressed(button):
	
	if level_path == null:
		print("Blackjack scene not found.")
		return
	var packed_scene = load(level_path)
	var blackjack_scene = preload("res://Gambling/Blackjack/blackjack.tscn").instantiate()
	print("blackjack time")
	print(level_path)
	print(blackjack_scene)
	get_tree().paused = false
	Global.upgrades.append(rand_upgrade1)
	print(Global.upgrades)
	hide()
	blackjack_scene.prev_scene = self
	blackjack_scene.bet = button.bet_value
	
	
	
	
	print(get_tree().change_scene_to_packed(packed_scene))
	
	
	
	
	
func _on_keep_coins_pressed():
	hide()
	
	get_tree().paused = false
#adding upgrade functionality to menu and blackjack 
var previous_level: int = 0
var rand_upgrade1 = randi() % 6


	
func get_upgrade_text(upgrade_id):
	match upgrade_id:
		0: return "Attack Power +"
		1: return "Movement Speed +"
		2: return "Cooldown -"
		3: return "Bullet Velocity +"
		4: return "2x Coins"
		5: return "1.5x Coins"


func _on_visibility_changed() -> void:
	var button_no = 0
	for label in $".".get_tree().get_nodes_in_group("bet_labels"):
		
		rand_upgrade1 = randi() % 6
		label.text = get_upgrade_text(rand_upgrade1)
		get_tree().get_nodes_in_group("bet_buttons")[button_no].bet_value = get_upgrade_text(rand_upgrade1)
		button_no += 1
		
		
		
	
	

	
	
