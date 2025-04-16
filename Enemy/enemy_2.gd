extends "res://Enemy/enemy.gd"

@onready var marker_2d: Marker2D = $Marker2D
@onready var laser_timer: Timer = $LaserTimer
var laser_path = "res://Player/Attack/laser_beam.tscn"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _ready():
	super()
	laser_timer.start()
	movement_speed = 120
	hp = 20
	ENEMY_EXP_GAIN = 750
	
	

#func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
	#if hp == 0:
		#Global.cyclops_dead = true
	
	#pass


func _on_laser_timer_timeout() -> void:
	var laser_scene = load(laser_path)
	var laser_beam = laser_scene.instantiate()
	laser_beam.position = marker_2d.global_position
	laser_beam.target = get_tree().get_first_node_in_group("player").global_position
	add_child(laser_beam)
	print("laser!")
	
