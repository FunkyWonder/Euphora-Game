extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200
const maxMovementSpeed = 40
const jumpForce = 250

var motion = Vector2()
var facingRight = true

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var input = false
	motion.y += gravity
	
	if motion.y > maxFallSpeed:
		motion.y = maxFallSpeed
	
	motion.x = clamp(motion.x, -maxMovementSpeed, maxMovementSpeed)
	
	if Input.is_action_pressed("right"):
		input = true
		facingRight = true
		motion.x = motion.x + maxMovementSpeed
		$AnimationPlayer.play("Run")
	
	if Input.is_action_pressed("left"):
		input = true
		facingRight = false
		motion.x = motion.x - maxMovementSpeed
		$AnimationPlayer.play("Run")
	
	if input == false:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
		
		if facingRight == true:
			$Sprite.scale.x = -1
		else:
			$Sprite.scale.x = 1
	else:
		if facingRight == true:
			$Sprite.scale.x = 1
		else:
			$Sprite.scale.x = -1
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jumpForce
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
			
			if facingRight == true:
				$Sprite.scale.x = 1
			else:
				$Sprite.scale.x = -1
			
		elif motion.y > 0:
			print("Falling")
	
	motion = move_and_slide(motion, up)