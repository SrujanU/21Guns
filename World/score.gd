extends Label


func _process(delta):
	self.text = "Kill Count:" + str(Global.score)
	self.add_theme_color_override("font_color", Color("#FF3333")) # Bright vibrant red
