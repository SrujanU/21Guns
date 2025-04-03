extends Button


var original_size = Vector2(0.127, 0.348)
var grow_size = Vector2(0.147, 0.368)



func grow_btn(end_size: Vector2, duration: float):
	var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)


func _on_mouse_entered() -> void:
	grow_btn(grow_size, 0.1)




func _on_mouse_exited() -> void:
	grow_btn(original_size, 0.1)
