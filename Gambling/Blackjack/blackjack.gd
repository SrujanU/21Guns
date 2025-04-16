extends Node2D

class_name Blackjack
var bet

var prev_scene

@onready var backtogame: Button = $Window/Backtogame

var card = preload("res://Gambling/Blackjack/card.tscn")
var rank := ["A", "2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K"]

#H <- hearts, D <- diamonds, P <- spades, C <- clubs
var suit := ["H", "D", "P", "C"]
var cards := []
var current_card := 1
var current_card_x := 30.0
var current_card_y := 250.0
var current_card_broker_x := 120
#var current_card_broker_y = 70
var cards_broker := []

#@onready var animation_player: AnimationPlayer = $Window/AnimationPlayer
@onready var result: Label = $Window/Result
@onready var upgrade_won: Label = $Window/UpgradeWon
@onready var final_score: Label = $Window/FinalScore


#animation_player.get_animation("Default").loop_mode = LOOP_LINEAR
func create_deck():
	var x:= 1.0
	var y := 1.0
	randomize()
	rank.shuffle()
	suit.shuffle()
	print(suit)
	print(rank)
	for s in suit:
		for r in rank:
			var _card = card.instantiate()
			_card.suit = s
			_card.rank = r
			if r in "23456789":
				_card.value = int(r)
			elif r == "A":
				_card.value = 1
			elif r in "JKQ":
				_card.value = 10
			#_card.position.x = x
			#_card.position.y = y
			#y += 2.0
			cards.append(_card)
			
	
	
	print(cards)
	if Global.is_first_play:
		rig_deck_for_win()
		Global.is_first_play = false
	else:
		
		cards.shuffle()
	for _card in cards:
		_card.position.x = x
		_card.position.y = y
		y += 2.0
		call_deferred("add_child", _card)
		
func rig_deck_for_win():
	# First, shuffle the cards to randomize them
	cards.shuffle()
	
	# Find some good cards for player (values that add up to 20 or 21)
	var player_cards = []
	var dealer_cards = []
	
	# Find a 10-value card and a face card for player (total 20)
	for i in range(cards.size()):
		if cards[i].value == 10 and player_cards.size() < 1:
			player_cards.append(cards[i])
		elif cards[i].value == 10 and player_cards.size() < 2:
			player_cards.append(cards[i])
			break
	
	# Find cards for dealer that won't beat 20 (like a 9 and a 6 = 15)
	for i in range(cards.size()):
		if cards[i] not in player_cards:
			if cards[i].value < 10 and dealer_cards.size() < 1:
				dealer_cards.append(cards[i])
			elif cards[i].value < 10 and dealer_cards.size() < 2:
				dealer_cards.append(cards[i])
				break
	
	# Rearrange the deck to place these cards at the right positions from the end
	# The last 4 cards drawn will be in this order: player, player, dealer, dealer
	
	# Remove the selected cards from the deck
	for c in player_cards + dealer_cards:
		cards.erase(c)
	
	# Add them back at the end in the right order so they'll be drawn correctly
	# Since we draw from the end, dealer's second card should be last
	cards.append(dealer_cards[1])  # Dealer's face-down card
	cards.append(dealer_cards[0])  # Dealer's first card
	cards.append(player_cards[1])  # Player's second card
	cards.append(player_cards[0])  # Player's first card
	
	print("Deck rigged for first-time win!")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Window.visible = false
	$Music.play()
	await get_tree().create_timer(1.5).timeout
	print("starting blackjack game for upgrade.")
	create_deck()
	$Hit.visible = false
	$Stand.visible = false
	
	
	# timeout to process card collection and prevent index error
	
	
	await get_tree().create_timer(2.0).timeout
	
	
	add_card_player_start()
	await get_tree().create_timer(1.0).timeout
	add_card_player_start()
	await get_tree().create_timer(1.0).timeout
	add_card_broker()
	await get_tree().create_timer(1.0).timeout
	
	add_card_broker(true)
	print(get_tree().get_nodes_in_group("cards"))
	get_tree().create_timer(1.0)
	
	$Hit.visible = true
	$Stand.visible = true
	
	
func btn():
	$Hit.disabled = true
	$Stand.disabled = true

func print_result():
	var result_text = "You: %s\nDealer: %s" % [Global.count, Global.broker_count]
	return result_text
func check_count():
	#checks if player busts
	if Global.count > 21:
		lose()
		

@onready var upgrade_sound: AudioStreamPlayer2D = $UpgradeSound
@onready var animation_player: AnimationPlayer = $Window/AnimationPlayer


