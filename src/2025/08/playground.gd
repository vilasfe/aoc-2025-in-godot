@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/08/", fname, ".txt"))
	return content

class JunctionBox:
	var v: Vector3i
	
	func _init(coords: String) -> void:
		var c = coords.split(",")
		v = Vector3i(c[0].to_int(), c[1].to_int(), c[2].to_int())

class JBEdge:
	var src: JunctionBox
	var dest: JunctionBox
	var cost: float
	
	func _init(s: JunctionBox, d: JunctionBox) -> void:
		src = s
		dest = d
		cost = s.v.distance_to(d.v)

func find_cluster_key_for(clusters: Dictionary, value: JunctionBox) -> int:
	for k in clusters:
		if clusters[k].has(value):
			return k
	return 0

func calc_part_one(data: PackedStringArray, max_iterations: int) -> int:
	# Transform the array of strings into an array of boxes
	var boxes: Array = []
	for d in data:
		boxes.push_back(JunctionBox.new(d))
	
	# Enumerate all the edges and sort by least cost
	var edges: Array = []
	for b_src in range(boxes.size()):
		for b_dest in range(b_src+1, boxes.size()):
			edges.push_back(JBEdge.new(boxes[b_src], boxes[b_dest]))
	edges.sort_custom(func(a: JBEdge, b: JBEdge) -> bool: return a.cost < b.cost)

	# Build the clusters (circuits)
	# use an int for the key and an array of boxes for the value
	var clusters: Dictionary = {}
	# let 0 be "not found"
	var max_cluster_id: int = 1
	var iterations: int = 0
	for e in edges:
		var src_idx: int = find_cluster_key_for(clusters, e.src)
		var dest_idx: int = find_cluster_key_for(clusters, e.dest)
		
		# if neither index is found then add them both as a new cluster
		if src_idx == 0 && dest_idx == 0:
			clusters.set(max_cluster_id, [e.src, e.dest])
			max_cluster_id += 1
		# If the source is found but not dest then add dest to the src cluster
		elif src_idx != 0 && dest_idx == 0:
			clusters[src_idx].push_back(e.dest)
		# Same thing for the reverse scenario
		elif src_idx == 0 && dest_idx != 0:
			clusters[dest_idx].push_back(e.src)
		# If both are found and not the same cluster then merge the clusters
		elif src_idx != 0 && dest_idx != 0 && src_idx != dest_idx:
			clusters[src_idx].append_array(clusters[dest_idx])
			clusters[dest_idx].clear()
		iterations += 1
		if iterations >= max_iterations:
			break

	var cluster_sizes: Array = []
	for c in clusters:
		cluster_sizes.push_back(clusters[c].size())
	cluster_sizes.sort()
	cluster_sizes.reverse()

	return cluster_sizes[0] * cluster_sizes[1] * cluster_sizes[2]

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data, 1000)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
