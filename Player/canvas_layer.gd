extends CanvasLayer


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Level1Tutorial/AudioStreamPlayer2D

func _ready() -> void:
	#$".".hide()
	$levelup_screen/KeepCoins.pressed.connect(_on_keep_coins_pressed)
	for button in get_tree().get_nodes_in_group("bet_buttons"):
		button.pressed.connect(_on_bet_button_pressed.bind(button))
	level_1_tutorial.hide()
	
		
	
	
	
	
	

	
	
var level_path = "res://Gambling/Blackjack/blackjack.tscn"

@onready var level_1_tutorial: CanvasLayer = $Level1Tutorial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		#await get_tree().create_timer(1.5).timeout
		print("level up")
		Global.player_exp -= Global.exp_thresholds[Global.player_level]
		Global.player_level += 1
		
		#Save the coins rewarded upon level up as global variable and add them depending on game result 
		Global.last_coin_reward = Global.exp_thresholds[Global.player_level]/10
		print(Global.last_coin_reward)
		print("$" + str(Global.coins))
		$AudioStreamPlayer2D.play()
		#if Global.player_level != previous_level:
			#previous_level = Global.player_level  # Update stored level
			#_on_visibility_changed()  # Call function when level changes
		$".".show()
		for coin in get_tree().get_nodes_in_group("coins"):
			coin.queue_free()
		get_parent()
		get_tree().paused = true
		
	

func _on_bet_button_pressed(button):
	
	if level_path == null:
		print("Blackjack scene not found.")
		return
	
	var packed_scene = load(level_path)
	
	print("blackjack time")
	print(level_path)
	
	print(button.bet_value)
	Global.upgrades.append(button.bet_value)
	Global.selected_upgrade = get_upgrade_text(button.bet_value)
	print(Global.upgrades)
	$".".hide()
	
	
	
	
	#create instanc eof blackjack scene
	var blackjack_scene = packed_scene.instantiate()
	#set world scene to process only when scene_tree is not paused
	get_parent().set_process_mode(1)
	#set blackjack_scene to only process when scene tree is paused
	blackjack_scene.set_process_mode(2)
	#add blackjack scene as child of main node
	get_parent().get_parent().add_child(blackjack_scene)
	
	
	#hide world scene
	get_parent().visible = false
	#set correct position of blackjack scene
	blackjack_scene.position = Vector2(get_parent().get_child(3).position.x - 315, get_parent().get_child(3).position.y - 175)
	#show blackjack scene
	blackjack_scene.visible = true
	
	
	
	
	
	
	
func _on_keep_coins_pressed():
	hide()
	#player keeps the coin reward
	Global.coins += Global.last_coin_reward
	get_tree().paused = false
#adding upgrade functionality to menu and blackjack 
var previous_level: int = 0
var rand_upgrade1 = randi() % 6


	
func get_upgrade_text(upgrade_id):
	match upgrade_id:
		0: return "Attack Power +"
		1: return "Movement Speed +"
		2: return "Bullet Velocity +"
		3: return "2x Coins"
		4: return "1.5x Coins"
		5: return "Cooldown -"
		6: return "Ammo +"



func _on_visibility_changed() -> void:
	if self.visible == false:
		return
	var button_no = 0
	var seen = [false, false, false, false, false, false, false]
	for label in get_tree().get_nodes_in_group("bet_labels"):
		
		rand_upgrade1 = randi() % 7
		while seen[rand_upgrade1]:
			rand_upgrade1 = randi() % 7
		label.text = get_upgrade_text(rand_upgrade1)
		seen[rand_upgrade1] = true
		
		#save upgrade_id as attribute of button so that correct upgrade is added
		get_tree().get_nodes_in_group("bet_buttons")[button_no].bet_value = rand_upgrade1
		
		print(get_tree().get_nodes_in_group("bet_buttons")[button_no].bet_value)
		button_no += 1
	
	#After menu construction, display the tutorial if first upgrade
	if Global.player_level == 2:
		await get_tree().create_timer(1.80).timeout
		
		level_1_tutorial.show()
		audio_stream_player_2d.play()
		
		
		
		
		

		
		
		
		
		
	
	

	
	
