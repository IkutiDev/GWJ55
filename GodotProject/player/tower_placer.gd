extends Node

@export var floor_tile_map : TileMap
@export var selection_visual : Sprite2D
@export var offset : Vector2 = Vector2.ONE

var can_place_towers := false

const AVAILABLE_CELL_ID := 0
const INVAILD_CELL_ID := 1

func _ready():
	selection_visual.hide()

func _input(event):
	pass

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
	
