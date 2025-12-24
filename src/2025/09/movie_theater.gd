@tool
extends Node

func _ready():
	if Engine.is_editor_hint():
		request_ready()

func launch_gui_disable():
	for child in get_children():
		child.show()

	var data = input("input")
	var min_x: int = data[0].x
	var max_x: int = data[0].x
	var min_y: int = data[0].y
	var max_y: int = data[0].y
	for d in data:
		min_x = min(min_x, d.x)
		max_x = max(max_x, d.x)
		min_y = min(min_y, d.y)
		max_y = max(max_y, d.y)

	var scale_factor: Vector2 = Vector2(get_parent().size.x * 1.0 / max_x, get_parent().size.y * 1.0 / max_y)
	scale_factor /= 5
	print(scale_factor)

	var upper_left: Vector2 = Vector2(min_x, min_y) * scale_factor
	print(upper_left)

	var p: Polygon2D = Polygon2D.new()
	p.set_polygon(data)
	p.apply_scale(scale_factor)
	p.set_position(get_parent().size / 2 - Vector2i(upper_left))
	p.color = Color.GREEN
	p.vertex_colors = [Color.RED]
	
	#var p: Line2D = Line2D.new()
	#p.set_points(PackedVector2Array(data))
	#p.set_closed(true)
	#p.apply_scale(scale_factor)
	#p.set_position(get_parent().size / 2 - Vector2i(upper_left))
	#p.set_default_color(Color.GREEN)

	add_child(p)

static func input(fname: String) -> Array[Vector2i]:
	var content = Utils.file_lines(str("res://src/2025/09/", fname, ".txt"))
	var to_return: Array[Vector2i] = []
	for c in content:
		var s = c.split(",")
		to_return.push_back(Vector2i(s[0].to_int(), s[1].to_int()))
	return to_return

func calc_part_one(data: Array[Vector2i]) -> int:
	var max_rect: int = 0
	for v_src in range(data.size()):
		for v_dest in range(v_src+1, data.size()):
			var rect_size = (abs(data[v_src].x - data[v_dest].x) + 1) * (abs(data[v_src].y - data[v_dest].y) + 1)
			max_rect = max(max_rect, rect_size)
	return max_rect

func calc_part_two(data: Array[Vector2i]) -> int:
	var max_rect: int = 0
	var sorted_data = Utils.sort_points_clockwise(data)
	for v_src in range(data.size()):
		for v_dest in range(v_src+1, data.size()):
			if data[v_src].x != data[v_dest].x && data[v_src].y != data[v_dest].y:
				var new_poly: PackedVector2Array = []
				new_poly.push_back(data[v_src])
				new_poly.push_back(Vector2i(data[v_src].x, data[v_dest].y))
				new_poly.push_back(data[v_dest])
				new_poly.push_back(Vector2i(data[v_dest].x, data[v_src].y))
				var sorted_poly = Utils.sort_points_clockwise(new_poly)
				#var i = Geometry2D.clip_polygons(sorted_poly, sorted_data)
				#if i.is_empty():
				#	var rect_size = (abs(sorted_poly[0].x - sorted_poly[2].x) + 1) * (abs(sorted_poly[0].y - sorted_poly[2].y) + 1)
				#	max_rect = max(max_rect, rect_size)
				var i = Geometry2D.intersect_polygons(data, sorted_poly)
				if i.size() == 1:
					var sorted_i = Utils.sort_points_clockwise(i[0])
					if sorted_i == sorted_poly:
						var rect_size = (abs(sorted_poly[0].x - sorted_poly[2].x) + 1) * (abs(sorted_poly[0].y - sorted_poly[2].y) + 1)
						max_rect = max(max_rect, rect_size)
	return max_rect

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
