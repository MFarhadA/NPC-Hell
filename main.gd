extends Node2D

@export var start : PackedScene

func _ready() -> void:
	load_volume()
	MusicManager.bgm()

func save_volume(mute, music_vol, sfx_vol):
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_vol)
	config.set_value("audio", "sfx_volume", sfx_vol)
	config.set_value("audio", "mute_volume", mute)
	config.save("user://settings.cfg")

func load_volume():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		# music volume
		var music_vol = config.get_value("audio", "music_volume", 0)
		$Control/settings/HBoxContainer/music.value = music_vol
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_vol)
		# sfx volume
		var sfx_vol = config.get_value("audio", "sfx_volume", 0)
		$Control/settings/HBoxContainer2/sfx.value = sfx_vol
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_vol)
		# mute
		var mute_vol = config.get_value("audio", "mute_volume", false)
		$Control/settings/mute.button_pressed = mute_vol
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute_vol)
		
func _on_start_pressed() -> void:
	var level = start.resource_path
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	$Control/menu.visible = false
	$Control/settings.visible = true

func _on_master_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	
func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	
func _on_back_pressed() -> void:
	var music_vol = $Control/settings/HBoxContainer/music.value
	var sfx_vol = $Control/settings/HBoxContainer2/sfx.value
	var mute = $Control/settings/mute.toggle_mode
	save_volume(mute, music_vol, sfx_vol)
	$Control/menu.visible = true
	$Control/settings.visible = false
