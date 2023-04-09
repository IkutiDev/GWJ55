class_name Wave
extends Path2D

signal starting
signal finished

@export_range(0.1, 5.0, 0.05) var enemy_time_arrival := 0.5

func _ready():
	start()

func start() -> void:
	emit_signal("starting")
	_setup_enemies()
	_move_enemies()
	

func _setup_enemies() -> void:
	for enemy in get_children():
		enemy.progress_ratio = 0.0
		enemy.connect("tree_exited", _on_Enemy_tree_exited)

func _move_enemies() -> void:
	for enemy in get_children():
		await get_tree().create_timer(enemy_time_arrival).timeout
		enemy.move()

func set_movement_path(movement_path: PackedVector2Array) -> void:
	curve.clear_points()
	for point in movement_path:
		curve.add_point(point)

func is_wave_finished() -> bool:
	return get_child_count() < 1

func _on_Enemy_tree_exited() -> void:
	if is_wave_finished():
		emit_signal("finished")
		queue_free()
