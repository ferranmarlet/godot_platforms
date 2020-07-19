extends Node2D

export (int, 0, 400) var speed = 200
var state = "idle"
var facingLeft = false;

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var dir = 0
	
	########## Walking ###########
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		
		if (Input.is_action_pressed("left")):
			dir = -1
			$Sprite.flip_h = true
			facingLeft = true
			
		if (Input.is_action_pressed("right")):
			dir = 1
			$Sprite.flip_h = false
			facingLeft = false
			
		position.x = clamp(position.x + (speed * dir * delta), 50, 974)
				
		$AnimationPlayer.play("walking")
		state = "walking"
		
	if Input.is_action_just_released("right") or Input.is_action_just_released("left"):
		$AnimationPlayer.stop(false)
		$Sprite.frame = 0
		state = "idle"
	
	########## Jumping and falling ###########
	if (Input.is_action_pressed("up") or Input.is_action_pressed("down")):	
		dir = 0
		if (Input.is_action_pressed("up")):
			dir = -1
			
		if (Input.is_action_pressed("down")):
			dir = 1
			
		position.y += speed * dir * delta	
	
	
	########## Greeting ##########
	if (Input.is_action_pressed("say_hi")):
		$Sprite.frame = 7

	if Input.is_action_just_released("say_hi"):
		$Sprite.frame = 0

