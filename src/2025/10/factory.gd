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
		var graph: AocGraph = AocGraph.new()
		
		# now connect the edges based on the move masks
		for m in d["moves"]:
			var split_m = m.substr(1, m.length()-2).split(",")
			var mask: int = 0
			for s in split_m:
				mask += 2**s.to_int()
			for src in max_node:
				graph.connect_nodes(str(src), str(src ^ mask)) 
		var parent = graph.bfs(str(0))
		var path = graph.reconstruct_path(parent, str(goal_int))
		total += path.size() - 1
		graph.queue_free()
	return total

func calc_machine_two(machine: Dictionary) -> int:
	# The BFS approach for Part 1 involves enumerating
	# the state space which is far too large for Part 2.
	# There is a neat trick online for using recursion,
	# but it has been a few years since I wrote a simplex
	# solver and it seemed like fun practice
	
	# Let each move be an equation where each variable
	# is a joltage variable and its coefficent is a
	# mask for modifying that variable or not (0,1)
	# to create matrix A
	# Let the joltage array be vector b
	# Let the objective function have a negative mask
	# for all joltage values (so we max instead of min)
	# and coefficients for number of button presses

	var jolt_numeric: Array[int] = []
	for j in machine["joltage"].substr(1, machine["joltage"].length()-1).split(","):
		jolt_numeric.push_back(j.to_int())

	var tableau: Matrix = Matrix.new(jolt_numeric.size()+1,machine["moves"].size()+2, 0.0)

	# Add each constraint row
	for j in jolt_numeric.size():
		tableau.cells[j][tableau.cols()-1] = float(jolt_numeric[j])
		for m in machine["moves"].size():
			var m_numeric: Array[int] = []
			for s in machine["moves"][m].substr(1, machine["moves"][m].length()-2).split(","):
				m_numeric.push_back(s.to_int())
			for mn in m_numeric.size():
				if j == m_numeric[mn]:
					tableau.cells[j][m] = 1.0

	# Setup last-row objective function
	tableau.cells.back().fill(1.0)
	tableau.cells.back()[tableau.cols()-2] = 1.0
	tableau.cells.back()[tableau.cols()-1] = 0.0

	print(tableau)
	var solver: SimplexSolver = SimplexSolver.new(tableau)
	var result = solver.solve()
	print(result)
	print("solved")
	var total = result.reduce(func(accum: float, e: float) -> float: return accum + e, 0.0)
	print(total)
	# too high 1185943
	return total

func calc_part_two(data: Array[Dictionary]) -> int:
	#return data.slice(2).reduce(func(accum: int, e: Dictionary) -> int:
	return data.reduce(func(accum: int, e: Dictionary) -> int:
		return accum + calc_machine_two(e)
		,0)

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
