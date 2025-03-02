extends Button

@export_file var level_path
var previous_level: int = 0
var rand_upgrade1 = randi() % 4
var original_size := Vector2(0.2, 0.327)
var grow_size = Vector2(0.25, 0.377)

func _on_visibility_changed():
	rand_upgrade1 = randi() % 4
	self.text = get_upgrade_text(rand_upgrade1)
	
	

func get_upgrade_text(upgrade_id):
	match upgrade_id:
		0: return "Attack Power +"
		1: return "Movement Speed +"
		2: return "Cooldown -"
		3: return "Bullet Velocity +"

func _process(delta):
	if Global.player_level != previous_level:
		previous_level = Global.player_level  # Update stored level
		_on_visibility_changed()  # Call function when level changes
		
	
func _on_mouse_entered() -> void:
	grow_btn(grow_size, .1)

func _on_mouse_exited() -> void:
	grow_btn(original_size, .1)
	
func grow_btn(end_size: Vector2, duration: float):
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)
	




func _on_pressed() -> void:
	if level_path == null:
		return
	#var packed_scene = load(level_path)
	Global.upgrades.append(rand_upgrade1)
	print(Global.upgrades)
	get_parent().visible = false  # Hides the UI node
	get_tree().paused = false
	#get_tree().change_scene_to_packed(packed_scene)
	#print("blackjack time")
	#print(packed_scene)
