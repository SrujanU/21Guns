extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
		Global.health = min(Global.max_health, Global.health + 20)
		print(Global.health)
	
