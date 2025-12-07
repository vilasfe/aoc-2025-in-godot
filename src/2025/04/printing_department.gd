@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/04/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var reachable: int = 0
	for r in range(data.size()):
		for c in range(data[r].length()):
			# do the 3x3 sampler
			if data[r][c] != '@':
				continue # skip checks if not a @

			var sample_sum: int = 0
			if (r-1) >= 0:
				if (c-1) >= 0 && data[r-1][c-1] == '@':
					sample_sum += 1
				if data[r-1][c] == '@':
					sample_sum += 1
				if (c+1) < data[r-1].length() && data[r-1][c+1] == '@':
					sample_sum += 1
			if (c-1) >= 0 && data[r][c-1] == '@':
				sample_sum += 1
			if (c+1) < data[r].length() && data[r][c+1] == '@':
				sample_sum += 1
			if (r+1) < data.size():
				if (c-1) >= 0 && data[r+1][c-1] == '@':
					sample_sum += 1
				if data[r+1][c] == '@':
					sample_sum += 1
				if (c+1) < data[r+1].length() && data[r+1][c+1] == '@':
					sample_sum += 1
			# check the results of the sampler
			if sample_sum < 4:
				reachable += 1
	return reachable

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
