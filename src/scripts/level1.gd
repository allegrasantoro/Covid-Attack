extends Node2D

onready var exits = get_tree().get_nodes_in_group("exits")
var Spawning = preload("res://src/scripts/spawning.gd").new()
export var initial_people_number = 10


func _ready():
	for i in range(0, initial_people_number):
		Spawning.spawn_person(exits, $MovingEntities)
	Global.current_score = 0
	$LevelTimer.start()

func _process(delta):
	$CanvasLayer/BestScoreNumber.text = String(Global.best_score)
	$CanvasLayer/CurrentScoreNumber.text = String(Global.current_score)
	$CanvasLayer/TimerNumber.text = String(int($LevelTimer.get_time_left()))
	
	
func _on_PeopleSpawnTimer_timeout():
	Spawning.spawn_person(exits, $MovingEntities)


func _on_Exits_body_entered(body):
	if body.is_in_group('People'):
		if body.can_exit == true:
			body.destroy("fading away")


func _on_LevelTimer_timeout():
	get_tree().reload_current_scene()
