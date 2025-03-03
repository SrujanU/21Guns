extends Button

var original_size = Vector2(3.0, 2.0)
var grow_size = Vector2(3.25, 2.25)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	grow_btn(grow_size, .1)


func _on_mouse_exited() -> void:
	grow_btn(original_size, .1)

func grow_btn(end_size, duration):
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)
