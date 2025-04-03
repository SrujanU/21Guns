extends Node2D

@onready var armour_hp: Button = $CanvasLayer/ShopMenuBackground/ArmourHP
@onready var guns_ammo: Button = $CanvasLayer/ShopMenuBackground/GunsAmmo
@onready var upgrades: Button = $CanvasLayer/ShopMenuBackground/Upgrades
@onready var armour_shop: Node2D = $ArmourShop
@onready var shop_items: CanvasLayer = $ShopItems

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("welcome")
	shop_items.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


	


func _on_armour_hp_pressed() -> void:
	shop_items.show()
