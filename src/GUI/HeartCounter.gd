extends Node

onready var HealthPointsLabel = get_node("HealthPoints")

func _ready():
	if PlayerVariables.Health == 69:
		HealthPointsLabel.set_deferred("text", "inf")
	else:
		HealthPointsLabel.set_deferred("text", "%sX"%PlayerVariables.Health)
