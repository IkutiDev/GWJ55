extends Sprite2D

@export var day_sprite : Texture2D
@export var night_sprite : Texture2D
@export var sprite_renderer_during_night : Sprite2D

func set_day_sprite():
	if sprite_renderer_during_night != null:
		sprite_renderer_during_night.hide()
	texture = day_sprite
	
func set_night_sprite():
	if sprite_renderer_during_night != null:
		sprite_renderer_during_night.show()
	texture = night_sprite