func win():
	
	$Music.stop()
	flip_end_game()
	$Hit.visible = false
	$Stand.visible = false
	var result = $Window.get_child(1)
	$Window/ColorRect.set_color(Color("#7503a5"))
	btn()
	$Window.visible = true
	
	backtogame.pressed.connect(_on_backtogame_pressed)
	result.text = "YOU WIN!" 
	final_score.text = print_result()
	result.add_theme_color_override("font_color", Color("#00f700"))
	$SoundWin.play()
	animation_player.get_animation("Default").set_loop_mode(Animation.LOOP_LINEAR)
	animation_player.play("Default")
	await get_tree().create_timer(2.0).timeout
	upgrade_won.add_theme_color_override("font_color", Color("#00f700"))
	upgrade_sound.play()
	upgrade_won.text = str(Global.selected_upgrade) 

	
	print(bet)
	#add upgrade logic here and in lose and draw
	#await get_tree().create_timer(3.0).timeout
	# check if upgrade at stake is a coin multiplier or ammo
	if Global.upgrades[-1] == 3:
		#Player won 2x the coins rewarded for leveling up
		Global.coins += 2 * Global.last_coin_reward
		print(Global.last_coin_reward)
	elif Global.upgrades[-1] == 4:
		#Player won 1.5x reward
		Global.coins += 1.5 * Global.last_coin_reward
	
	else:
		#Player won an upgrade that is not a coins multiplier, so they just keep the original reward and the upgrade added is kept
		Global.coins += Global.last_coin_reward
	
	if Global.upgrades[-1] == 6:
		get_tree().get_nodes_in_group("player")[0].icespear_ammo += 45
		
	
	
	

func lose():
	
	$Music.stop()
	flip_end_game()
	$Hit.visible = false
	$Stand.visible = false
	var result = $Window.get_child(1)
	$Window/ColorRect.set_color(Color("#000000"))
	btn()
	$Window.visible = true
	backtogame.pressed.connect(_on_backtogame_pressed)
	#result.text = "   YOU LOSE!\n" + print_result() + "\nNo upgrade:("
	result.text = "YOU LOSE!" 
	final_score.text = print_result()
	result.add_theme_color_override("font_color", Color("#fc0300"))
	upgrade_won.text = "NO UPGRADE :("
	Global.upgrades.pop_back()
	#animation_player.play("Default")
	animation_player.get_animation("Default").set_loop_mode(Animation.LOOP_LINEAR)
	animation_player.play("Default")
	$SoundLose.play()
	
	
	
	

func draw():
	$Music.stop()
	flip_end_game()
	$Hit.visible = false
	$Stand.visible = false
	var result = $Window.get_child(1)
	btn()
	print(bet)
	$Window/ColorRect.set_color(Color("#000000"))
	result.text = "DRAW."
	$Window.visible = true
	backtogame.pressed.connect(_on_backtogame_pressed)
	#result.text = "   DRAW\n" + print_result() + "\nNo upgrade:("
	 
	final_score.text = print_result()
	result.add_theme_color_override("font_color", Color("#ffffff"))
	upgrade_won.text = "NO UPGRADE :("
	#In a draw, the player gets to keep their coins, but gains no upgrade
	Global.coins += Global.last_coin_reward
	
	#animation_player.play("Default")
	Global.upgrades.pop_back()
	
	
	
	
	
	
	
	
#determine game result based on hands
func check_count_pass():
	check_count()
	if Global.count == 21:
		win()
	elif Global.broker_count > 21:
		win()
	elif Global.broker_count == Global.count:
		draw()
	elif Global.broker_count < Global.count:
		win()
	elif Global.broker_count > Global.count:
		lose()
		

func add_card_player_start():
	
	#var deck = get_tree().get_nodes_in_group("cards")
	var last_card = cards[len(cards)-current_card]
	current_card += 1
	current_card_x += 66.0
	last_card.set_position(Vector2(current_card_x, current_card_y))
	last_card.facedown = false
	$SoundCard.play()
	Global.count += last_card.value
	$PlayerCount.text = "You: %s" % Global.count
	
	

func add_card_player():
	add_card_player_start()
	check_count()

func add_card_broker(_facedown = false):
	
	#var deck = get_tree().get_nodes_in_group("cards")
	var last_card = cards[len(cards)-current_card]
	cards_broker.append(last_card)
	current_card += 1
	current_card_broker_x += 66.0
	last_card.set_position(Vector2(current_card_broker_x, 50.0))
	if not _facedown:
		last_card.facedown = false
	
	$SoundCard.play()
	Global.broker_count += last_card.value
	if _facedown:
		var broker_score = Global.broker_count - last_card.value
		$BrokerCount.text = "Dealer:%s" % broker_score
	else:
		$BrokerCount.text = "Dealer:%s" % Global.broker_count



func _on_stand_pressed() -> void:
	#reveal hole card
	flip_end_game()
	cards_broker[0].facedown = false
	$BrokerCount.text = "Dealer:%s" % Global.broker_count
	await get_tree().create_timer(0.5).timeout
	cards_broker[1].facedown = false
	#dealer draws until count is greater than 17.
	while Global.broker_count < 17:
		
		await get_tree().create_timer(1.0).timeout
		var deck = get_tree().get_nodes_in_group("cards")
		var last_card = cards[len(cards)-current_card]
		
		add_card_broker()
			
		
	check_count_pass()
		
	
func _on_hit_pressed() -> void:
	add_card_player()
	

# flip unflipped cards (if any) upon game result
func flip_end_game():
	for c in cards_broker:
		if c.facedown:
			$SoundCard.play()
			c.facedown = false
			

func _on_backtogame_pressed():
	#unpause the tree and allow the world scene to process again
	
	#make world scene visible
	get_parent().get_child(1).visible = true
	
	#reset hand count for next game
	Global.reset_blackjack()
	#free the blackjack scene from the tree
	$".".visible = false
	$Window.visible = false
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = false
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
