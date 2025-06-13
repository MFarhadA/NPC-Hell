extends Node2D

var player_exist : bool = false
@export var player : Node2D
@export var game_over_menu : PackedScene

func _process(delta: float) -> void:
	if not player_exist and not player:
		print("free!")
		player_exist = true
		game_over()
	
func game_over():
	var go_game_over = game_over_menu.instantiate()
	MusicManager.gameover()
	add_child(go_game_over)
	return
