extends "res://Enemy/enemy.gd"





const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _ready():
	super()
	
	movement_speed = 210
	hp = 15
	ENEMY_EXP_GAIN = 900
