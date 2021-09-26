extends Node

func _process(delta):
	if Input.is_action_pressed("covid_esc"):
		get_tree().quit()
