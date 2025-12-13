@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


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
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
