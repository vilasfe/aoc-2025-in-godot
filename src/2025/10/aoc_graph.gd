extends Node

class_name AocGraph

@onready var nodes: Dictionary[String,AocGraphNode] = {}

func connect_nodes(src: String, dest: String) -> void:
	if ! nodes.get_or_add(src, AocGraphNode.new()).neighbors.has(dest):
		nodes[src].neighbors.append(dest)
	if ! nodes.get_or_add(dest, AocGraphNode.new()).neighbors.has(src):
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
