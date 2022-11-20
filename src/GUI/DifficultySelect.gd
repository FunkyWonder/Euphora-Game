extends Node

onready var LevelVariables = get_node("/root/LevelVariables")
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	
	pass

func _on_Easy_pressed():
	print("Pressed Easy Button")
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/Level 1.tscn")

func _on_Difficult_pressed():
	print("Pressed Difficult Button")
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/Level 1.tscn")

func _on_Hardcore_pressed():
	print("Pressed Hardcore Button")
	GenerateLevels()
	get_tree().change_scene("res://Scenes/Levels/Level 1.tscn")

func GenerateLevels():
	for x in LevelVariables.MaxLevels / 2:
		var RandomNumber = random.randi_range(0, LevelVariables.MaxLevels)
		
		while LevelVariables.WorldOneLevels.has(RandomNumber) == true:
			RandomNumber = random.randi_range(0, LevelVariables.MaxLevels)
		
		LevelVariables.WorldOneLevels.append(RandomNumber)
