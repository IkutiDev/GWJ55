extends CanvasLayer

signal tower_selected
signal sleep_button_pressed

@export var phase_name_label : Label
@export var sleep_button : Button

func _on_day_manager_phase_changed(phase_name):
	phase_name_label.text = phase_name


func _on_tower_icon_pressed():
	emit_signal("tower_selected")


func _on_sleep_button_pressed():
	emit_signal("sleep_button_pressed")
	sleep_button.disabled = true
