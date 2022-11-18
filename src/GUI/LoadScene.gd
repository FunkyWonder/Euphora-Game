extends Button

export(String) var scene_to_load

func _on_Level_1_pressed():
	connect("pressed", self, "_on_Button_pressed", [scene_to_load])
	
	get_tree().change_scene(scene_to_load)


func _on_Button_Pressed():
	pass # Replace with function body.
