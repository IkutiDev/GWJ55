extends Node

signal tower_placed(tower)

@export var floor_tile_map : TileMap
@export var selection_visual : Sprite2D
@export var offset : Vector2 = Vector2.ONE

var can_place_towers := false

var _current_tower : Tower
var _current_cell := Vector2i.ZERO

const AVAILABLE_CELL_ID := 0
const INVAILD_CELL_ID := 1

func _ready():
	set_process_unhandled_input(false)
	
	setup_available_cells([Vector2(12, 7)])
	
	var tower = load("res://tower_weapon/tower.tscn").instantiate()
	
	add_new_tower(tower)
	
func _input(event):
	pass
	
func set_cell_unplaceable(cell: Vector2i) -> void:
	floor_tile_map.set_cell(0, cell, INVAILD_CELL_ID)
	
func set_cell_placeable(cell: Vector2i) -> void:
	floor_tile_map.set_cell(0, cell, AVAILABLE_CELL_ID)

func is_cell_placeable(cell: Vector2i) -> bool:
	return floor_tile_map.get_cell_source_id(0, cell) == AVAILABLE_CELL_ID
	
func setup_available_cells(cells_array: PackedVector2Array) -> void:
	for cell in cells_array:
		set_cell_placeable(cell)
	
	
func add_new_tower(tower: Tower) -> void:
	if _current_tower:
		_current_tower.queue_free()
		
	add_child(tower)
	_current_tower = tower
	
	set_process_unhandled_input(true)
	
	_snap_tower_to_grid()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_snap_tower_to_grid()
		
	if event.is_action_pressed("tower_placement"):
		_place_tower()
	
func _place_tower():
	set_process_unhandled_input(false)
	
	if not is_cell_placeable(_current_cell):
		_current_tower.queue_free()
		_current_tower = null
		return
		
	set_cell_unplaceable(_current_cell)
	
	emit_signal("tower_placed", _current_tower)
	_current_tower.connect("sold", _on_Tower_sold)
	_current_tower = null
	
	
func _on_Tower_sold(_price: int, place: Vector2):
	set_cell_placeable(floor_tile_map.local_to_map(place))

func _snap_tower_to_grid():
	_current_cell = floor_tile_map.local_to_map(floor_tile_map.get_local_mouse_position() + offset)
	_current_tower.global_position = floor_tile_map.map_to_local(_current_cell)
	
	if not is_cell_placeable(_current_cell):
		_current_tower.modulate = Color.DARK_RED
	else:
		_current_tower.modulate = Color.WHITE
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hovered_cell = floor_tile_map.local_to_map(floor_tile_map.get_local_mouse_position() + offset)
	var cell_id  = floor_tile_map.get_cell_source_id(0, hovered_cell)
	var tile_center_pos = floor_tile_map.map_to_local(hovered_cell) + (floor_tile_map.tile_set.tile_size / 2.0)
	if cell_id == -1:
		selection_visual.hide()
	else:
		print(cell_id)
		selection_visual.position = tile_center_pos
		selection_visual.show()
	
