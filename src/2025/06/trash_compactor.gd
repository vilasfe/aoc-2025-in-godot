@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/06/", fname, ".txt"))
	return content

func transpose_input(data: PackedStringArray) -> Array[PackedStringArray]:
	var to_return: Array[PackedStringArray] = []
	for d in data[0].split(" ", false):
		to_return.push_back(PackedStringArray())
		to_return[-1].push_back(d)

	for d in data.slice(1):
		var sp = d.split(" ", false)
		for s in range(sp.size()):
			to_return[s].push_back(sp[s])
	return to_return

func reduce_row(row: PackedStringArray) -> int:
	if row[row.size()-1] == "+":
		return Array(row.slice(0,-1)).reduce(func(accum: int, e: String) -> int: return accum + e.to_int(), 0)
	elif row[row.size()-1] == "*":
		return Array(row.slice(0,-1)).reduce(func(accum: int, e: String) -> int: return accum * e.to_int(), 1)
	else:
		print("ERROR %s" % [row[row.size()-1]])
		return 0

func calc_part_one(data: PackedStringArray) -> int:
	var tr_data = transpose_input(data)
	return tr_data.reduce(func(accum: int, e: PackedStringArray) -> int: return accum + reduce_row(e), 0)

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
