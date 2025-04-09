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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	soundtrack.play()
	print("welcome")
	shop_items.hide()
	gun_layer.hide()
	upgrade_layer.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("shop")
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
	


func _on_upgrades_pressed() -> void:
	
	shop_items.hide()
	gun_layer.hide()
	upgrade_layer.show()
	audio_stream_player_2d.play()
	
