extends Node

signal tower_placed(tower)

@export var floor_tile_map : TileMap
@export var offset : Vector2 = Vector2.ONE

var can_place_towers := false

var _current_tower : Tower
var _current_cell := Vector2i.ZERO

const AVAILABLE_CELL_ID := 0
const INVAILD_CELL_ID := 1

var debug_on := false

var placeable_color : Color
var unplaceable_color : Color

func _ready():
	set_process_unhandled_input(false)
	
	placeable_color = floor_tile_map.get_layer_modulate(0)
	unplaceable_color = floor_tile_map.get_layer_modulate(1)
	
	
	floor_tile_map.set_layer_modulate(0, Color.TRANSPARENT)
	floor_tile_map.set_layer_modulate(1, Color.TRANSPARENT)
	
	
	var tower = load("res://tower_weapon/tower.tscn").instantiate()
	
	add_new_tower(tower)
	
func _input(event):
	pass
	
func set_cell_unplaceable(cell: Vector2i) -> void:
	floor_tile_map.set_cell(0, cell)
	floor_tile_map.set_cell(1, cell, INVAILD_CELL_ID, Vector2i.ZERO, 0)
	var cell_id  = floor_tile_map.get_cell_source_id(0, cell)
	print("Making this unplaceable"+ str(cell) + " " + str(cell_id))
	
func set_cell_placeable(cell: Vector2i) -> void:
	floor_tile_map.set_cell(1, cell)
	floor_tile_map.set_cell(0, cell, AVAILABLE_CELL_ID, Vector2i.ZERO, 0)
	var cell_id  = floor_tile_map.get_cell_source_id(0, cell)
	print("Making this placeable"+ str(cell) + " " + str(cell_id))

func get_cell_id(cell: Vector2i) -> int:
	var cell_id = floor_tile_map.get_cell_source_id(0, cell)
	if cell_id == -1:
		cell_id = floor_tile_map.get_cell_source_id(1, cell)
	return cell_id

func is_cell_placeable(cell: Vector2i) -> bool:
	return get_cell_id(cell) == AVAILABLE_CELL_ID
	
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
	set_cell_placeable(floor_tile_map.local_to_map(place + offset))

func _snap_tower_to_grid():
	_current_cell = floor_tile_map.local_to_map(floor_tile_map.get_local_mouse_position() + offset)
	_current_tower.position = floor_tile_map.map_to_local(_current_cell) + (floor_tile_map.tile_set.tile_size * 1.25)
	
	if not is_cell_placeable(_current_cell):
		_current_tower.z_index = 10
		_current_tower.modulate = Color.DARK_RED
	else:
		_current_tower.z_index = 0
		_current_tower.modulate = Color.WHITE
		
	if get_cell_id(_current_cell) == -1:
		_current_tower.z_index = -1		
		


func enable_debug_mode():
	debug_on = not debug_on
	floor_tile_map.set_layer_modulate(0, Color.TRANSPARENT if not debug_on else placeable_color)
	floor_tile_map.set_layer_modulate(1, Color.TRANSPARENT if not debug_on else unplaceable_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("debug_mode"):
		enable_debug_mode()
	
	var hovered_cell = floor_tile_map.local_to_map(floor_tile_map.get_local_mouse_position() + offset)
	var cell_id  = floor_tile_map.get_cell_source_id(0, hovered_cell)
	if cell_id != -1:
		print(str(_current_cell) + " " + str(cell_id))
	
