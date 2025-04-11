extends Node2D

@export var start : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	var level = start.resource_path
	get_tree().change_scene_to_file(level)

func _on_exit_pressed() -> void:
	get_tree().quit()
