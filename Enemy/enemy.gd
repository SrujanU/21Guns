extends CharacterBody2D
const BASE_Z = 1000
@export var movement_speed = 45.0
@export var hp = 10
@onready var player = get_tree().get_first_node_in_group("player")

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

@onready var hit_box: Area2D = $HitBox
@onready var hurt_box: Area2D = $HurtBox

@onready var anim = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const ENEMY_EXP_GAIN = 500
var dying:bool = false



func _ready():
	dying = false
	
	sprite_2d.play("move")
func _physics_process(_delta):
	if dying:
		return
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()
	z_index = BASE_Z + position.y
	if direction.x > 0.1:
		sprite_2d.flip_h = false
	elif direction.x < -0.1:
		sprite_2d.flip_h = true
	


func _on_hurt_box_hurt(damage):
	hp -= damage
	
	if hp <= 0:
		
		die()
		
		
		
		
		Global.score += 1
		Global.player_exp += ENEMY_EXP_GAIN
	else:
		sprite_2d.play("hit")
		await sprite_2d.animation_finished
		sprite_2d.play("move")
		
		
func die():
	dying = true
	hit_box.monitoring = false
	hit_box.monitorable = false
	hurt_box.monitorable = false
	hurt_box.monitoring = false
	collision_shape_2d.set_deferred("disabled", true)
	hit_box.get_node("CollisionShape2D").set_deferred("disabled", true)
	print("should not hit")
	
	
	
	sprite_2d.play("die ")
	
	await sprite_2d.animation_finished
	print("death animation finished.")
	
	queue_free()
	
	
	
		


	
	
