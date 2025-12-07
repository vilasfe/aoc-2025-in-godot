@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Dictionary:
	var content = Utils.file_lines(str("res://src/2025/05/", fname, ".txt"))
	var good_ranges: Array[Array] = []
	var to_check: Array[int] = []
	for c in content:
		if c.contains("-"):
			var r = c.split("-")
			good_ranges.append([r[0].to_int(),r[1].to_int()])
		else:
			to_check.append(c.to_int())
	return {"good_ranges": good_ranges, "to_check": to_check}

func calc_part_one(data: Dictionary) -> int:
	var good: int = 0
	for i in data.get("to_check"):
		var found: bool = false
		for r in data.get("good_ranges"):
			if i >= r[0] && i <= r[1]:
				found = true
				break
		if found:
			good += 1
	return good

# this should be a lambda, but breaking out for debugging
func accum_range(accum: int, e: Array) -> int:
	return accum + e[1] - e[0] + 1

func calc_part_two(data: Dictionary) -> int:
	var sorted_ranges: Array[Array] = data.get("good_ranges")
	sorted_ranges.sort()
	var merged_ranges: Array[Array] = []
	for r in sorted_ranges:
		var merged_index: int = -1
		for m in range(merged_ranges.size()):
			if (r[0] >= merged_ranges[m][0] && r[0] <= merged_ranges[m][1]) || (r[1] >= merged_ranges[m][0] && r[1] <= merged_ranges[m][1]):
				merged_index = m
		if merged_index == -1:
			merged_ranges.append(r)
		else:
			merged_ranges[merged_index] = [min(merged_ranges[merged_index][0], r[0]), max(merged_ranges[merged_index][1], r[1])]
	var to_return: int = merged_ranges.reduce(accum_range, int(0))
	return to_return

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
