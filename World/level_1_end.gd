extends CanvasLayer

@onready var shop: Button = $EndScreen/SHOP

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $EndScreen/AudioStreamPlayer2D

@onready var end_level_timer: Timer = $end_level_timer
var end_timer_started:bool = false
var shop_path = "res://Gambling/CoinShop/coin_shop.tscn"
@onready var background: TextureRect = $EndScreen/Background
var menu_visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#audio_stream_player_2d.play()
	
	print(load(shop_path))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Global.score >= 15 and not menu_visible:
		#if Global.level == 2:
			#get_tree().quit()
		if not end_timer_started:
			end_level_timer.start()
			end_timer_started = true
		#await get_tree().create_timer(2.0).timeout
			
		#get_parent().visible = false
		#if end_level_timer.is_stopped():
			
			
		#get_parent().paused = true
		
		
		
	


	
	
	


func _on_shop_pressed() -> void:
	print("going to shop.")
	var coin_shop = load(shop_path)
	if not coin_shop:
		print("coin shop scene not found ")
	$".".hide()
	
	
	
	
	
	#create instance of shop scene
	var shop_scene = coin_shop.instantiate()
	#set world scene to process only when scene_tree is not paused
	#get_parent().set_process_mode(1)
	#set shop_scene to only process when scene tree is paused
	shop_scene.set_process_mode(3)
	#add shop scene as child of main node
	get_parent().get_parent().add_child(shop_scene)
	
	shop_scene.position = background.global_position
	#hide world scene
	get_parent().visible = false
	#set correct position of blackjack scene
	
	#show blackjack scene
	shop_scene.visible = true
	shop_scene.top_level = true
	#free world 1 scene and add world 2
	
	get_parent().queue_free()
	#print("world scene freed.")
	
	
	
	


func _on_end_level_timer_timeout() -> void:
	self.show()
	audio_stream_player_2d.play()
	get_tree().paused = true
	menu_visible = true 
	


func _on_nextlevel_pressed() -> void:
	var world_2_path = "res://World/world_2.tscn"
	var world_2_scene = load(world_2_path)
	var world_2 = world_2_scene.instantiate()
	get_parent().get_parent().add_child(world_2)
	get_tree().paused = false
	Global.next_level()
	get_parent().queue_free()
	
