@tool
extends Node

func _ready():
	if Engine.is_editor_hint():
		request_ready()

func launch_gui_disable():
	for child in get_children():
		child.show()


static func input(fname: String) -> PackedStringArray:
	var content = Utils.file_content(str("res://src/2025/12/", fname, ".txt")).split("\n", true)
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var tree_space: Array[TreeArea] = []
	var presents: Array[Present] = []
	var start: int = -1
	var no_more_presents: bool = false
	for d in data.size():
		if data[d].contains("x"):
			var t: TreeArea = TreeArea.new()
			var split_d = data[d].split(":")
			var size_str = split_d[0].split("x")
			t.size = Vector2i(size_str[0].to_int(), size_str[1].to_int())
			var gifts_str = split_d[1].split(" ", false)
			for g in gifts_str:
				t.gifts.push_back(g.to_int())
			tree_space.push_back(t)
			print(t)
			no_more_presents = true
		elif data[d].contains(":"):
			start = d+1
			print("Starting new present at " + str(d+1))
		elif data[d].strip_edges().is_empty():
			if !no_more_presents && start >= 0:
				print("Making new present from " + str(start) + " to " + str(d))
				presents.push_back(Present.new(data.slice(start, d)))
			start = -1

	# ok, done parsing input...  now for the fun stuff
	var fit_without_packing: Array[TreeArea] = []
	var no_way: Array[TreeArea] = []
	var hard_way: Array[TreeArea] = []

	while !tree_space.is_empty():
		var t = tree_space.pop_front()
		print(t)
		var total_area = t.size.x * t.size.y
		print(presents[3].bounding_box())
		var present_max_size: int = Utils.array_dot_product(
			presents.map(func(e: Present) -> int: return int(e.bounding_box().get_area())),
			Array(t.gifts)
		)
		var present_min_size: int = Utils.array_dot_product(
			presents.map(func(e: Present) -> int: return e.cell_count()),
			Array(t.gifts)
		)
		
		print("Total Area: " + str(total_area))
		print("Present max: " + str(present_max_size))
		print("Present min: " + str(present_min_size))
		if present_max_size <= total_area:
			fit_without_packing.push_back(t)
			print("Adding to no-packing: " + str(t))
		elif present_min_size > total_area:
			no_way.push_back(t)
			print("Adding to no-way: " + str(t))
		else:
			hard_way.push_back(t)
			print("Adding to hard-way: " + str(t))

	if ! hard_way.is_empty():
		print("WARNING: you need to implement bin packing")

	# this is really just the upper bound unless we implement bin packing
	# to actually address the hard_way array
	return fit_without_packing.size() + hard_way.size()

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
