extends Node
#world level path
var world_path = "res://World/world.tscn"

@onready var menu: Control = $Menu
@onready var blackjack: Blackjack = $Blackjack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().set_current_scene($Menu)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
