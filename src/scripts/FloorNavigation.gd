extends Navigation2D


var path = []

var PointInPolygonGenerator = load("res://src/scripts/PointInPolygonGenerator.gd").new()


func generate_random_point():
	return PointInPolygonGenerator.get_random_point_in_polygon()


func go_to_current_point(end_position):
	path = get_simple_path(position, end_position, true)
	path.remove(0)
	set_process(true)


