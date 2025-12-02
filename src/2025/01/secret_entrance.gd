@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> PackedStringArray:
	var content = Utils.file_lines(str("res://src/2025/01/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var zero_count = 0
	var current_val: int = 50
	for d in data:
		var lr: int = 1
		if d.substr(0,1) == "R":
			lr = -1
		var mag: int = int(d.substr(1))
		current_val += lr * mag
		current_val %= 100
		#print("d: %s, lr: %d, mag: %d, current_val: %d" % [d, lr, mag, current_val])
		if current_val == 0:
			zero_count += 1
	return zero_count

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	return 0
