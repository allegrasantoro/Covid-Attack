extends Node2D

onready var exits = get_tree().get_nodes_in_group("exits")
var Spawning = load("res://src/scripts/spawning.gd").new()


func _ready():
	Spawning.spawn_person(exits, $MovingEntities)


func _on_PeopleSpawnTimer_timeout():
	#Spawning.spawn_person(exits, $MovingEntities)
	pass
