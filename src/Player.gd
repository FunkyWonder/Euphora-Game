extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200
const maxMovementSpeed = 80
const jumpForce = 250

var motion = Vector2()

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	motion.y += gravity
	motion.x = 0

	if motion.y > maxFallSpeed:
		motion.y = maxFallSpeed

	if Input.is_action_pressed("right"):
		motion.x = motion.x + maxMovementSpeed
	
	if Input.is_action_pressed("left"):
		motion.x = motion.x - maxMovementSpeed

	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jumpForce

	motion = move_and_slide(motion, up)

