extends Node2D

@export var spawn_timer : Timer

@export var spawn_area : Vector2
@export var coin_scene : PackedScene
@export var coin_container : Node2D

var spawn_rate: float = 2.0
var min_spawn_rate: float = 0.5
var spawn_decrease: float = 0.1

signal add_spawner

func _ready() -> void:
	spawn_coin()

func spawn_coin():
	var x = randf_range(20, 460)
	var y = randf_range(50, 660)
	var spawn_pos = Vector2(x, y)
	
	var coin = coin_scene.instantiate()
	coin.position = spawn_pos
	coin_container.add_child(coin)
	
	coin.connect("coin_collected", Callable(self, "_on_coin_collected").bind(coin))
	
func _on_coin_collected(coin):
	emit_signal("add_spawner")
	await get_tree().create_timer(1.0).timeout
	spawn_coin()
	spawn_rate = max(spawn_rate - spawn_decrease, min_spawn_rate)
	spawn_timer.wait_time = spawn_rate
	spawn_timer.start()
	
	print()
