extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200
const maxMovementSpeed = 40
const jumpForce = 250

var motion = Vector2()

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var input = false
	motion.y += gravity
	
	if motion.y > maxFallSpeed:
		motion.y = maxFallSpeed
	
	motion.x = clamp(motion.x, -maxMovementSpeed, maxMovementSpeed)
	
	if Input.is_action_pressed("right"):
		input = true
		motion.x = motion.x + maxMovementSpeed
	
	if Input.is_action_pressed("left"):
		input = true
		motion.x = motion.x - maxMovementSpeed
		
	if input == false:
		motion.x = lerp(motion.x, 0, 0.2)
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jumpForce
	
	motion = move_and_slide(motion, up)

