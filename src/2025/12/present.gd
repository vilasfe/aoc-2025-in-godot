extends RefCounted

class_name Present

var _points: PackedVector2Array
var _bb: Rect2

func _init(shape: PackedStringArray) -> void:
	_points = []
	for line in shape.size():
		for c in shape[line].length():
			if shape[line][c] == "#":
				_points.push_back(Vector2i(line, c))

	# cache the bounding box
	var min_point: Vector2i = _points[0]
	var max_point: Vector2i = _points[0]
	for p in _points:
		min_point.x = min(min_point.x, p.x)
		min_point.y = min(min_point.y, p.y)
		max_point.x = max(max_point.x, p.x+1)
		max_point.y = max(max_point.y, p.y+1)
	_bb = Rect2i(min_point, max_point - min_point)

func bounding_box() -> Rect2:
	return _bb

func cell_count() -> int:
	return _points.size()
