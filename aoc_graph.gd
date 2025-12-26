extends Node

class_name AocGraph

@onready var nodes: Dictionary[String,AocGraphNode] = {}

enum ConnectionDirection {
	BIDIRECTIONAL,
	UNIDIRECTIONAL
}

func connect_nodes(src: String, dest: String, dir: ConnectionDirection = ConnectionDirection.BIDIRECTIONAL) -> void:
	if ! nodes.has(src):
		var tmp: AocGraphNode = AocGraphNode.new()
		add_child(tmp)
		nodes.set(src, tmp)
	if ! nodes.has(dest):
		var tmp: AocGraphNode = AocGraphNode.new()
		add_child(tmp)
		nodes.set(dest, tmp)
	
	if ! nodes[src].neighbors.has(dest):
		nodes[src].neighbors.append(dest)
	
	if dir == ConnectionDirection.BIDIRECTIONAL:
		if ! nodes[dest].neighbors.has(src):
			nodes[dest].neighbors.append(src)

enum VisitColors {
	OPEN,
	QUEUED,
	CLOSED
}

# returns map of parents
func bfs(src: String) -> Dictionary[String,String]:
	var visited: Dictionary[String,VisitColors] = {}
	for n in nodes.keys():
		visited[n] = VisitColors.OPEN
	var parent: Dictionary[String,String] = {}
	for n in nodes.keys():
		parent[n] = ""
	var queue: Array[String] = []

	queue.push_back(src)
	visited[src] = VisitColors.QUEUED
	while ! queue.is_empty():
		var current = queue.pop_front()
		visited[current] = VisitColors.CLOSED
		for n in nodes[current].neighbors:
			if visited[n] == VisitColors.OPEN:
				queue.push_back(n)
				parent[n] = current
				visited[n] = VisitColors.QUEUED

	return parent

func reconstruct_path(parent_map: Dictionary[String,String], target_node: String) -> PackedStringArray:
	var path: Array[String] = []
	var current = target_node
	while !current.is_empty() && path.size() < parent_map.size():
		path.push_back(current)
		current = parent_map[current]
	path.reverse()
	return path

func indegree(node_name: String) -> int:
	var total = 0
	for n in nodes:
		if n != node_name:
			if nodes[n].neighbors.has(node_name):
				total += 1
	return total

func topological_sort() -> Array[String]:
	var in_deg: Dictionary[String, int] = {}
	for n in nodes:
		in_deg[n] = indegree(n)
	
	# Perform topological sort using Kahn's algorithm
	var queue: Array[String] = []
	for n in nodes:
		if in_deg[n] == 0:
			queue.push_back(n)

	var topo_order: Array[String] = []
	while ! queue.is_empty():
		var n = queue.pop_front()
		topo_order.push_back(n)

		for neighbor in nodes[n].neighbors:
			in_deg[neighbor] -= 1
			if in_deg[neighbor] == 0:
				queue.push_back(neighbor)

	return topo_order

func count_paths(src: String, dest: String) -> int:
	# Array to store number of ways to reach each node
	var ways: Dictionary[String, int] = {}
	for n in nodes:
		ways.set(n, 0)

	ways[src] = 1

	var topo_order = topological_sort()

	# Traverse in topological order
	for node in topo_order:
		for neighbor in nodes[node].neighbors:
			ways[neighbor] += ways[node]
	return ways[dest]
