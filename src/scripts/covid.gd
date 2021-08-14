extends Area2D

export(float) var speed
export(int) var infection_radius

var direction = Vector2(1,0)

func _process(_delta):
	move()


func move():
	position += speed * direction


func _input(event):
	if event.is_action_pressed("covid_up"):
		direction = Vector2(0, -1)
	if event.is_action_pressed("covid_down"):
		direction = Vector2(0, 1)
	if event.is_action_pressed("covid_right"):
		direction = Vector2(1, 0)
	if event.is_action_pressed("covid_left"):
		direction = Vector2(-1, 0)
