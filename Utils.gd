@tool
extends Node
class_name Utils

static func file_content(fpath) -> String:
	if not FileAccess.file_exists(fpath):
		#Log.warn("file does not exist", fpath)
		return ""

	var file = FileAccess.open(fpath, FileAccess.READ)
	var content = file.get_as_text()

	return content

static func file_lines(fpath) -> PackedStringArray:
	var content = file_content(fpath)

	return content.split("\n", false)

# Sorts an array of Vector2 points in clockwise order
static func sort_points_clockwise(points_array: PackedVector2Array) -> PackedVector2Array:
	if points_array.size() <= 1:
		return points_array

	# 1. Calculate the center point
	var center: Vector2 = Vector2.ZERO
	for p in points_array:
		center += p
	center /= points_array.size()

	# Convert PackedVector2Array to a standard Array for sort_custom to work
	var sorted_array = Array(points_array)
	
	# 3. Use sort_custom()
	# Note: Godot's 2D Y-axis points downward, which means standard angle calculation 
	# results in a counter-clockwise sort by default. 
	# To achieve a clockwise sort, we simply reverse the comparison.
	sorted_array.sort_custom(func(a: Vector2, b: Vector2) -> bool: return _sort_func_clockwise(a, b, center))

	return PackedVector2Array(sorted_array)

# Custom sort comparison function
static func _sort_func_clockwise(a: Vector2, b: Vector2, center: Vector2) -> bool:
	# Calculate relative vectors from center
	var rel_a: Vector2 = a - center
	var rel_b: Vector2 = b - center

	# Compare angles using 'angle()'. 
	# Returning 'rel_a.angle() > rel_b.angle()' sorts clockwise in Godot's 2D coordinate system.
	return rel_a.angle() > rel_b.angle()
