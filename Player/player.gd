extends CharacterBody2D

var movement_speed = Global.movement_speed
const BASE_Z = 2000

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var armor_state:Dictionary = {
	0:["idle", "move", "shoot"],
	1:["iron_m_rig_idle", "iron_m_rig_move", "iron_m_rig_shoot"]}
#Attacks
var iceSpear = preload("res://Player/Attack/ice_spear.tscn")
var is_hit:bool = false
#Attack Nodes
@onready var iceSpearTimer = get_node("%IceSpearTimer")
@onready var iceSpearAttackTimer = get_node("%IceSpearAttackTimer")


#@onready var gun_barrel: Marker2D = $GunBarrel
@onready var gun_barrel: Marker2D = $GunBarrel
@onready var cooldown_bar: TextureProgressBar = $CooldownBar




#IceSpear
var icespear_ammo = Global.ammo
var icespear_baseammo = 1
var icespear_attackspeed = 1.5
var icespear_level = 1
@onready var gun: Sprite2D = $Gun


#Enemy Related
var enemy_close = []

@onready var sprite: AnimatedSprite2D = $Sprite2D

@onready var walkTimer = get_node("%walkTimer")

#zz: Player movement range boundaries
@export var top: float
@export var bottom: float
@export var left: float
@export var right: float

@export var background: NinePatchRect
@export var death_audio_stream_player: AudioStreamPlayer2D
var is_dead: bool = false


func _ready():
	#Global.gun_type = 1
	if Global.gun_type == 1:
		var tommy_gun_path = load("res://Textures/Items/Weapons/tommy_gun.png")
		gun.texture = tommy_gun_path
	var animations = ["hit", "idle", "move_left", "move_right", "shoot", "shoot_left"]
	#Global.armor_set = 1
	# Logic handling for armor 
	if Global.armor_set == 1:
		for animation_name in animations:
			var animation = animation_player.get_animation(animation_name)
	
			for i in range(animation.get_track_count()):
				var path = animation.track_get_path(i)
				if path.get_subname(0) == "animation" and path.get_name(0) == "Sprite2D":
					print(animation.track_get_key_value(0, i))
					if animation.track_get_key_value(0, i) == "hit":
						animation.track_set_key_value(i, 0, "hit")
					elif animation.track_get_key_value(0, i) == "move":
						animation.track_set_key_value(i, 0, "iron_m_rig_move")
					elif animation.track_get_key_value(0, i) == "idle":
						animation.track_set_key_value(i, 0, "iron_m_rig_idle")
					
					else:
						animation.track_set_key_value(i, 0, "iron_m_rig_shoot")
	#attack()
	pass
