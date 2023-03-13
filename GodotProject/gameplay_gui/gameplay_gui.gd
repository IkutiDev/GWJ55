extends CanvasLayer

signal tower_selected

@export var phase_name_label : Label
@export var timer_static_text : String
@export var timer_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_day_manager_timer_changed(timer : float):
	timer_label.text = timer_static_text + str(abs(round(timer)))


func _on_day_manager_phase_changed(phase_name):
	phase_name_label.text = phase_name


func _on_tower_icon_pressed():
	emit_signal("tower_selected")
