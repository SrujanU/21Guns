extends Node

var score = 0

var max_health = 80
var health = max_health
var player_exp = 0
var player_level = 1
var exp_thresholds = [0, 1000, 2000, 4000, 8000, 16000, 24000]
var coins = 0
var upgrades = []
var count := 0
var broker_count := 0
var movement_speed = 150 + 15*upgrades.count(1)
var bullet_speed = 200 + 75*upgrades.count(2)
#var icespear_attackspeed = 3 - 0.5*upgrades.count(2)
var ammo = 1
#variable to store the most recent sum of coins awarded to the player. It's used to add reward appropriately given blackjack result after upgrade or if coins just kept.
var last_coin_reward = 0
#keeps track of most recently selected upgrade to dislay winnings if hand won.
var selected_upgrade = ""
var attack_power = 5 + 2*upgrades.count(0)
func _process(delta):
	movement_speed = 150 + 15*upgrades.count(1)
	#print("movement speed: " + str(movement_speed))
	bullet_speed = 250 + 75*upgrades.count(2)
	#print("bullet speed: " +str(bullet_speed))
	#icespear_attackspeed = 3 - 0.5*upgrades.count(2)
	#print("attack speed: " + str(icespear_attackspeed))
	attack_power = 5 + 5*upgrades.count(0)
	#print("attack power: " + str(attack_power))
	
	#print(upgrades)

func reset_blackjack():
	count = 0
	broker_count = 0
	
	 
