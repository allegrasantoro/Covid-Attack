extends Area2D

export(float) var speed

var direction = Vector2(1,0)

func _process(_delta):
	move()


func move():
	position += speed * direction
