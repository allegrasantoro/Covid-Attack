extends Node

var best_score = 0
var current_score = 0
func _process(delta):
	if Input.is_action_pressed("covid_esc"):
		get_tree().quit()
