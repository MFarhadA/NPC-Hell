extends Control

@export var player : Node2D

@export var fps : Label
@export var coin : Label
@export var health : Label

var coin_collected : int
var current_health : int

func _process(delta: float) -> void:
	fps.text = "fps: " + str(Engine.get_frames_per_second())
	
	if player:
		coin_collected = player.coin_collected
		current_health = player.current_health
	
	coin.text = str(coin_collected)
	health.text = str(current_health)
