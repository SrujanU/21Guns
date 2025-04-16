extends Window

var tutorial_stage = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false
	if Global.is_first_play:
		
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		$".".visible = true
		$Label.text = "\nUse the WASD keys\nto move."
		close_requested.connect(_on_close_requested)
	
	
	
	 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	if tutorial_stage == 1:
		$".".visible = false
		get_tree().paused = false
		return
	$".".visible = false
	get_tree().paused = false
	await get_tree().create_timer(2.0).timeout
	#second message
	get_tree().paused = true
	$".".visible = true
	$Label.text = "\nUse arrow keys to\nshoot enemies for\nXP and coins!"
	tutorial_stage += 1
