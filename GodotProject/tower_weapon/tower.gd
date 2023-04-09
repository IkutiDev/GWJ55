class_name Tower
extends Node2D

signal sold(price, place)
signal select(selected)

@export var cost := 100

@export_group("References")
@export var _weapon : Weapon2D
@export var _interface : Interface
@export var _cooldown_bar : Control
@export var _selection : SelectableArea2D

func _enter_tree():
	_interface.disappear()

func show_interface() -> void:
	_interface.appear()
	
func hide_interface() -> void:
	_interface.disappear()



func _on_selectable_area_2d_selection_changed(selected):
	if selected:
		show_interface()
	else:
		hide_interface()
	emit_signal("selected", select)


func _on_sell_button_pressed():
	emit_signal("sold", cost / 2, global_position)
	queue_free()


func _on_weapon_2d_fired():
	_cooldown_bar.start(_weapon.fire_cooldown)
