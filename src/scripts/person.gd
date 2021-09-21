extends KinematicBody2D

var person_type = "Mark"
var direction = Vector2()
var random_number = RandomNumberGenerator.new()
export var speed : = 100.0
var current_direction


func _ready():
	$AnimationPlayer.play("walking")
	new_initial_direction()


func _physics_process(delta):
	var movement = direction * speed * delta
	var collision = move_and_collide(movement)
	if collision:
		manage_collision(collision)


func manage_collision(collision):
	print("COLLISION")
	#var collision_motion = position - collision.position
	print(get_cardinal_direction_name(collision))
	#print(collision_motion)
	var collision_position = get_cardinal_direction_name(collision)
	var person_current_direction = get_diagonal_direction_name(direction)
	change_direction_after_collision(collision_position, person_current_direction)


func change_direction_after_collision(collision_position, person_current_direction):
	match collision_position:
		"West":
			if person_current_direction == "up-left":
				direction.y = -1
				direction.x = 1
			elif person_current_direction == "up-right":
				direction.y = -1
				direction.x = 1
				
			elif person_current_direction == "down-left":
				direction.y = 1
				direction.x = 1
			else:
				print("error: change_direction_after_collision method - West - direction:" + person_current_direction)
		
		"North":
			if person_current_direction == "up-left":
				direction.y = 1
				direction.x = 1
			elif person_current_direction == "up-right":
				direction.y = 1
				direction.x = -1
			else:
				print("error: change_direction_after_collision method - North - direction:" + person_current_direction)
		
		"East":
			if person_current_direction == "up-right":
				direction.y = -1
				direction.x = -1
			elif person_current_direction == "down-right":
				direction.y = 1
				direction.x = -1
			else:
				print("error: change_direction_after_collision method - East - direction:" + person_current_direction)
		"South":
			if person_current_direction == "down-left":
				direction.y = -1
				direction.x = -1
			elif person_current_direction == "down-right":
				direction.y = -1
				direction.x = 1
			else:
				print("error: change_direction_after_collision method - South - direction:" + person_current_direction)
		
		"N/A":
			pass
			
		_:
			print("error: change_direction_after_collision method - match")
			
	change_sprite_texture()

 
func get_cardinal_direction_name(collision):
	var collider_name = collision.collider.name
	print(collider_name)
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


func _on_change_direction_timer_timeout():
	new_random_direction()


func new_initial_direction():
	random_number.randomize()
	current_direction = random_number.randf() * 2 * PI
	change_direction(current_direction)


func new_random_direction():
	random_number.randomize()
	var random_degree_change = rand_range(0.785398, -0.785398) #0.785398 radians is 45 degrees
	var new_direction_angle = current_direction - random_degree_change
	change_direction(new_direction_angle)


func change_direction(new_direction_angle):
	direction = Vector2.DOWN.rotated(new_direction_angle) 
	change_sprite_texture()
	print(direction)


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


func change_sprite_texture():
	var new_texture = load(get_new_sprite_texture())
	$Sprite.set_texture(new_texture)


func get_new_sprite_texture():
	var animation_direction = get_diagonal_direction_name(direction)
	var animation_png = person_type + "-"
	
	match animation_direction:
		"down-left": animation_png += "frontleft"
		"down-right": animation_png += "frontright"
		"up-left": animation_png += "retroleft"
		"up-right": animation_png += "retroright"
		_: print("match animation_direction error, text=" + animation_direction)
	
	var animation_png_path : String = "res://assets/level 1/people/" + person_type + "/" + animation_png + ".png"
	return animation_png_path


#inspired by https://www.davidepesce.com/2019/11/12/godot-tutorial-10-monsters-and-artificial-intelligence/
