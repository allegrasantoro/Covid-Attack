extends Node


var DirectionName = preload("res://src/scripts/DirectionName.gd").new()


func manage_collision(collision, direction):
	var collision_position = DirectionName.get_cardinal_direction_name(collision)
	var person_current_direction = DirectionName.get_diagonal_direction_name(direction)
	return change_direction_after_collision(collision_position, person_current_direction)


func change_direction_after_collision(collision_position, person_current_direction):
	var new_direction = Vector2()
	match collision_position:
		"West":
			if person_current_direction == "up-left":
				new_direction.y = -1
				new_direction.x = 1
			elif person_current_direction == "up-right":
				new_direction.y = -1
				new_direction.x = 1
			elif person_current_direction == "down-left":
				new_direction.y = 1
				new_direction.x = 1
			else:
				print("error: change_direction_after_collision method - West - direction:" + person_current_direction)
		
		"North":
			if person_current_direction == "up-left":
				new_direction.y = 1
				new_direction.x = 1
			elif person_current_direction == "up-right":
				new_direction.y = 1
				new_direction.x = -1
			else:
				print("error: change_direction_after_collision method - North - direction:" + person_current_direction)
		
		"East":
			if person_current_direction == "up-right":
				new_direction.y = -1
				new_direction.x = -1
			elif person_current_direction == "down-right":
				new_direction.y = 1
				new_direction.x = -1
			else:
				print("error: change_direction_after_collision method - East - direction:" + person_current_direction)
		"South":
			if person_current_direction == "down-left":
				new_direction.y = -1
				new_direction.x = -1
			elif person_current_direction == "down-right":
				new_direction.y = -1
				new_direction.x = 1
			else:
				print("error: change_direction_after_collision method - South - direction:" + person_current_direction)
		
		"N/A":
			pass
			
		_:
			print("error: change_direction_after_collision method - match")
			
	return new_direction
	#Person.change_sprite_texture()


