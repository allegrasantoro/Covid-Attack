extends KinematicBody2D

export(float) var speed

var direction = Vector2(0,0)

func _process(_delta):
	move()
	pass


func move():
	position += speed * direction
