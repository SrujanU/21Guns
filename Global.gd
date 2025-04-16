extends Node
var level = 1
var score = 0
var armor_set = 0
var gun_type = 0
var max_health = 80
var health = max_health
var player_exp = 0
var player_level = 1
var exp_thresholds = [0, 1000, 2000, 4000, 8000, 16000, 24000]
var coins = 0
var upgrades = []
var count := 0
var broker_count := 0
var movement_speed = 300 + 50*upgrades.count(1)
var bullet_speed = 420 + 100*upgrades.count(2)
var icespear_attackspeed = 1.5 - 0.5*upgrades.count(5)
var ammo = 100 + 30 * upgrades.count(6)
var cyclops_dead = false
var is_first_play:bool = true
var gun_clip = 10
#variable to store the most recent sum of coins awarded to the player. It's used to add reward appropriately given blackjack result after upgrade or if coins just kept.
var last_coin_reward = 0
#keeps track of most recently selected upgrade to dislay winnings if hand won.
var selected_upgrade = ""
var attack_power = 5 + 10*upgrades.count(0)
func _process(delta):
	movement_speed = 250 + 50*upgrades.count(1)
	
	bullet_speed = 420 + 100*upgrades.count(2)
	
	icespear_attackspeed = 1.0 - 0.5*upgrades.count(5)
	
	attack_power = 5 + 10*upgrades.count(0)
	

func reset_blackjack():
	count = 0
	broker_count = 0

func reset_game_state():
	score = 0
	health = 80
	coins = 0
	ammo = 100
	last_coin_reward = 0

func next_level():
	score = 0
	if armor_set == 0:
		health = 80
	elif armor_set == 1:
		health = 96
		max_health = 96
	
	
	
	level += 1
	last_coin_reward = 0
	
	
	
	 
