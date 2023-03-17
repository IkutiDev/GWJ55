class_name Bullet
extends Node2D

@export var speed := 500.0

var _tween : Tween

func _enter_tree():
	_tween = get_tree().create_tween()
	_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)

func _init():
	top_level = true
	
func fly_to(target_global_position: Vector2) -> void:
	var distance := global_position.distance_to(target_global_position)
	var duration := distance / speed
	
	_tween.tween_property(self, "global_position", target_global_position, duration)
	_tween.play()
	
	look_at(target_global_position)
	await _tween.finished
	
	queue_free()
	
