extends Node2D
@onready var enemy_spawner: Node2D = $EnemySpawner

var cyclops_spawns = [Vector2(-720, -8), Vector2(1064, -192)]
var cyclops_path = "res://Enemy/enemy_2.tscn"
var cyclopses = 5
@onready var cyclops_spawn_timer: Timer = $cyclops_spawn_timer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#wait until a certain point in the level to start spawning stronger enemies
	if Global.score >= 10 and cyclopses != 0 and cyclops_spawn_timer.is_stopped():
		#if cyclopses == 3:
			#enemy_spawner.queue_free()
		
		var cyclops_scene = load(cyclops_path)
		var cyclops = cyclops_scene.instantiate()
		var cyclops_index = randi() % len(cyclops_spawns)
		cyclops.position = cyclops_spawns[cyclops_index]
		add_child(cyclops)
		print("spawned cyclops")
		
		cyclopses -= 1
		cyclops_spawn_timer.start()
		#await get_tree().create_timer(1.5).timeout
		
		
		
		
	
