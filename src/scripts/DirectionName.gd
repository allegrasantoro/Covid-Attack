extends Node


func get_diagonal_direction_name(direction):
	var norm_direction = direction.normalized()
	
	if direction.y >= 0 and direction.x <= 0:
		return "down-left"
	
	elif direction.y >= 0 and direction.x >= 0: 
		return "down-right"
	
	elif direction.y <= 0 and direction.x <= 0: 
		return "up-left"
	
	else:
		return "up-right"


func get_cardinal_direction_name(collision):
	var collider_name = collision.collider.name
	#print(collider_name)
	match collider_name:
		"TopWall":
			return "North"
		"LeftWall":
			return "West"
		"RightWall":
			return "East"
		"BottomWall":
			return "South"
		_:
			return "N/A"

