extends "res://Player/Attack/ice_spear.gd"


# Called when the node enters the scene tree for the first time.
#signal hurt(damage)
func _ready() -> void:
	super()
	speed = 500
	#damage = 10
	target = get_tree().get_first_node_in_group("player").global_position

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		sprite_2d.play("hit_wall")
		hit_wall = true
		await sprite_2d.animation_finished
		queue_free()

	
