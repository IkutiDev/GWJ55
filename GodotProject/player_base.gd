extends Node2D

signal destroyed
signal health_changed(current_health, max_health)

@export var max_health := 5

@export_group("References")
@export var _sprite : Sprite2D
@export var _hurt_box : HurtBoxArea2D

var current_helth := max_health : set = set_health

func set_health(value: int) -> void:
	current_helth = clamp(value, 0, max_health)
	if current_helth < 1:
		_hurt_box.set_deferred("monitorable", false)
		GameManager.lose_game()

func _ready():
	current_helth = max_health
	emit_signal("health_changed", current_helth, max_health)
	


func _on_hurt_box_area_2d_hit_landed(damage):
	set_health(current_helth - damage)
	emit_signal("health_changed", current_helth, max_health)
