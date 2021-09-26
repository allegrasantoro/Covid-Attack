extends KinematicBody2D


export (int) var speed

var friction = 0.5
var acceleration = 0.1
var velocity = Vector2.ZERO


func _ready():
	#$AnimationPlayer.play("covid idle")
	pass


func _physics_process(_delta):
	manage_velocity()
	velocity = move_and_slide(velocity)


func manage_velocity():
	var direction = get_input() 
	
	#var moving = 
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)#normalised to avoid quicker movements on diagonals
		#I want the velocity to reach the product of the direction vector and speed in intervals of the int acceleration per frame
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		#I want the velocity to reach zero in intervals of the int friction per frame


func get_input():
	var input = Vector2()
	if Input.is_action_pressed("covid_up"):
		input.y -= 1
	if Input.is_action_pressed("covid_down"):
		input.y += 1
	if Input.is_action_pressed("covid_right"):
		input.x += 1
	if Input.is_action_pressed("covid_left"):
		input.x -= 1
	return input
