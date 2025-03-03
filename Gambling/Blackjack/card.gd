extends Node2D
#define card class
class_name Card
var rank: String
var suit: String
var value: int
var facedown:bool = true

func get_value():
	#total card value 
	return value
	
func get_rank():
	return suit + rank
	


func _ready() -> void:
	#display correct suit and rank
	$Texture.texture_normal = load('res://Gambling/sprites/cards/dark/%s-%s.png' % [rank, suit])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if facedown:
		$Texture.disabled = true
	else:
		$Texture.disabled = false
