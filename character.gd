extends Node2D

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var dir = 0
	if (Input.is_action_pressed("left")):
		dir = -1
		
	if (Input.is_action_pressed("right")):
		dir = 1
		
	position.x += 200 * dir * delta
	
	dir = 0
	if (Input.is_action_pressed("up")):
		dir = -1
		
	if (Input.is_action_pressed("down")):
		dir = 1
		
	position.y += 200 * dir * delta

