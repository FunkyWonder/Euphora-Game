extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200
const maxMovementSpeed = 75
const jumpForce = 300
const acceleration = 800
const maxSpeed = 500

var motion = Vector2()
var facingRight = true
var debounce = false
var currentLevelNumber = 0
var walkSoundDelay = 0
var death = false

func _physics_process(_delta):
	var input = false
	motion.y += gravity
	
	if motion.y > maxFallSpeed:
		motion.y = maxFallSpeed
	
	if death != true:
		if Input.is_action_pressed("right"):
			input = true
			facingRight = true
			motion.x = motion.x + maxMovementSpeed
			$AnimationPlayer.play("Run")
			
			if is_on_floor():
				walkSoundDelay += 1
				
				if walkSoundDelay >= 15:
					walkSoundDelay = 0
					$Walk.play()
		
		if Input.is_action_pressed("left"):
			input = true
			facingRight = false
			motion.x = motion.x - maxMovementSpeed
			$AnimationPlayer.play("Run")
			
			if is_on_floor():
				walkSoundDelay += 1
				
				if walkSoundDelay >= 15:
					walkSoundDelay = 0
					$Walk.play()
		
		if input == false:
			motion = motion.linear_interpolate(Vector2.ZERO, 0.02)
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
				$Jump.play()
				motion.y = -jumpForce
		
		if !is_on_floor():
			if motion.y < 0:
				$AnimationPlayer.play("Jump")
				
				if facingRight == true:
					$Sprite.scale.x = 1
				else:
					$Sprite.scale.x = -1
				
			elif motion.y > 0:
				pass
				# falling
		
		motion.x = clamp(motion.x, -maxMovementSpeed, maxMovementSpeed)
		
		motion = move_and_slide(motion, up)
	
	for i in range(get_slide_count()):
		if i > -1 and i < 1:
			var tilemap = get_node("../TileMap")
			var collision = get_slide_collision(i)
			var cell = tilemap.world_to_map(collision.position - collision.normal)
	# warning-ignore:unused_variable
			var tileID = tilemap.get_cellv(cell)
			
			#print(tileID)
			
			# die
			if tileID == 199:
				if debounce == false:
					debounce = true
					
					death = true
					$Die.play()
					
					if DifficultyVariables.medium == true or DifficultyVariables.hard == true:
						PlayerVariables.Health -= 1
					
					yield(get_tree().create_timer(0.2), "timeout")
					
					if PlayerVariables.Health == 0:
						get_tree().change_scene("res://Scenes/GameOver.tscn")
					else:
						get_tree().reload_current_scene()
			
			# level complete
			if tileID == 56:
				if debounce == false:
					debounce = true
					
					get_node("../Door/DoorSound").play()
					get_node("../Door/AnimatedSprite").set_deferred("playing", true)
					get_node("../Player").set_deferred("visible", false)
					
					yield(get_tree().create_timer(1), "timeout")
					
					if LevelVariables.CurrentLevel <= 3:
						currentLevelNumber = LevelVariables.WorldOneLevels[LevelVariables.CurrentLevel]
						get_tree().change_scene("res://Scenes/Levels/World 1/Level %d.tscn"%[currentLevelNumber])
					else:
						currentLevelNumber = LevelVariables.WorldTwoLevels[LevelVariables.CurrentLevel - 4]
						get_tree().change_scene("res://Scenes/Levels/World 2/Level %d.tscn"%[currentLevelNumber])
					
					LevelVariables.CurrentLevel += 1
				
			if tileID == 1:
				if debounce == false:
					debounce = true
					
					get_node("../Door/DoorSound").play()
					get_node("../Door/AnimatedSprite").set_deferred("playing", true)
					get_node("../Player").set_deferred("visible", false)
					
					yield(get_tree().create_timer(1), "timeout")
					
					if LevelVariables.CurrentLevel <= 8 and LevelVariables.CurrentLevel >= 4:
						currentLevelNumber = LevelVariables.WorldTwoLevels[LevelVariables.CurrentLevel - 4]
						get_tree().change_scene("res://Scenes/Levels/World 2/Level %d.tscn"%[currentLevelNumber])
					else:
						currentLevelNumber = LevelVariables.WorldThreeLevels[LevelVariables.CurrentLevel - 9]
						get_tree().change_scene("res://Scenes/Levels/World 3/Level %d.tscn"%[currentLevelNumber])
					
					LevelVariables.CurrentLevel += 1
			
			if tileID == 38:
				if debounce == false:
					debounce = true
					
					get_node("../Door/DoorSound").play()
					get_node("../Door/AnimatedSprite").set_deferred("playing", true)
					get_node("../Player").set_deferred("visible", false)
					
					yield(get_tree().create_timer(1), "timeout")
					
					if LevelVariables.CurrentLevel <= 13 and LevelVariables.CurrentLevel >= 9:
						currentLevelNumber = LevelVariables.WorldThreeLevels[LevelVariables.CurrentLevel - 9]
						get_tree().change_scene("res://Scenes/Levels/World 3/Level %d.tscn"%[currentLevelNumber])
					else:
						get_tree().change_scene("res://Scenes/End.tscn")
					
					LevelVariables.CurrentLevel += 1
			
			if tileID == 20:
				if debounce == false:
					debounce = true
					
					get_node("../Door/DoorSound").play()
					get_node("../Door/AnimatedSprite").set_deferred("playing", true)
					get_node("../Player").set_deferred("visible", false)
					
					yield(get_tree().create_timer(1), "timeout")
					
					if LevelVariables.CurrentLevel <= 18 and LevelVariables.CurrentLevel >= 14:
						currentLevelNumber = LevelVariables.WorldFourLevels[LevelVariables.CurrentLevel - 14]
						get_tree().change_scene("res://Scenes/Levels/World 4/Level %d.tscn"%[currentLevelNumber])
					else:
						get_tree().change_scene("res://Scenes/End.tscn")
					
					LevelVariables.CurrentLevel += 1
