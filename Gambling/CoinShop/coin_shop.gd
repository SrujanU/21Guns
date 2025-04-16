extends Node2D

@onready var armour_hp: Button = $CanvasLayer/ShopMenuBackground/ArmourHP
@onready var guns_ammo: Button = $CanvasLayer/ShopMenuBackground/GunsAmmo
@onready var upgrades: Button = $CanvasLayer/ShopMenuBackground/Upgrades
@onready var armour_shop: Node2D = $ArmourShop
@onready var shop_items: CanvasLayer = $ShopItems
@onready var gun_layer: CanvasLayer = $GunLayer
@onready var upgrade_layer: CanvasLayer = $UpgradeLayer

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $CanvasLayer/ShopMenuBackground/AudioStreamPlayer2D
@onready var soundtrack: AudioStreamPlayer2D = $soundtrack
@onready var button: Button = $CanvasLayer/ShopMenuBackground/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	soundtrack.play()
	print("welcome")
	shop_items.hide()
	gun_layer.hide()
	upgrade_layer.hide()
	print_tree_pretty()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


	


func _on_armour_hp_pressed() -> void:
	upgrade_layer.hide()
	gun_layer.hide()
	shop_items.show()
	audio_stream_player_2d.play()
	


func _on_guns_ammo_pressed() -> void:
	upgrade_layer.hide()
	shop_items.hide()
	gun_layer.show()
	audio_stream_player_2d.play()
	gun_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	print(gun_layer.process_mode)
	


func _on_upgrades_pressed() -> void:
	
	shop_items.hide()
	gun_layer.hide()
	upgrade_layer.show()
	audio_stream_player_2d.play()
	


func _on_level2_button_pressed() -> void:
	get_parent().print_tree_pretty()
	var world_2_path = "res://World/world_2.tscn"
	var world_2_scene = load(world_2_path)
	var world_2 = world_2_scene.instantiate()
	get_parent().add_child(world_2)
	get_tree().paused = false
	Global.next_level()
	queue_free()
	
