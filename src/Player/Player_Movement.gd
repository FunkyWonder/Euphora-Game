extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200
const maxMovementSpeed = 35
const jumpForce = 300

var motion = Vector2()
var facingRight = true
var debounce = false
onready var tilemap = get_node("../TileMap")
onready var LevelVariables = get_node("/root/LevelVariables")

func _ready():
	print(LevelVariables.health)
	
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
# warning-ignore:standalone_expression
			null
			# falling
	
	motion = move_and_slide(motion, up)
	
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		var cell = tilemap.world_to_map(collision.position - collision.normal)
# warning-ignore:unused_variable
		var tileID = tilemap.get_cellv(cell)
		
		#print(tileID)
		
		# die
		if tileID == 199:
			if debounce == false:
				print("die")
				debounce = true
				get_tree().reload_current_scene()
		
		# level complete
		if tileID == 56:
			if debounce == false:
				print("You completed the level")
				debounce = true
				get_tree().reload_current_scene()
