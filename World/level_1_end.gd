extends CanvasLayer

@onready var shop: Button = $SHOP



var shop_path = "res://Gambling/CoinShop/coin_shop.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#self.hide()
	print(load(shop_path))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	'''if Global.score == 1:
		
		#await get_tree().create_timer(2.0).timeout
		#self.set_process_mode(2)
		#get_parent().visible = false
		self.show()
		get_tree().paused = true
		
		
		
	


	
	
	


func _on_shop_pressed() -> void:
	print("going to shop.")
	var coin_shop = load(shop_path)
	if not coin_shop:
		print("coin shop scene not found ")
	$".".hide()
	
	
	
	
	#create instance of shop scene
	var shop_scene = coin_shop.instantiate()
	#set world scene to process only when scene_tree is not paused
	get_parent().set_process_mode(1)
	#set blackjack_scene to only process when scene tree is paused
	shop_scene.set_process_mode(2)
	#add blackjack scene as child of main node
	self.add_child(shop_scene)
	
	
	#hide world scene
	get_parent().visible = false
	#set correct position of blackjack scene
	
	#show blackjack scene
	shop_scene.visible = true
	var shoplayer = shop_scene.get_node("CanvasLayer")
	shoplayer.visible = true
	print(shop_scene)
	print(shop.position)
	print(shop_scene.position)'''
