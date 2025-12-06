@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/02/", fname, ".txt"))
	var ranges = content[0].split(",")
	var to_return: Array = []
	for r in ranges:
		var d = r.split("-")
		to_return.append(d)
	return to_return

func calc_part_one(data: Array) -> int:
	var bad_id_sum: int = 0
	for d in data:
		if d[0].length() % 2 == 1 && d[1].length() == d[0].length():
			continue
		var min_val: int = int(d[0])
		var max_val: int = int(d[1])
		var low: int = int(d[0].substr(0, d[0].length() / 2)) if d[0].length() % 2 == 0 else int(d[0].substr(0, max(1, d[0].length() / 2 - 1)))
		var high: int = int(d[1].substr(0, d[1].length() / 2)) if d[1].length() % 2 == 0 else int(d[1].substr(0, d[1].length() / 2 + 1))
		for i in range(int(low)-1, int(high)+2):
			var to_test: int = int("%d%d" % [i, i])
			if to_test >= min_val && to_test <= max_val:
				bad_id_sum += to_test
	return bad_id_sum

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	# var data = input("input")
	return 0
