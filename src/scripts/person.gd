extends "res://src/scripts/movable.gd"

var movement_rotation = 0


func _on_new_diriction_timer_timeout():
	direction = new_direction()


func new_direction():
	movement_rotation = movement_rotation + rand_range(-25, 25)
	return direction.rotated(movement_rotation)
