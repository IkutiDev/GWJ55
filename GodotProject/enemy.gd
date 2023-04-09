class_name Enemy
extends PathFollow2D

signal died

@export var max_health := 15
@export var speed := 64.0

var current_health := max_health : set = set_health

@export_group("References")
#@export var _anim_player : AnimationPlayer
@onready var animation_player = $AnimationPlayer
@onready var ui_pivot = $UIPivot
@onready var health_bar = $UIPivot/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
	ui_pivot.top_level = true
	
	health_bar.max_value = max_health
	health_bar.value = current_health
	
func set_health(value: int) -> void:
	current_health  = clamp(value, 0, max_health)
	health_bar.value = current_health
	
	if current_health < 1:
		die()

func die() -> void:
	emit_signal("died")
	disappear()
	
func _physics_process(delta):
	progress += speed * delta
	
	if progress_ratio >= 1.0:
		set_physics_process(false)
		disappear()
		
func move() -> void:
	set_physics_process(true)

func disappear() -> void:
	animation_player.play("disappear")


func _on_hurt_box_area_2d_hit_landed(damage : int):
	set_health(current_health - damage)
