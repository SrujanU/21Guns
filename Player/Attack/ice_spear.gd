extends Area2D

var level = 1
var hp = 1

var damage = 5
var knock_amount = 100
var attack_size = 1.0


var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(360)
	match level:
		1:
			hp = 1
			Global.bullet_speed = 100
			damage = 5
			knock_amount = 100
			attack_size = 1.0
	var tween = create_tween()
	tween.tween_property(self, "scale",Vector2(1,1)*attack_size,1).set_trans(tween.TRANS_QUINT).set_ease(tween.EASE_OUT)
	tween.play()
			
func _physics_process(delta):
	sprite_2d.play("shot")
	position += angle*Global.bullet_speed*delta
		
func enemy_hit(charge = 1):
	hp -= charge
	
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
