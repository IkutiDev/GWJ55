class_name Interface
extends Control

@export var _anim_player : AnimationPlayer

func appear() -> void:
	_anim_player.play("appear")


func disappear() -> void:
	_anim_player.play("disappear")
