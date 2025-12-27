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
	var graph: AocGraph = AocGraph.new()
	for d in data:
		var split_d = d.split(":")
		var src = split_d[0]
		for dest in split_d[1].split(" ", false):
			graph.connect_nodes(src, dest, AocGraph.ConnectionDirection.UNIDIRECTIONAL)

	var svr_to_dac = graph.count_paths("svr", "dac")
	var svr_to_fft = graph.count_paths("svr", "fft")
	var dac_to_fft = graph.count_paths("dac", "fft")
	var fft_to_dac = graph.count_paths("fft", "dac")
	var dac_to_out = graph.count_paths("dac", "out")
	var fft_to_out = graph.count_paths("fft", "out")

	# do a manual version of menger's theorem since
	# the condensed graph is so small
	var coarsened_paths = [[svr_to_dac, dac_to_fft, fft_to_out],
		[svr_to_fft, fft_to_dac, dac_to_out]]
	
	var total: int = 0
	for p in coarsened_paths:
		total += p.reduce(func(accum: int, e: int) -> int: return accum * e, 1)

	graph.queue_free()
	return total

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
