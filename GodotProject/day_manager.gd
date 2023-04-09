extends Node

signal phase_changed(phase_name)

@export var days_names : Array
@export var nights_names : Array
@export var bg_night_color : Color
@export var bg_day_color : Color

var day_counter := 0
var night_active := false

func _ready():
	emit_signal("phase_changed", days_names[day_counter])
	start_day()

func move_to_next_day():
	day_counter += 1
	emit_signal("phase_changed", days_names[day_counter])
	start_day()


func start_day():
	night_active = false
	RenderingServer.set_default_clear_color(bg_day_color)
	get_tree().call_group("visual", "set_day_sprite")

func start_night():
	night_active = true
	emit_signal("phase_changed", nights_names[day_counter])
	RenderingServer.set_default_clear_color(bg_night_color)
	get_tree().call_group("visual", "set_night_sprite")


func _on_gameplay_gui_sleep_button_pressed():
	start_night()
