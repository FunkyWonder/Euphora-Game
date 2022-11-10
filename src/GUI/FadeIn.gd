extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("FadeIn")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")
