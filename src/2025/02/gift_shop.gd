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

func repeat_match(s: String, match_len: int) -> bool:
	if s.length() % match_len != 0:
		return false
	var regex = RegEx.new()
	# print("(\\d{%d})\\1{%d}" % [l-1, d[0].length() / l])
	var reg_str = "(\\d{%d})\\1+" % [match_len]
	# print(reg_str)
	regex.compile(reg_str)
	var result = regex.search(s)
	if result && result.get_string() == s:
		# print(result.get_string())
		return true
	return false

func calc_part_two(data: Array) -> int:
	var bad_id_sum: int = 0

	for d in data:
		var min_val: int = int(d[0])
		var max_val: int = int(d[1])
		for i in range(min_val, max_val+1):
			var found: bool = false
			for l:int in range(1, d[1].length()+1):
				if d[0].length() % l == 0:
					if repeat_match(str(i), l):
						found = true

				elif !found && d[1].length() > d[0].length() && d[1].length() % l == 0:
					if repeat_match(str(i), l):
						found = true

			if found:
				bad_id_sum += i
			found = false
	return bad_id_sum

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
