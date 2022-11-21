extends Node

export(String) var button1
export(String) var button2
export(String) var wall1
export(String) var wall2

func _on_Button_body_entered(body):
	if body.get_name() == "Player":
		if button1 != "":
			get_node("%s/Button"%button1).set_texture(load("res://Assets/Image/Sprites/Button/button in.png"))
			get_node(wall1).hide()
			get_node("%s/CollisionShape2D"%wall1).set_deferred("disabled", true)


func _on_Button2_body_entered(body):
	if body.get_name() == "Player":
		if button2 != "":
				get_node("%s/Button"%button2).set_texture(load("res://Assets/Image/Sprites/Button/button in.png"))
				get_node(wall2).hide()
				get_node("%s/CollisionShape2D"%wall2).set_deferred("disabled", true)
