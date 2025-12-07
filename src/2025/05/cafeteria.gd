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

func calc_part_two(data: Dictionary) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
