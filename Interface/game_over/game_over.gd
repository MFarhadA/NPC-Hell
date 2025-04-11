extends Control

@export var retry : PackedScene
@export var main_menu : PackedScene

func _on_retry_pressed() -> void:
	var current_scene = get_tree().current_scene
	var scene_path = current_scene.scene_file_path
	get_tree().change_scene_to_file(scene_path)

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
