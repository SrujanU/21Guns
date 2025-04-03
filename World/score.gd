extends Label


func _process(delta):
	self.text = "Kills:" + str(Global.score)
	self.add_theme_color_override("font_color", Color("FF4444")) # Bright vibrant red
