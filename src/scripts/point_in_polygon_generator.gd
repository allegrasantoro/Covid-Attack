extends Node


func get_random_point_in_polygon(collision_polygon):
	var polygon_array = PoolVector2Array(collision_polygon.polygon)
	var triangulated_polygon_array = Geometry.triangulate_polygon(polygon_array)
	var triangle_points_coordinates = get_coordinates_of_points_in_polygon(triangulated_polygon_array, collision_polygon.polygon)
	var triangles_areas_arrays = get_areas_of_triangles(triangulated_polygon_array, collision_polygon.polygon, triangle_points_coordinates)
	var chosen_triangle_point = triangle_points_coordinates[get_random_triangle_index(triangles_areas_arrays)]
	
	print ("triangle_points_coordinates[0][0]:" + String(triangle_points_coordinates[0][0]))
	
	var vertexA = Vector2(triangle_points_coordinates[0][0])
	var vertexB = Vector2(triangle_points_coordinates[0][1])
	var vertexC = Vector2(triangle_points_coordinates[0][2])
	var point = vertexA + sqrt(randf()) * (-vertexA + vertexB + randf() * (vertexC - vertexB))
	
	print("spawn spoint:" + String(point))
	return point


func get_coordinates_of_points_in_polygon(triangulated_polygon_array, collision_polygon):
	var points_array = []
	var current_triangle = 0
	
	for triangle in len(triangulated_polygon_array) / 3:
		points_array.append([])
		
		for point in range(3):
			#adds point coordinate to array
			points_array[current_triangle].append(collision_polygon[triangulated_polygon_array[(triangle*3)+point]])
		current_triangle += 1
		
	print("points array: " + String(points_array))
	
	return points_array


func get_areas_of_triangles(triangulated_polygon_array, collision_polygon, points_array):
	var areas_array = []
	
	for i in range(0, points_array.size()):
		areas_array.append(get_triangle_area_from_coordinates(points_array[i]))
	
	print(String(areas_array))
	
	return areas_array


func get_triangle_area_from_coordinates(coordinates_array):
#	the creation of these variables is not efficient or necessary, it is just for legibility purposes
#	since storing integers is not very demanding, it will not make a big difference
	var A = Vector2(coordinates_array[0][0], coordinates_array[0][1])
	var B = Vector2(coordinates_array[1][0], coordinates_array[1][1])
	var C = Vector2(coordinates_array[2][0], coordinates_array[2][1])
	
	var area = (A.x * (B.y - C.y) + B.x * (C.y - A.y) + C.x * (A.y - B.y)) /2
	
	return area


func get_random_triangle_index(triangles_areas_arrays):
	var areas_sum = get_sum_of_array(triangles_areas_arrays)
	#getting random number from 0 to the sum of the areas
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randf_range(0, areas_sum)
	
	#by taking the area into consideraion a point in a bigger triangle will not be more likely to be chosen
	for i in range(0, triangles_areas_arrays.size()):
		if random_number < triangles_areas_arrays[i] :
			print("i :" + String(i) + " number:" + String(triangles_areas_arrays[i]))
			return i
		
		print("current i :" + String(i) + " current number:" + String(triangles_areas_arrays[i]))
		random_number -= triangles_areas_arrays[i]
		
	print("error in get_random_triangle_index method")


func get_sum_of_array(array):
	var sum = 0
	for integer in array:
		sum += integer
	print("sum: " + String(sum))
	return sum
