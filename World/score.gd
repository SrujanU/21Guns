extends Label


func _process(delta):
	self.text = "Kill Count:" + str(Global.score)
