extends Node

@export var main_menu_scene : PackedScene

@export var fader_image : ColorRect
@export var fader_animation_player : AnimationPlayer

var pause_counter := 0


func change_scene_with_fade(packed_scene : PackedScene):
	fader_image.mouse_filter = Control.MOUSE_FILTER_STOP
	pause_game(true, "Change Scene")
	fader_animation_player.play("fade")
	await fader_animation_player.animation_finished
	get_tree().change_scene_to_packed(packed_scene)
	fader_animation_player.play_backwards("fade")
	await fader_animation_player.animation_finished
	pause_game(false, "Change Scene")
	fader_image.mouse_filter = Control.MOUSE_FILTER_IGNORE

func pause_game(pause : bool, reason : String):
	
	print("Pausing game " + str(pause) + " Reason:" +reason)
	
	if pause:
		pause_counter += 1
	else:
		pause_counter -= 1
	
	if(pause_counter < 0):
		push_warning("Pause counter undeflows! Investigate why")
	
	get_tree().paused = pause_counter < 0

func lose_game() -> void:
	print("lost!")
	change_scene_with_fade(main_menu_scene)
	
	
