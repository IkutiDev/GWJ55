extends Control

@export var quit_button : Button
@export var settings_scene : PackedScene

const web_platform_name = "Web"

func _ready():
	if OS.get_name() == web_platform_name:
		quit_button.queue_free()

func _on_play_pressed():
	pass


func _on_settings_pressed():
	settings_scene.instantiate()


func _on_quit_pressed():
	get_tree().quit()
