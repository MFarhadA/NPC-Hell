extends Node2D

@export var spawn_timer : Timer

@export var potion_scenes : Array[PackedScene] 
@export var potion_container : Node2D

var spawn_rate: float = 2.0
var min_spawn_rate: float = 0.5
var spawn_decrease: float = 0.1

var potion_exist : bool = false

const MIN_X_AXIS := 20
const MAX_X_AXIS := 460
const MIN_Y_AXIS := 50
const MAX_Y_AXIS := 660

signal add_spawner

func _process(delta: float) -> void:
	if not potion_exist and get_tree().get_nodes_in_group("coin").size() == 0:
		potion_exist = true
		await get_tree().create_timer(5.0).timeout
		spawn_potion()
		spawn_rate = max(spawn_rate - spawn_decrease, min_spawn_rate)
		spawn_timer.wait_time = spawn_rate
		spawn_timer.start()
		potion_exist = false

func spawn_potion():
	var x = randf_range(MIN_X_AXIS, MAX_X_AXIS)
	var y = randf_range(MIN_Y_AXIS, MAX_Y_AXIS)
	var spawn_pos = Vector2(x, y)
	
	var random_range = randi_range(0, potion_scenes.size() - 1) # Zero to array length minus one
	#print(random_range, " ", potion_scenes[random_range].instantiate())
	var potion: Area2D = potion_scenes[random_range].instantiate()
	potion.position = spawn_pos
	
	potion_container.add_child(potion)
