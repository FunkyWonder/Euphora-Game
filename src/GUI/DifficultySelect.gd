extends Node

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()

func _on_Easy_pressed():
	print("Pressed Easy Button")
	LevelVariables.easy = true
	PlayerVariables.Health = 69
	AddTutorialLevels()
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/World 1/Level 1.tscn")

func _on_Difficult_pressed():
	print("Pressed Difficult Button")
	LevelVariables.medium = true
	PlayerVariables.Health = 3
	AddTutorialLevels()
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/World 1/Level 1.tscn")

func _on_Hardcore_pressed():
	print("Pressed Hardcore Button")
	LevelVariables.hard = true
	PlayerVariables.Health = 1
	AddTutorialLevels()
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/World 1/Level 1.tscn")

func GenerateLevels():
	for x in LevelVariables.MaxLevels / 2 - 2:
		var RandomNumber = random.randi_range(3, LevelVariables.MaxLevels)
		
		while LevelVariables.WorldOneLevels.has(RandomNumber) == true:
			RandomNumber = random.randi_range(3, LevelVariables.MaxLevels)
		
		LevelVariables.WorldOneLevels.append(RandomNumber)
	
	for x in LevelVariables.MaxLevels / 2 - 1:
		var RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		while LevelVariables.WorldTwoLevels.has(RandomNumber) == true:
			RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		LevelVariables.WorldTwoLevels.append(RandomNumber)
	
	for x in LevelVariables.MaxLevels / 2 - 1:
		var RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		while LevelVariables.WorldThreeLevels.has(RandomNumber) == true:
			RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		LevelVariables.WorldThreeLevels.append(RandomNumber)
	
	for x in LevelVariables.MaxLevels / 2 - 1:
		var RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		while LevelVariables.WorldFourLevels.has(RandomNumber) == true:
			RandomNumber = random.randi_range(2, LevelVariables.MaxLevels)
		
		LevelVariables.WorldFourLevels.append(RandomNumber)

func AddTutorialLevels():
	LevelVariables.WorldOneLevels.append(2)
	LevelVariables.WorldTwoLevels.append(1)
	LevelVariables.WorldThreeLevels.append(1)
	LevelVariables.WorldFourLevels.append(1)
