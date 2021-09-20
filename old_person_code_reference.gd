extends KinematicBody2D

var person_type = "Mark"
var direction = Vector2()
var random_number = RandomNumberGenerator.new()
export var speed : = 100.0
var current_direction

func _ready():
	$AnimationPlayer.play("walking")
	new_direction()
	
	
func _physics_process(delta):
	var movement = direction * speed * delta
	
	var collision = move_and_collide(movement)

func _on_change_direction_timer_timeout():
	change_direction()
	
func new_direction():
	random_number.randomize()
	current_direction = random_number.randf() * 2 * PI
	direction = Vector2.DOWN.rotated(current_direction)
	change_sprite_texture()
	
func change_direction():
	random_number.randomize()
	var random_degree_change = rand_range(0.785398, -0.785398) #0.785398 radians is 45 degrees
	var new_direction_angle = current_direction - random_degree_change
	direction = Vector2.DOWN.rotated(new_direction_angle) 
	change_sprite_texture()
	print(new_direction_angle)
	
func get_animation_direction():
	var norm_direction = direction.normalized()
	
	if norm_direction.y >= 0 and norm_direction.x <= 0:
		return "down-left"
	elif norm_direction.y >= 0 and norm_direction.x > 0: 
		return "down-right"
	elif norm_direction.y <= 0 and norm_direction.x <= 0: 
		return "up-left"
	else:
		return "up-right"

func change_sprite_texture():
	var new_texture = load(get_new_sprite_texture())
	$Sprite.set_texture(new_texture)

func get_new_sprite_texture():
	var animation_direction = get_animation_direction()
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
