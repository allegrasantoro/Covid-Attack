extends Node

var PointInPolygonGenerator = load("res://src/scripts/point_in_polygon_generator.gd").new()


func spawn_person(exits, ysort):
	randomize()
	
	#choosing random spawn point
	var spawn_polygon = exits[randi() % exits.size()]
	print("spawnpol:" + String(spawn_polygon.name))
	
	var spawn_local_position = PointInPolygonGenerator.get_random_point_in_polygon(spawn_polygon)
	var spawn_position = Vector2(spawn_local_position.x + spawn_polygon.position.x, spawn_local_position.y + spawn_polygon.position.y)
	print("exit position: " + String(spawn_polygon.position) + "\nlocal position: " + String(spawn_local_position) + "\nspawn position: " + String(spawn_position))
	
	var person = preload("res://src/scenes/Person.tscn").instance()
	person.global_position = spawn_position
	person.scale = Vector2(0.858,0.858)
	ysort.add_child(person)


		