var gun_cooldown:bool = false
func _physics_process(delta):
	#animation_player.set_key()
	# New Shooting Mechanics: arrow keys used to shoot in 4 directions  vertically and horizontally
	var gun_position = gun.position
	if Input.is_action_just_pressed("shoot_left") and not gun_cooldown and icespear_ammo > 0:
		#sprite.play("shoot")
		
		animation_player.play("shoot_left")
		#gun.rotate(-1.57)
		#gun.position = gun_barrel.position
		var icespear_attack = iceSpear.instantiate()
		
		icespear_attack.position = gun_barrel.global_position
		
		icespear_attack.target = Vector2(self.global_position[0]-420, self.global_position[1])
		icespear_attack.level = icespear_level
		
		add_child(icespear_attack)
		icespear_ammo -= 1
		
		iceSpearAttackTimer.wait_time = Global.icespear_attackspeed
		if Global.gun_type == 0:
			iceSpearAttackTimer.start()
			gun_cooldown = true
		
			cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		elif Global.gun_type == 1:
			Global.gun_clip -= 1
			if Global.gun_clip == 0:
				iceSpearAttackTimer.start()
				gun_cooldown = true
		
				cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		#gun.position = gun_position
		#gun.rotate(1.57)
			
	if Input.is_action_just_pressed("shoot_right") and not gun_cooldown and icespear_ammo > 0:
		animation_player.play("shoot")
		#sprite.play("shoot")
		#gun.rotate(-1.57)
		#gun.position = gun_barrel.position
		var icespear_attack = iceSpear.instantiate()
		icespear_attack.position = gun_barrel.global_position
		icespear_attack.target = Vector2(self.global_position[0]+420, self.global_position[1])
		icespear_attack.level = icespear_level
		
		add_child(icespear_attack)
		icespear_ammo -= 1
		
		
		
		iceSpearAttackTimer.wait_time = Global.icespear_attackspeed
		if Global.gun_type == 0:
			iceSpearAttackTimer.start()
			gun_cooldown = true
		
			cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		elif Global.gun_type == 1:
			Global.gun_clip -= 1
			if Global.gun_clip == 0:
				iceSpearAttackTimer.start()
				gun_cooldown = true
		
				cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		#gun.position = gun_position
		#gun.rotate(1.57)
	
	if Input.is_action_just_pressed("shoot_up") and not gun_cooldown and icespear_ammo > 0:
		if sprite.flip_h:
			animation_player.play("shoot_left")
		else:
			animation_player.play("shoot")
		#gun.rotate(-1.57)
		#gun.position = gun_barrel.position
		var icespear_attack = iceSpear.instantiate()
		icespear_attack.position = gun_barrel.global_position
		icespear_attack.target = Vector2(self.global_position[0], self.global_position[1] - 269)
		icespear_attack.level = icespear_level
		
		add_child(icespear_attack)
		icespear_ammo -= 1
		
		iceSpearAttackTimer.wait_time = Global.icespear_attackspeed
		if Global.gun_type == 0:
			iceSpearAttackTimer.start()
			gun_cooldown = true
		
			cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		elif Global.gun_type == 1:
			Global.gun_clip -= 1
			if Global.gun_clip == 0:
				iceSpearAttackTimer.start()
				gun_cooldown = true
		
				cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		#gun.position = gun_position
		#gun.rotate(1.57)
			
	if Input.is_action_just_pressed("shoot_down") and not gun_cooldown and icespear_ammo > 0:
		#sprite.play("shoot")
		#gun.rotate(-1.57)
		
		#gun.position = gun_barrel.position
		if sprite.flip_h:
			animation_player.play("shoot_left")
		else:
			animation_player.play("shoot")
		var icespear_attack = iceSpear.instantiate()
		icespear_attack.position = gun_barrel.global_position
		icespear_attack.target = Vector2(self.global_position[0], self.global_position[1]+269)
		icespear_attack.level = icespear_level
		
		add_child(icespear_attack)
		icespear_ammo -= 1
		
			
		iceSpearAttackTimer.wait_time = Global.icespear_attackspeed
		if Global.gun_type == 0:
			iceSpearAttackTimer.start()
			gun_cooldown = true
		
			cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
		elif Global.gun_type == 1:
			Global.gun_clip -= 1
			if Global.gun_clip == 0:
				iceSpearAttackTimer.start()
				gun_cooldown = true
		
				cooldown_bar.set_cooldown_bar(iceSpearAttackTimer.wait_time)
			
				
				
				
		#gun.position = gun_position
		#gun.rotate(1.57)
		
	movement()
		
		
		
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	#z index handling for 2.5D
	z_index = BASE_Z + position.y
	if !animation_player.is_playing() or (animation_player.current_animation != "shoot" and animation_player.current_animation != "shoot_left" and animation_player.current_animation != "hit"):
		if mov.x < 0:
			animation_player.play("move_left")
			
		#sprite.flip_h = true
		#gun_barrel.position.x = abs(gun_barrel.position.x)
		#gun.flip_v = true
		#gun.position.x = abs(gun.position.x)
		elif mov.x > 0:
		#sprite.flip_h = false
			animation_player.play("move_right")
		#gun_barrel.position.x = -abs(gun_barrel.position.x)
		#gun.flip_v = false
		#gun.position.x = -abs(gun.position.x)
		
		
		elif mov != Vector2.ZERO:
		
			if walkTimer.is_stopped():
			
				animation_player.play("move_right")
				#walkTimer.start()
		else:
			animation_player.play("idle")
		#sprite.play("idle") #idle
	
	velocity = mov.normalized()*Global.movement_speed
	move_and_slide()
	global_position.x = clampf(global_position.x, left, right)
	global_position.y = clampf(global_position.y, top, bottom)
	
			
		
	

func attack():
	#function that kicks off attack cycle using timers
	if icespear_level > 0:
		iceSpearTimer.wait_time = icespear_attackspeed
		if iceSpearTimer.is_stopped():
			iceSpearTimer.start()

func _on_hurt_box_hurt(damage):
	if is_dead:
		
		return
	Global.health -= damage
	
	#sprite.play("hit")
	animation_player.play("hit")
	
	## TODO zz: Just go ahead and put the character death sound effect here.
	if Global.health <= 0:
		death_audio_stream_player.play()
		Global.reset_game_state()
		#print("Current scene:" + str(get_tree().))
		print(get_tree().current_scene)
		print("Packed scene if working:" + str(get_tree().reload_current_scene()))
		
		
		is_dead = true
	
	
	print(Global.health)


func _on_ice_spear_timer_timeout():
	icespear_ammo += icespear_baseammo
	iceSpearAttackTimer.start()

# function that controls gun cooldown. Gun cannot be shot again while timer is running.
func _on_ice_spear_attack_timer_timeout():
	'''if icespear_ammo > 0:
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
			iceSpearAttackTimer.stop()'''
	cooldown_bar.hide()
	if icespear_ammo > 0:
		gun_cooldown = false
	if Global.gun_type == 1:
		if Global.gun_clip == 0:
			Global.gun_clip = 10
			print("Gun clip " + str(Global.gun_clip))
		
func get_random_target():
	if enemy_close.size() > 0:
		print(enemy_close.pick_random().global_position)
		#find enemy with the min distance to player
		# enemy_close contains instances of enemy
		
		var min_distance = get_distance(self.global_position, enemy_close[0].global_position)
		var closest_index = 0
		
		for i in range(len(enemy_close)):
			if get_distance(self.global_position, enemy_close[i].global_position) <= min_distance:
				closest_index = i
			
			
				
		return enemy_close[closest_index].global_position
		#return enemy_close.pick_random().global_position
		
		
	else:
		return Vector2.UP
		


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)

func get_distance(player_position, enemy_position):
	return player_position.distance_to(enemy_position)

#end of level 1
func level_end():
	#score == 30
	pass
	
		
