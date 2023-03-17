class_name SelectableArea2D
extends Area2D
signal selection_changed(selected)

@export var select_action := "select"

var selected := false : set = set_selected

func _ready():
	set_process_unhandled_input(false)
	

func set_selected(select: bool) -> void:
	selected = select
	if selected:
		add_to_group("selected")
	else:
		remove_from_group("selected")
		
	emit_signal("selection_changed", selected)

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed(select_action):
		set_selected(not selected)

func _unhandled_input(event):
	if event.is_action_pressed(select_action):
		set_selected(false)
		set_process_unhandled_input(false)

func _on_mouse_entered():
	set_process_unhandled_input(false)


func _on_mouse_exited():
	set_process_unhandled_input(selected)

