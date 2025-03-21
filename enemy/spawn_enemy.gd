extends Node2D

@export var enemy_scene : PackedScene
@export var spawn_area : Vector2

@export var spawn_timer : Timer
@export var enemy_container : Node2D

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func _process(delta: float) -> void:
	print(spawn_timer.time_left)
	
func spawn_enemy():
	var x = [-20, 500].pick_random()
	var y = randf_range(0, spawn_area.y)
	var spawn_pos = Vector2(x, y)
	
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_pos
	enemy_container.add_child(enemy)
	enemy.start_moving()
