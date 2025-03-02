extends CharacterBody2D


const BASE_Z = 1000




#Attacks
var iceSpear = preload("res://Player/Attack/ice_spear.tscn")
var is_hit:bool = false
#Attack Nodes
@onready var iceSpearTimer = get_node("%IceSpearTimer")
@onready var iceSpearAttackTimer = get_node("%IceSpearAttackTimer")
@onready var gun_barrel: Marker2D = $GunBarrel
#IceSpear
var icespear_ammo = 0
#var icespear_baseammo = 1
var icespear_attackspeed = Global.icespear_attackspeed
var icespear_level = 1

#Enemy Related
var enemy_close = []

@onready var sprite: AnimatedSprite2D = $Sprite2D

@onready var walkTimer = get_node("%walkTimer")

func _ready():
	attack()

func _physics_process(delta):
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	#z index handling for 2.5D
	z_index = BASE_Z + position.y
	if mov.x < 0:
		sprite.flip_h = true
		gun_barrel.position.x = -abs(gun_barrel.position.x)
	elif mov.x > 0:
		sprite.flip_h = false
		gun_barrel.position.x = abs(gun_barrel.position.x)
	if mov != Vector2.ZERO:
		
		if walkTimer.is_stopped():
			
			sprite.play("move")
			walkTimer.start()
	else:
		sprite.play("idle")
	
	velocity = mov.normalized()*Global.movement_speed
	move_and_slide()

func attack():
	
	if icespear_level > 0:
		iceSpearTimer.wait_time = icespear_attackspeed
		if iceSpearTimer.is_stopped():
			iceSpearTimer.start()

func _on_hurt_box_hurt(damage):
	Global.health -= damage
	
	sprite.play("hit")
	
	
	
	
	
	print(Global.health)


func _on_ice_spear_timer_timeout():
	icespear_ammo += Global.ammo
	iceSpearAttackTimer.start()


func _on_ice_spear_attack_timer_timeout():
	if icespear_ammo > 0:
		sprite.play("shoot")
		var icespear_attack = iceSpear.instantiate()
		icespear_attack.position = gun_barrel.global_position
		icespear_attack.target = get_random_target()
		icespear_attack.level = icespear_level
		
		add_child(icespear_attack)
		icespear_ammo -= 1
		if icespear_ammo > 0:
			iceSpearAttackTimer.start()
		else:
			iceSpearAttackTimer.stop()
		
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP
		


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
