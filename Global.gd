extends Node

var score = 0

var max_health = 80
var health = max_health
var player_exp = 0
var player_level = 1
var exp_thresholds = [0, 1000, 2000, 4000, 8000, 16000, 24000]
var coins = 0
var upgrades = []
var movement_speed = 65.0
var bullet_speed = 100
var icespear_attackspeed = 3
var ammo = 1


func _process(delta):
	movement_speed = 65.0 + 10*upgrades.count(1)
	bullet_speed = 100 + 100*upgrades.count(3)
	icespear_attackspeed = 3 - 0.5*upgrades.count(2)
	ammo = 1 + upgrades.count(0)
