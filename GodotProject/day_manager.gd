extends Node

signal phase_changed(phase_name)
signal timer_changed(timer)

@export var days_names : Array
@export var nights_names : Array
@export var tower_placing_timer : float

var day_counter := 0
var night_active := false

var timer := 0.0

func _ready():
	emit_signal("phase_changed", days_names[day_counter])
	start_day()

func move_to_next_day():
	day_counter += 1
	emit_signal("phase_changed", days_names[day_counter])
	start_day()

func _process(delta):
	if timer > 0:
		timer -= delta
		emit_signal("timer_changed", timer)
	elif night_active == false:
		night_active = true
		emit_signal("phase_changed", nights_names[day_counter])

func start_day():
	timer = tower_placing_timer
