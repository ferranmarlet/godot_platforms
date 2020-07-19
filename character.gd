extends Node2D

export (int, 0, 400) var speed = 200

const GRAVITY = 10
const JUMPING_POWER = 500

var state = "idle"
var facingLeft = false
var isOnFloor = true
var inertia = 0

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

	if (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")):
		if (isOnFloor):	
			$AnimationPlayer.play("walking")
			state = "walking"
		
	if Input.is_action_just_released("right") or Input.is_action_just_released("left"):
		if (isOnFloor):
			$AnimationPlayer.stop(false)
			$Sprite.frame = 0
			state = "idle"
		
	########## Jumping and falling ###########
	if (Input.is_action_just_pressed("up")):	
		dir = 0
		dir = -1
		inertia = -JUMPING_POWER
		isOnFloor = false
		$Sprite.frame = 1
		$AnimationPlayer.stop(false)
	
	if (not isOnFloor):
		position.y += inertia * delta
		if (inertia < 100):
			inertia += GRAVITY
	
	########## Greeting ##########
	if (Input.is_action_pressed("say_hi")):
		$Sprite.frame = 7

	if Input.is_action_just_released("say_hi"):
		$Sprite.frame = 0

func _on_character_area_entered(area):
	state = "idle"
	$Sprite.frame = 0
	isOnFloor = true
