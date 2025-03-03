extends Control


@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var back: Button = $CanvasLayer/back

func _ready():
	canvas_layer.hide()
	back.connect("pressed", _on_back_button_pressed)
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_options_pressed() -> void:
	canvas_layer.show()
	
	pass
	

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed():
	canvas_layer.hide()
	
