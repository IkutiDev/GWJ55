extends Path2D

func _ready():
	var scene_tree := get_tree()
	var enemy := $Enemy
	
	await  scene_tree.create_timer(0.5).timeout
	
	enemy.move()
	
	for i in 6:
		await scene_tree.create_timer(1.0).timeout
		
		enemy.current_health -= 1
