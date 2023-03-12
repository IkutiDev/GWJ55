extends Node2D

@export var gameplay_gui : PackedScene

func _ready():
	var instance = gameplay_gui.instantiate()
	get_tree().root.add_child.call_deferred(instance)
