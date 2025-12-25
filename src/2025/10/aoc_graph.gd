extends Node

class_name AocGraph

@onready var nodes: Array[AocGraphNode] = []

# node_index: Array[int] of neighbor indices
@onready var edges: Dictionary = {}

func _init(size: int) -> void:
	nodes.resize(size)
	for n in size:
		edges[n] = []

func connect_nodes(src: int, dest: int) -> void:
	if ! edges[src].has(dest):
		edges[src].append(dest)
		edges[src].sort()
	if ! edges[dest].has(src):
		edges[dest].append(src)
		edges[dest].sort()

enum VisitColors {
	OPEN,
	QUEUED,
	CLOSED
}

# returns array of parents
func bfs(src: int) -> Array[int]:
	var visited: Array[VisitColors] = []
	visited.resize(nodes.size())
	visited.fill(VisitColors.OPEN)
	var parent: Array[int] = []
	parent.resize(nodes.size())
	parent.fill(-1)
	var queue: Array[int] = []

	queue.push_back(src)
	visited[src] = VisitColors.QUEUED
	while ! queue.is_empty():
		var current = queue.pop_front()
		visited[current] = VisitColors.CLOSED
		for n in edges[current]:
			if visited[n] == VisitColors.OPEN:
				queue.push_back(n)
				parent[n] = current
				visited[n] = VisitColors.QUEUED

	return parent

func reconstruct_path(parent_map: Array[int], target_node: int) -> Array[int]:
	var path: Array[int] = []
	var current = target_node
	while current != -1 && path.size() < parent_map.size():
		path.push_back(current)
		current = parent_map[current]
	path.reverse()
	return path
