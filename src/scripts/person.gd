extends KinematicBody2D


var PersonCollision = preload("res://src/scripts/PersonCollision.gd").new()
var DirectionName = preload("res://src/scripts/DirectionName.gd").new()

var can_exit

export var speed : = 100.0
var person_type = "Mark"
onready var animation_player = $AnimationPlayer
var direction = Vector2()
var random_number = RandomNumberGenerator.new()
var current_direction


func _ready():
	animation_player.play("walking")
	can_exit = false
	new_initial_direction()


func _physics_process(delta):
	var movement = direction * speed * delta
	var collision = move_and_collide(movement)
	if collision:
		direction = PersonCollision.manage_collision(collision, direction)
		change_sprite_texture()


func new_initial_direction():
	random_number.randomize()
	current_direction = random_number.randf() * 2 * PI
	change_direction(current_direction)


func _on_change_direction_timer_timeout():
	new_random_direction()


func _on_CanExit_timeout():
	can_exit = true
	
	
func new_random_direction():
	random_number.randomize()
	var random_degree_change = rand_range(0.785398, -0.785398) #0.785398 radians is 45 degrees
	var new_direction_angle = current_direction - random_degree_change
	change_direction(new_direction_angle)


func change_direction(new_direction_angle):
	direction = Vector2.DOWN.rotated(new_direction_angle) 
	change_sprite_texture()
	#print(direction)


func change_sprite_texture():
	var new_texture = load(get_new_sprite_texture())
	$Sprite.set_texture(new_texture)


func get_new_sprite_texture():
	var animation_direction = DirectionName.get_diagonal_direction_name(direction)
	var animation_png = person_type + "-"
	
	match animation_direction:
		"down-left": animation_png += "frontleft"
		"down-right": animation_png += "frontright"
		"up-left": animation_png += "retroleft"
		"up-right": animation_png += "retroright"
		_: print("match animation_direction error, text=" + animation_direction)
	
	var animation_png_path : String = "res://assets/level 1/people/" + person_type + "/" + animation_png + ".png"
	return animation_png_path


func destroy(animation_name): 
	animation_player.play(animation_name)
	yield(animation_player, "animation_finished" )
	queue_free()


func _on_bodyArea_body_entered(body):
	if body.is_in_group('Covid'):
		Global.current_score = Global.current_score + 1
		if Global.best_score < Global.current_score:
			Global.best_score = Global.current_score
		destroy("infected")
