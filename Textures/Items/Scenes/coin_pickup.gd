extends Area2D



@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	print("coin")
	if body.is_in_group("player"):
		animation_player.play("pickup")
		
		Global.coins += 10
		
