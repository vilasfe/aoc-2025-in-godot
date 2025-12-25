@tool
extends Node

func _ready():
	if Engine.is_editor_hint():
		request_ready()

func launch_gui_disable():
	for child in get_children():
		child.show()


static func input(fname: String) -> Array[Dictionary]:
	var content = Utils.file_lines(str("res://src/2025/10/", fname, ".txt"))
	var to_return: Array[Dictionary] = []
	for line in content:
		var split_line = line.split(" ")
		var machine: Dictionary = {}
		machine["goal"] = split_line[0]
		machine["joltage"] = split_line[-1]
		machine["moves"] = split_line.slice(1, -1)
		to_return.push_back(machine)
	return to_return


func calc_part_one(data: Array[Dictionary]) -> int:
	var total: int = 0
	for d in data:
		var goal_int: int = 0
		for i in d["goal"].length():
			if d["goal"][i] == '#':
				goal_int += 2**(i-1)

		# build the machine
		var max_node = 2**(d["goal"].length()-2)
		var graph: AocGraph = AocGraph.new(max_node)
		
		# now connect the edges based on the move masks
		for m in d["moves"]:
			var split_m = m.substr(1, m.length()-2).split(",")
			var mask: int = 0
			for s in split_m:
				mask += 2**s.to_int()
			for src in max_node:
				graph.connect_nodes(src, src ^ mask) 
		var parent = graph.bfs(0)
		var path = graph.reconstruct_path(parent, goal_int)
		total += path.size() - 1
		graph.queue_free()
	return total

func calc_part_two(data: Array[Dictionary]) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
