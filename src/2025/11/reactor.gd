@tool
extends Node

func _ready():
	if Engine.is_editor_hint():
		request_ready()

func launch_gui_disable():
	for child in get_children():
		child.show()


static func input(fname: String) -> PackedStringArray:
	var content = Utils.file_lines(str("res://src/2025/11/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var graph: AocGraph = AocGraph.new()
	for d in data:
		var split_d = d.split(":")
		var src = split_d[0]
		for dest in split_d[1].split(" ", false):
			graph.connect_nodes(src, dest, AocGraph.ConnectionDirection.UNIDIRECTIONAL)
	var paths = graph.count_paths("you", "out")
	graph.queue_free()
	return paths

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
