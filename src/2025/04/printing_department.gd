@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/04/", fname, ".txt"))
	return content

func get_reachable_rolls(data: PackedStringArray) -> Array[Array]:
	var to_return: Array[Array] = []
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
				to_return.append([r,c])
	return to_return

func calc_part_one(data: PackedStringArray) -> int:
	return get_reachable_rolls(data).size()

func calc_part_two(data: PackedStringArray) -> int:
	var first: bool = true
	var removed_total: int = 0
	var removed_this_check: int = 0
	while first || removed_this_check > 0:
		first = false
		var to_remove = get_reachable_rolls(data)
		removed_this_check = to_remove.size()
		removed_total += removed_this_check
		for r in to_remove:
			data[r[0]][r[1]] = '.'
	return removed_total

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
